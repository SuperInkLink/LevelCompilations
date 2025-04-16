/**
*
*   Code by EpicYoshiMaster
*   Level Compilations are grouped sets of levels. This class covers the functionality of the compilation, subclasses define their level compilations.
*   Key functions: 
*   LevelsList - Determines the set of levels played in the compilation, specified by subclasses
*   OnTimePieceCollected - Carries out all tasks for when a Time Piece is grabbed, this function is called from the GameMod class
*   Initialize - The process by which a Level Compilation is started
*
*/
class Yoshi_LevelCompilation extends Yoshi_LevelCompilation_Base
    abstract;

//So we can store names and icons for customs.
struct CustomCompilation {
    var array<CompilationLevel> Levels;
    var string Name;
    var Texture2D Icon;
};

var const int CompilationID;
var const Texture2D Icon;
var const String CompName;

function int OnTimePieceCollected(string Identifier, optional bool ReceivedViaOnline = false, optional int LevelReceived = -1) {
    local CompilationLevel CurrentLevel;
    local CompilationLevel NewLevel;
    
    if(Levels.Length == 0) {
        LevelsList();
    }
    if(!IsInCompilationNum(default.CompilationID) || !ShouldAcceptTimePiece()) {
        return -1;
    }
    CurrentLevel = GetCurrentLevel();

    if(CurrentLevel.TP ~= "Metro_Intro") {
        SetMetroIntroTimePiece(0); //No Longer need to worry about it
    }

    //Just in case they need to be defaulted back
    if(CurrentLevel.isDeathWish) {
        `SaveManager.GetCurrentSaveData().ActiveDeathWishes.Length = 0;
    }

    //Make sure this is the right time piece
    if(IsValidIdentifier(CurrentLevel, Identifier)) {
        Print("Made it past the identifier check!");
        NewLevel = GetNextLevel();

        if(NewLevel.Map != "" || NewLevel.isDeathWish || NewLevel.isMod) {

            //Certain levels require you to reset twice in order to ensure you go to the correct act
            if(CurrentLevel.Chapter == Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro' || CurrentLevel.Map ~= NewLevel.Map) {
                SetDoubleRestart(1);
            }

            SetAcceptTimePiece(false);
            StartCompLevel(NewLevel);
            return 0;
        }
        else {
            OnFinishLastLevel();
            return 1;
        }
    }
    //Something went wrong and the Time Pieces don't match
    else {
        return -1;
    }
}

function OnFinishLastLevel() {

    if(default.CompilationID != 99999) {
        class'Hat_SaveBitHelper'.static.SetLevelBits(string(default.Class), 1, default.CompilationsMap);

        //Timer will no longer be accurate on continues, don't count it as a best time
        if(!GetStartFromContinue()) {
            SetBestTime(class'Hat_GlobalTimer'.static.GetGameTime());
        }
    }

    SetLevelNumber(-1, default.CompilationID);
    SetAcceptTimePiece(true);
    class'Hat_GlobalTimer'.static.Credits();
}

static function InitializeByID(int ID) {
    local int i;
    local array< class<Yoshi_LevelCompilation> > AllLevelComps;
    local Yoshi_LevelCompilation YLC;
    AllLevelComps = GetAllLevelComps();

    for(i = 0; i < AllLevelComps.Length; i++) {
        if(AllLevelComps[i].default.CompilationID == ID) {
            YLC = new AllLevelComps[i];
            YLC.Initialize();
        }
    }
}

static function Yoshi_LevelCompilation ReturnByID(int ID, optional array< class<Yoshi_LevelCompilation> > AllLevelComps) {
    local int i;
    local Yoshi_LevelCompilation YLC;

    if(AllLevelComps.length > 0) {
        for(i = 0; i < AllLevelComps.Length; i++) {
            if(AllLevelComps[i].default.CompilationID == ID) {
                YLC = new AllLevelComps[i];
                return YLC;
            }
        }
    }

    AllLevelComps = GetAllLevelComps();

    for(i = 0; i < AllLevelComps.Length; i++) {
        if(AllLevelComps[i].default.CompilationID == ID) {
            YLC = new AllLevelComps[i];
        }
    }
    return YLC;
}

function Initialize() {
    local CompilationLevel FirstLevel;

    if(Levels.Length == 0) {
        LevelsList();
    }

    Print("Writing CompilationID " $ default.CompilationID);
    
    SetInComp(true);
    SetStartFromContinue(false);
    SetCompilationID(default.CompilationID);
    SetLevelNumber(0, default.CompilationID);
    SetAcceptTimePiece(true);

    FirstLevel = GetFirstLevel();
    Print("[LevelComps] First Level: " $ FirstLevel.Map @ FirstLevel.ActName @ FirstLevel.isDeathWish);
    if(FirstLevel.Map != "" || FirstLevel.isDeathWish || FirstLevel.isModDeathWish) {
        class'Hat_GlobalTimer'.static.Restart();
        StartCompLevel(FirstLevel);
    }
    else {
        Print("ERROR! First Level of Compilation not found!");
    }
}

static function ResetCompilationsCleared() {
    class'Hat_SaveBitHelper'.static.ResetLevelBitsForLevel(default.CompilationsMap);
}

function string GetAllLevelNames() {
    local string Names;
    local int i;

    if(Levels.Length == 0) {
        LevelsList();
    }

    for(i = 0; i < Levels.Length; i++) {
        if(Levels[i].isRift > 0 && !Levels[i].isMod) {
            Names $= "\n" $ (i + 1) $ ". Time Rift: " $ Levels[i].ActName;
        }
        else {
            Names $= "\n" $ (i + 1) $ ". " $ Levels[i].ActName;
        }
        
    }
    return Names;
}

static function string GetAllLevelNamesByArray(array<CompilationLevel> CompLevels) {
    local string Names;
    local int i;
    for(i = 0; i < CompLevels.Length; i++) {
        if(CompLevels[i].isRift > 0 && !CompLevels[i].isMod) {
            Names $= "\n" $ (i + 1) $ ". Time Rift: " $ CompLevels[i].ActName;
        }
        else {
            Names $= "\n" $ (i + 1) $ ". " $ CompLevels[i].ActName;
        }
    }
    return Names;
}

//
// Process of Control:
//
// Non-Mod Comp Level --(IsDeathWish?)--> StartDeathWishCompLevel Function
//                            |
//                            |------> Stay Here
// 
//
function bool StartCompLevel(CompilationLevel CL) {
    local Hat_PlayerController PC;
    local Hat_GameEventsInterface GEI;
    local Hat_ChapterInfo chapter;
    local Texture2D Titlecard;
    local int act, chapterIdOverride;
    local string level, chapterOverride, actOverride;

    if(CL.isDeathWish || CL.isModDeathWish) {
        StartDeathWishCompLevel(CL);
        return true;
    }

    if(CL.Map == "") return false;

    level = CL.Map;
    chapter = (CL.Chapter != None) ? CL.Chapter : None;
    act = (CL.Act > 0) ? CL.Act : 1;
    Titlecard = (CL.Titlecard != None) ? CL.Titlecard : Texture2D'HatinTime_Titlecards_Misc.Textures.TimeRift_Water';

    chapterOverride = (CL.ChapterName != "") ? CL.ChapterName : chapterOverride;
    actOverride = (CL.ActName != "") ? CL.ActName : actOverride;
    chapterIDOverride = (CL.ChapterID != 0) ? CL.ChapterID : 0;

    if(CL.isRift >= 1) {
        chapterOverride = "TIME RIFT";
        Titlecard = (CL.isRift == 1) ? Texture2D'HatinTime_Titlecards_Misc.Textures.TimeRift_Water' : Texture2D'HatinTime_Titlecards_Misc.Textures.TimeRift_Cave';
    }

	DoCustomTransition(level, chapter, act, Titlecard, chapterOverride, actOverride, chapterIdOverride,, CL);
	class'Hat_GlobalTimer'.static.RestartActTimer();
    if(CL.TP ~= "AlpineSkyline_Finale") {
        class'Hat_SeqCond_IsAlpineFinale'.static.ForceEnableAlpineFinale();
    }

    if(CL.TP ~= "Metro_Intro") {
        `SaveManager.GetCurrentSaveData().RemoveTimePiece("Metro_Intro");
        SetMetroIntroTimePiece(1);
     }

    //Just in case they're thrown into a level where they would be softlocked (Ex. Pink Paw)
    if(CL.Chapter == Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro') {
        PC = Hat_PlayerController(class'Engine'.static.GetEngine().GamePlayers[0].Actor);

		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteA',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteA', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteB',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteB', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteC',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteC', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteD',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteD', 1);
		`SaveManager.SaveToFile();
    }

    if(CL.Checkpoint != -1) {
	    `GameManager.SetCurrentCheckpoint(CL.Checkpoint, false);
    }

    foreach `GameEventsArray(GEI)
		GEI.OnPreActSelectMapChange(chapter, act, level);

    return true;
}

function StartDeathWishCompLevel(CompilationLevel CL) {
    local Hat_PlayerController PC;
    CustomPlayDeathWish(CL.DeathWish, CL);
    `SaveManager.GetCurrentSaveData().ActiveDeathWishes.Length = 0;
    `SaveManager.GetCurrentSaveData().ActiveDeathWishes.AddItem(CL.DeathWish);
    class'Hat_GlobalTimer'.static.RestartActTimer();

    //Just in case they're thrown into a level where they would be softlocked (Ex. Pink Paw)
    if(CL.Chapter == Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro') {
        PC = Hat_PlayerController(class'Engine'.static.GetEngine().GamePlayers[0].Actor);

		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteA',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteA', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteB',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteB', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteC',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteC', 1);
		if (!PC.GetLoadout().HasCollectible(class'Hat_Collectible_MetroTicket_RouteD',,false))
			PC.GetLoadout().AddCollectible(class'Hat_Collectible_MetroTicket_RouteD', 1);
		`SaveManager.SaveToFile();
    }

    if(CL.Checkpoint != -1) {
	    `GameManager.SetCurrentCheckpoint(CL.Checkpoint, false);
    }
         
}

function DoCustomTransition(string InMapName, Hat_ChapterInfo InChapterInfo, int InMapAct, optional Texture2D InTitleCardOverride, optional string InOverrideChapterName, optional string InOverrideActName, optional int InOverrideChapterID = INDEX_NONE, optional Texture2D InCoopIcon, optional CompilationLevel CL)
{
	local int indx;
	local Hat_HUDElementActTitleCard t;
	local Texture2D TitleCard, CoopIcon;
	local Worldinfo WI;
	
	WI = class'WorldInfo'.static.GetWorldInfo();
	
	Hat_GameManager(wi.game).LoadNewAct(InChapterInfo.ChapterID, InMapAct);
	
	t = Hat_HUDElementActTitleCard(Hat_HUD(class'Hat_PlayerController'.static.GetPlayerWithHighestIndex().MyHUD).OpenHUD(class'Hat_HUDElementActTitleCard', InMapName));
	
	if (true)
	{
		InChapterInfo.ConditionalUpdateActList();
		indx = InChapterInfo.GetActIndex(InMapAct);

		if (InTitleCardOverride != None)
			TitleCard = InTitleCardOverride;
		else if (indx != INDEX_NONE)
			TitleCard = InChapterInfo.ChapterActInfo[indx].GetTitleCardBackground();

		if (InCoopIcon != None)
			CoopIcon = InCoopIcon;
		else if (indx != INDEX_NONE)
			CoopIcon = InChapterInfo.ChapterActInfo[indx].CoopIcon;
		
		if (InOverrideChapterName == "")
			InOverrideChapterName = class'Hat_Localizer'.static.GetGame("levels", InChapterInfo.ChapterName);
		if (InOverrideActName == "")
			InOverrideActName = class'Hat_Localizer'.static.GetGame("levels", InChapterInfo.GetActName(InMapAct));
		if (InOverrideChapterID == INDEX_NONE)
			InOverrideChapterID = InChapterInfo.ChapterID;

        if(Yoshi_RandomizerLevelCompilation(self) != None) {
            InOverrideChapterName = "Level " $ GetLevelNumber(GetCompilationID()) + 1;
            InOverrideActName = default.CompilationID == 99998 ? InOverrideActName : "???";
            InOverrideChapterID = -1;
            InMapAct = -1;
            Titlecard = Yoshi_RandomizerLevelCompilation(self).RandomizerTitlecard;
        }
        if(CL.isMod && !CL.ShouldDisplayModAct) {
            InOverrideChapterID = -1;
            InMapAct = -1;
        }
        if(CL.isRift > 0) {
            InOverrideChapterID = -1;
            InMapAct = -1;
        }
		t.SetTitleCardChapterActInfo(TitleCard, InOverrideChapterName,  InOverrideActName, InOverrideChapterID, InMapAct, CoopIcon);
	}
	else 
	{
		t.SetTitleCardInfo(None, "ERROR", "ERROR");
	}
}

//This is a modified version of the function used to start Death Wishes in Hat_HUDMenuDeathWish to fix issues with the titlecards appearing incorrectly
function CustomPlayDeathWish(class<Hat_SnatcherContract_DeathWish> DeathWish, CompilationLevel CL)
{
	local Hat_ChapterInfo ChapterInfo;
	local Hat_ChapterActInfo ActInfo;
	local PlayerController PlayerController;
	local Hat_HUD MyHUD;
	local Hat_HUDElementActTitleCard TitleCard;
	local MaterialInstanceConstant TitleCaMaterialInstance;
	local string ChapterName, ActName, MapName;
	local Texture2D TitlecardBackground, CoopIcon;
	local Array<GameModInfo> ModList;
	local int ModIndex;
	local bool bHasSetActiveLevelMod;
	local Array<string> ObjectiveWorkshopRemoteIDs;
	
	ActInfo = DeathWish.default.ActInfo;
	ChapterInfo = ActInfo != None ? ActInfo.ChapterInfo : None;
	MapName = ActInfo != None ? ActInfo.MapName : "";
	bHasSetActiveLevelMod = false;

	if (ChapterInfo != None)
	{
		`GameManager.LoadNewAct(ChapterInfo.ChapterID, ActInfo != None ? ActInfo.ActID : 1);
	}
	else
	{
		`GameManager.LoadNewAct(99, 1);
	}
	
	`if(`isdefined(WITH_DLC2))
	if (class'Hat_GameManager'.default.AssistMode && DeathWish.default.HasEasyMode)
		DeathWish.static.SetDeathWishEasyMode(true);
	`endif
	
    //
    // Workaround to ensure lives don't result in being to another level
    // The act bits are set so new Lives Remaining counter isn't overridden
    //
    class'Hat_SaveBitHelper'.static.AddActBit("DeathWishFirstTimeInit", 1);
    class'Hat_SaveBitHelper'.static.AddActBit("DeathWishFirstLevelIntro", 1);
    `GameManager.LivesRemaining = 999999999;
    class'Hat_SaveBitHelper'.static.SetActBits("LivesRemaining", 999999999);

	if (ActInfo != None && ActInfo == Hat_ChapterActInfo'HatinTime_ChapterInfo.AlpineSkyline.AlpineSkyline_Finale')
		class'Hat_SeqCond_IsAlpineFinale'.static.ForceEnableAlpineFinale();
	
	if (DeathWish.default.AllowedMaps.length > 0 && DeathWish.default.AllowedMaps.Find(MapName) == INDEX_NONE)
		MapName = DeathWish.default.AllowedMaps[0];
	
	ObjectiveWorkshopRemoteIDs = DeathWish.static.GetObjectiveWorkshopRemoteIDs();
	if (ObjectiveWorkshopRemoteIDs.length > 0 && MapName == "")
	{
		ModList = class'GameMod'.static.GetModList();
		for (ModIndex = 0; ModIndex < ModList.Length; ModIndex++)
		{
			if (ModList[ModIndex].WorkshopID == INDEX_NONE) continue;
			if (!ModList[ModIndex].IsInstalled) continue;
			if (ModList[ModIndex].FirstMap == "") continue;
			if (ObjectiveWorkshopRemoteIDs.Find(class'GameMod'.static.GetModIDString(ModList[ModIndex].WorkshopID)) == INDEX_NONE) continue;
			
			MapName = ModList[ModIndex].FirstMap;
			class'GameMod'.static.SetActiveLevelMod(ModList[ModIndex].PackageName);
			bHasSetActiveLevelMod = true;
			break;
		}
	}

	if (DeathWish.default.StartCheckpoint > 0)
		`GameManager.SetCurrentCheckpoint(DeathWish.default.StartCheckpoint, false, false);

	if (DeathWish.default.StartAct > 0)
		`GameManager.SetCurrentAct(DeathWish.default.StartAct);
	
    //
    // Overrides
    //
    if(CL.Map != "") MapName = CL.Map;
    if(CL.Checkpoint > 0) `GameManager.SetCurrentCheckpoint(CL.Checkpoint, false, false);  
    if(CL.Act > 0) `GameManager.SetCurrentAct(CL.Act);
    
	if (MapName != "" && !class'Hat_ClassHelper'.static.PackageExists(MapName))
	{
		`broadcast("Unable to find map '" $ MapName $ "'");
		MapName = "";
	}
	
	if (!bHasSetActiveLevelMod)
		class'GameMod'.static.ResetActiveLevelMod();

	class'Hat_SaveBitHelper'.static.AddLevelBit("IsOnActiveDeathWish", 1, `GameManager.HubMapName);

    if (MapName != "")
    {
        // Open title card
        PlayerController = `GameManager.GetALocalPlayerController();
        if (PlayerController != None && PlayerController.myHUD != None)
        {
            MyHUD = Hat_HUD(PlayerController.myHUD);
            if (MyHUD != None)
            {
                ChapterName = "";
                if (DeathWish.static.ConsiderForDeathWishTotal())
                {
                    if (DeathWish.default.IsCommunity)
                        ChapterName = Caps(class'Hat_Localizer'.static.GetGame("levels", "Community"));
                    else
                        ChapterName = Caps(class'Hat_Localizer'.static.GetGame("levels", "DeathWish"));

                }

                if (DeathWish.default.IsCommunity)
                    ActName = Caps(DeathWish.static.GetShortLocalizedTitle());
                else
                    ActName = Caps(DeathWish.static.GetLocalizedTitle());

                
                TitlecardBackground = ActInfo != None ? ActInfo.GetTitleCardBackground() : None;
                CoopIcon = class'Hat_HUDElementActTitleCard'.default.DefaultCoopIcon[Rand(class'Hat_HUDElementActTitleCard'.default.DefaultCoopIcon.Length)];
                if (ActInfo != None && ActInfo.CoopIcon != None) CoopIcon = ActInfo.CoopIcon;
                if (ActInfo != None && ActInfo.IsBonus && TitlecardBackground == None)
                {
                    if (ActInfo.RequiredActID.Length > 0)
                    {
                        TitlecardBackground = class'Hat_HUDMenuActSelect'.default.TitleCard_TimeRiftWater;
                        CoopIcon = class'Hat_HUDElementActTitleCard'.default.TimeRift_Water_CoopIcon;
                    }
                    else
                        TitlecardBackground = class'Hat_HUDMenuActSelect'.default.TitleCard_TimeRiftCave;
                }
                //
                // Titlecard fix
                //
                if (CL.Titlecard != None)
                    TitlecardBackground = CL.Titlecard;
				else if (DeathWish.static.GetTitleCard() != None)
					TitlecardBackground = DeathWish.static.GetTitleCard();
                
                TitleCaMaterialInstance = new class'MaterialInstanceConstant';
                TitleCaMaterialInstance.SetParent(class'Hat_HUDMenuDeathWish'.default.DeathWishTitleCardMaterial);
                TitleCaMaterialInstance.SetTextureParameterValue('Texture', TitlecardBackground);
                TitleCaMaterialInstance.SetTextureParameterValue('CoopIcon', CoopIcon);
                if(CL.UseDWOverlay && !(Yoshi_RandomizerLevelCompilation(self) != None)) {
                    TitleCaMaterialInstance.SetScalarParameterValue('DeathWishOverlay', 1);
                }
                else {
                    TitleCaMaterialInstance.SetScalarParameterValue('DeathWishOverlay', 0);
                }
                TitleCard = Hat_HUDElementActTitleCard(MyHUD.OpenHUD(class'Hat_HUDElementActTitleCard', MapName));
                //Randomized Comps should not display their Chapter/Act information
                if(Yoshi_RandomizerLevelCompilation(self) != None) {
                    ChapterName = "Level " $ GetLevelNumber(GetCompilationID()) + 1;
                    ActName = "???";
                }
                TitleCard.SetTitleCardChapterActInfo(TitleCaMaterialInstance, ChapterName, ActName);
                TitleCard.UseActSelectLoadingMusic = true;
                TitleCard.IsDeathWish = true;
            }
        }
    }

	// fallback level transition if title card failed
	if (TitleCard == None)
	{
		`GameManager.SoftChangeLevel(MapName);
	}
}

function RejoinActiveCompilation() {
    local CompilationLevel ActiveLevel;
    if(Levels.Length == 0) {
        LevelsList();
    }

    Print("[LevelComps] => REJOIN COMPILATION: (CompID: " $ default.CompilationID $ ", Level: " $ GetLevelNumber(default.CompilationID) $ ")");
 
    SetInComp(true);
    SetStartFromContinue(true);
    SetCompilationID(default.CompilationID);
    SetAcceptTimePiece(true);

    ActiveLevel = GetCurrentLevel();
    StartCompLevel(ActiveLevel);
}