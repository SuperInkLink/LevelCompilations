/**
*
*   Code by EpicYoshiMaster
*   This subclass defines the functions necessary for a Level Compilation to be a Randomizer - random level collection selected from a pool
*   It extends from the Mod Level Compilation class because some Randomizer Compilations use mods
*   Introduces:
*   PossibleLevelList - Pool of Levels which Randomizer Compilations choose from
*   RandoCompilationSeed - Stores the ORIGINAL un-modified seed of the randomizer so that 
*
*/

class Yoshi_RandomizerLevelCompilation extends Yoshi_ModLevelCompilation
    abstract;

var Texture2D RandomizerTitlecard;
var const int RandomizerLevelCount;
var array<CompilationLevel> PossibleLevels; //For Randomized: Levels which can be pooled from for the Compilation

const SEED_LEVELBIT_ID = "RandoCompilationSeed"; //Thanks Starblaster for the seed system in their Shufflizer mod
const SEED_LENGTH = 7;

function int GetLevelsCount() {
    return RandomizerLevelCount;
}

function LevelsList() {
    local int i;

    //The seed is used the entire time now
    Levels = GetARandomSetOfLevels(default.RandomizerLevelCount);
    if(Levels.Length != default.RandomizerLevelCount) {
        Print("Error: Level Length Mismatch! " $ Levels.Length $ " vs " $ default.RandomizerLevelCount);
        Levels.Length = default.RandomizerLevelCount;
    }

    //Obscure Level Information
    
    for(i = 0; i < Levels.Length; i++) {
        Levels[i].ActName = "???";
        Levels[i].ChapterName = "???";
        Levels[i].Titlecard = RandomizerTitlecard;
    }
}

function PossibleLevelsList() {} //Used by Randomized Compilations to hold all the possible levels which can be randomized

function Initialize() {
    local int i;

    Levels = GetARandomSetOfLevels(default.RandomizerLevelCount);
    
    for(i = 0; i < Levels.Length; i++) {
        Levels[i].Titlecard = RandomizerTitlecard;
    }

    Super.Initialize();
}

//We actually don't need to know the levels at all, just the number of them
function string GetAllLevelNames() {
    local string Names;
    local int i;

    for(i = 0; i < RandomizerLevelCount; i++) {
        Names $= "\n" $ (i + 1) $ ". ???";
    }
    return Names;
}

function array<CompilationLevel> GetARandomSetOfLevels(int NumberOfLevels) {
    local int i;
    local int CurrentSeed;
    local int SelectedIndex;
    local array<CompilationLevel> SelectedLevels;

    if(PossibleLevels.Length == 0) {
        PossibleLevelsList();
        Print("Getting " $ NumberOfLevels $ " Levels from a set of " $ PossibleLevels.Length $ "Levels");
    }

    //CurrentSeed will be 0 if the player is doing a compilation alone, otherwise it will have already been set
    CurrentSeed = GetSeed();
	if (CurrentSeed == 0)
	{
		CurrentSeed = GenerateNewSeed();
		SetSeed(CurrentSeed);
	}

    for(i = 0; i < NumberOfLevels; i++) {
        SelectedIndex = class'Hat_Math'.static.SeededRandWithSeed(PossibleLevels.Length, CurrentSeed);
        SelectedLevels.AddItem(PossibleLevels[SelectedIndex]);
        PossibleLevels.Remove(SelectedIndex, 1);
        CurrentSeed++;
    }
    Print("Received " $ SelectedLevels.Length $ " Levels.");

    PossibleLevels.Length = 0;
    return SelectedLevels;
}

function bool CheckForMissingMods() 
{
    local Array<string> IDsToDownload, ObjectiveWorkshopIDs;
    local class<Hat_SnatcherContract_DeathWish> DeathWishClass;
    local int i, NumIdx, MissingModCount;
    local bool LevelCompsVersionCheck;

    LevelCompsVersionCheck = IsOnNewLevelCompsVersion();
    
    if (PossibleLevels.Length == 0)
        PossibleLevelsList();

    MissingModCount = 0;
    for (i = 0; i < PossibleLevels.Length; i++) 
    {
        if (PossibleLevels[i].isMod && IDsToDownload.Find(PossibleLevels[i].WorkshopID) == INDEX_NONE)
            IDsToDownload.AddItem(PossibleLevels[i].WorkshopID);
        if (PossibleLevels[i].isDeathWish || PossibleLevels[i].isModDeathWish)
        {
            if (PossibleLevels[i].DeathWish != None)
                DeathWishClass = PossibleLevels[i].DeathWish;
            else if (PossibleLevels[i].isModDeathWish && PossibleLevels[i].ModDeathWish != "")
                DeathWishClass = GetModDeathWish(PossibleLevels[i]);
            
            if (DeathWishClass != None)
            {
                ObjectiveWorkshopIDs = DeathWishClass.static.GetObjectiveWorkshopRemoteIDs();
                if (ObjectiveWorkshopIDs.Length > 0)
                {
                    for (NumIdx = 0; NumIdx < ObjectiveWorkshopIDs.Length; NumIdx++)
                    {
                        if (ObjectiveWorkshopIDs[NumIdx] != "" && IDsToDownload.Find(ObjectiveWorkshopIDs[NumIdx]) == INDEX_NONE)
                            IDsToDownload.AddItem(ObjectiveWorkshopIDs[NumIdx]);
                    }
                }
            }
        }
    }

    for (i = 0; i < IDsToDownload.Length; i++)
    {
        if (LevelCompsVersionCheck ? !IsModReady(IDsToDownload[i]) : !IsModReadyOlderVersion(IDsToDownload[i]))
        {
            MissingModCount++;
            //print("MISSING" @ MissingModCount @ "MOD(s) OF ID:" @ IDsToDownload[i]);
            class'GameMod'.static.LogMod("MISSING" @ MissingModCount @ "MOD(s) OF ID:" @ IDsToDownload[i]);
        }
    }

    return MissingModCount > 0;    
}

//Thanks Starblaster
static function int GenerateNewSeed() {
	local string SeedString;
	local int i;
	
	for (i = 0; i < SEED_LENGTH; i++)
	{
		SeedString $= Rand(10);
	}
	
    Print("[LevelComps] => Generated New Randomizer Seed: " $ SeedString);
	return int(SeedString);
}

static function int GetSeed() { return class'Hat_SaveBitHelper'.static.GetLevelBits(SEED_LEVELBIT_ID $ "_" $ default.CompilationID, default.LevelDataMap); }
static function SetSeed(int NewSeed) { class'Hat_SaveBitHelper'.static.SetLevelBits(SEED_LEVELBIT_ID $ "_" $ default.CompilationID, NewSeed, default.LevelDataMap); }

defaultproperties
{
    RandomizerTitlecard=Texture2D'Yoshi_LevelComp_Content.Titlecards.Yoshi_SuperTitlecard'
}