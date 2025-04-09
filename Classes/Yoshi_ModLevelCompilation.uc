/**
*
*   Code by EpicYoshiMaster
*   This subclass defines the functions necessary for a Level Compilation to utilize Mods
*
*/
class Yoshi_ModLevelCompilation extends Yoshi_LevelCompilation
    abstract;

var const string CompilationURL; //For Mod Comps to link their collections
var const bool IsPastIntLimit;

function int OnTimePieceCollected(string Identifier, optional bool ReceivedViaOnline = false, optional int LevelReceived = -1) {
    local CompilationLevel CurrentLevel;

    CurrentLevel = GetCurrentLevel();

    if(CurrentLevel.isMod) {
        class'GameMod'.static.ResetActiveLevelMod();
    }

    return Super.OnTimePieceCollected(Identifier, ReceivedViaOnline, LevelReceived);
}

static function bool IsValidIdentifier(CompilationLevel CL, string Identifier) {
    if(CL.isMod) {
        return true;
    }

    return Super.IsValidIdentifier(CL, Identifier);
}

//Used to open a Steam Collection for Mod Levels
static function OpenCollection()
{
	local string WorkshopURL;

	WorkshopURL = default.CompilationURL;
	class'Hat_GameManager_Base'.static.OpenBrowserURL(WorkshopURL);
}

//
// Process of Control:
//
// Comp Level --(IsDeathWish?)--> StartDeathWishCompLevel Function
//                    |
//                    |---------> Stay Here --------------(IsMod?) --> Stay Here
//                                                           |
//                                                           |-------> Super Function
//
//
function bool StartCompLevel(CompilationLevel CL) {
    local GameModInfo Mod;
    local Hat_ChapterInfo chapter;
    local Texture2D Titlecard;
    local Hat_GameEventsInterface GEI;
    local bool LevelCompilationsVersionCheck;
    local int act, chapterIdOverride;
    local string level, chapterOverride, actOverride, ModPackageName;

    if(CL.isDeathWish || CL.isModDeathWish) {
        StartDeathWishCompLevel(CL);
        return true;
    }

    if(!CL.isMod) {
        return Super.StartCompLevel(CL);
    }

    //This is now a Non-DW Mod Level
    LevelCompilationsVersionCheck = IsOnNewLevelCompsVersion();

    if(LevelCompilationsVersionCheck ? !IsModReady(CL) : !IsModReadyOlderVersion(CL)) {
        Print("Mod not found! Version Check: " $ LevelCompilationsVersionCheck);
        return false;
    }

    Mod = LevelCompilationsVersionCheck ? GetModInfo(CL.WorkshopID) : GetModInfoOlderVersion(CL.WorkshopID);
    ModPackageName = Mod.PackageName;

    level = (CL.Map != "") ? CL.Map : Mod.MapNames[0];
    chapter = (CL.Chapter != None) ? CL.Chapter : None;
    act = (CL.Act > 0) ? CL.Act : 1;
    chapterIdOverride = -2;

    if(CL.isRift >= 1) {
        chapterOverride = "TIME RIFT";
        Titlecard = (CL.isRift == 1) ? Texture2D'Yoshi_LevelComp_Content.Titlecards.Yoshi_ModTimeRift_Water' : Texture2D'Yoshi_LevelComp_Content.Titlecards.Yoshi_ModTimeRift_Purple';
    }
    else {
        chapterOverride = "MOD LEVEL";
        Titlecard = Texture2D'Yoshi_LevelComp_Content.Titlecards.Yoshi_SuperTitlecard';
    }

    actOverride = (CL.ActName != "") ? CL.ActName : Mod.Name;

	class'GameMod'.static.SetActiveLevelMod(ModPackageName);
    DoCustomTransition(level, chapter, act, Titlecard, chapterOverride, actOverride, chapterIdOverride,, CL);
    class'Hat_GlobalTimer'.static.RestartActTimer();

    if(CL.Checkpoint != -1) {
	    `GameManager.SetCurrentCheckpoint(CL.Checkpoint, false);
    }

    foreach `GameEventsArray(GEI)
		GEI.OnPreActSelectMapChange(chapter, act, level);
            
    return true;
}

//
// Process of Control:
//
// Death Wish Comp Level --(IsMod?)--> Stay Here
//                            |
//                            |------> Super Function
// 
//
function StartDeathWishCompLevel(CompilationLevel CL) {
    local Array< Class<Object> > ModDeathWishes;
	local int i;

    if(!CL.isMod || !CL.isModDeathWish) {
        Super.StartDeathWishCompLevel(CL);
        return;
    }

    //This is now a DW Mod Level
	
    //We can't use the actual class so we need to find it via string, this array should be exclusively the right class
	ModDeathWishes = class'Hat_ClassHelper'.static.GetAllScriptClasses(CL.ModDeathWish);

	for (i = 0; i < ModDeathWishes.Length; i++)
	{
        if(string(class<Hat_SnatcherContract_DeathWish>(ModDeathWishes[i]).default.Class) ~= CL.ModDeathWish) {
            CustomPlayDeathWish(class<Hat_SnatcherContract_DeathWish>(ModDeathWishes[i]), CL);
            `SaveManager.GetCurrentSaveData().ActiveDeathWishes.Length = 0;
            `SaveManager.GetCurrentSaveData().ActiveDeathWishes.AddItem(class<Hat_SnatcherContract_DeathWish>(ModDeathWishes[i]));
            class'Hat_GlobalTimer'.static.RestartActTimer();
            if(CL.Checkpoint != -1) {
	            `GameManager.SetCurrentCheckpoint(CL.Checkpoint, false);
            }

            return;
        }
	}
    Print("Failed to find Mod Death Wish " $ CL.ModDeathWish $ " with Act Name " $ CL.ActName);
}

function bool CheckForMissingMods() {
    local bool IsMissingMods;
    local int i;
    local bool LevelCompsVersionCheck;

    LevelCompsVersionCheck = IsOnNewLevelCompsVersion();
    
    if(Levels.Length == 0) {
        LevelsList();
    }

    IsMissingMods = false;
    for(i = 0; i < Levels.Length; i++) {
        if(Levels[i].isMod && LevelCompsVersionCheck ? !IsModReady(Levels[i]) : !IsModReadyOlderVersion(Levels[i])) {
            IsMissingMods = true;
        }
    }
    return IsMissingMods;    
}

static function bool IsModReady(CompilationLevel CL) {
    local int WorkshopIndex;
    WorkshopIndex = FindGameModID(CL.WorkshopID);

    if(WorkshopIndex != INDEX_NONE) {
        if(class'GameMod'.static.IsModInstalled(WorkshopIndex) && class'GameMod'.static.GetModDownloadPercent(WorkshopIndex) == INDEX_NONE) {
            return true;
        }
    }
    return false;
}

//This function IN THEORY should allow older DLC 2 versions to still play Level Comps, albeit without the post-crisis mods
static function bool IsModReadyOlderVersion(CompilationLevel CL) {
    if(class'GameMod'.static.IsModInstalled(int(CL.WorkshopID)) && class'GameMod'.static.GetModDownloadPercent(int(CL.WorkshopID)) == INDEX_NONE) {
        return true;
    }
    return false;
}

//Thanks to Meku for this one, utilized with the new workshop ID system
static function int FindGameModID(string InString) {
    local array<GameModInfo> GMs;
    local int i;

    GMs = class'GameMod'.static.GetModList();
    for(i = 0; i < GMs.Length; i++)
    {
        if (class'GameMod'.static.GetModIDString(GMs[i].WorkshopID) == InString)
            return GMs[i].WorkshopID;
    }
    return INDEX_NONE;
}

static function GameModInfo GetModInfo(string WorkshopID) {
    local int i;
    local Array<GameModInfo> ModList;
    local int WorkshopIndex;
    local GameModInfo Fake;

    WorkshopIndex = FindGameModID(WorkshopID);
    ModList = class'GameMod'.static.GetModList();

    for(i = 0; i < ModList.Length; i++) {
        if(ModList[i].WorkshopID == WorkshopIndex) {
            return ModList[i];
        }
    }
    return Fake;
}

static function GameModInfo GetModInfoOlderVersion(string WorkshopID) {
    local int i;
    local Array<GameModInfo> ModList;
    local GameModInfo Fake;
    ModList = class'GameMod'.static.GetModList();

    for(i = 0; i < ModList.Length; i++) {
        if(ModList[i].WorkshopID == int(WorkshopID)) {
            return ModList[i];
        }
    }
    return Fake;
}

static function bool IsOnNewLevelCompsVersion() {
    local int i;
    local array<GameModInfo> ModList;
    ModList = class'GameMod'.static.GetModList();
    
    for(i = 0; i < ModList.Length; i++) {
        if(ModList[i].WorkshopID > 10000000) {
            return false;
        }
    }
    return true;
}

defaultproperties
{
    CompilationsMap="yoshi_levelcompilations_progress"
}