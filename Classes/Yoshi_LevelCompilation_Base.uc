/**
*
*   Code by EpicYoshiMaster
*   This base class defines most of the necessary helper functions used by the rest of the mod.
*
*/
class Yoshi_LevelCompilation_Base extends Object
    abstract;

var const string LevelDataMap;

struct CompilationLevel {
    var string Map;
    var Hat_ChapterInfo Chapter;
    var int Act;
    var Texture2D Titlecard;
    var string ChapterName;
    var int ChapterID;
    var string ActName;
    var int isRift; //0 = Regular level, 1 = Blue Rift, 2 = Purple Rift
    var string TP;
    var Texture2D Icon; //Displayed on the HUD for Custom Compilations

    var bool isDeathWish;
    var class<Hat_SnatcherContract_DeathWish> DeathWish;
    var bool UseDWOverlay;

    var bool isMod;
    var bool isModDeathWish;
    var string ModDeathWish;
    var bool ShouldDisplayModAct;
    var string WorkshopID; //PREVIOUS VERSIONS USED THIS AS AN INT, had to be changed to a string with the Modding Crisis 2020 :tm:

    var int Checkpoint;

    structdefaultproperties 
    {
        isRift = 0;
        Act = -1;
        ChapterID = 0;
        isDeathWish = false;
        UseDWOverlay = false;
        TP = "NOREQUIREMENT"; //TP corresponds to the Identifier of a Time Piece, NOREQUIREMENT signals that it should ignore the Identifier
        Icon = Texture2D'Yoshi_LevelComp_Content.Textures.MafiaTownIW';
        isMod = false;
        isModDeathWish = false;
        ShouldDisplayModAct = false;
        Checkpoint = -1;
    }
};

var array<CompilationLevel> Levels; //Actual levels used in a Compilation
var string CompilationsMap;

//
//Level Bit Data needed to find active level data between loads
//
const InCompBit = "InComp"; // True or False if playing a Compilation
const CurrentCompIDBit = "CurrentCompID"; 
const CurrentCustomCompIDBit = "CurrentCustomCompID";
const CurrentLevelNumberBit = "CurrentLevelNumber"; //Uses Comp ID to facilitate saving Level #'s for the future

const StartFromContinueBit = "StartFromContinue"; //Used for determining valid best times
const CanAcceptTimePieceBit = "CanAcceptTimePiece";
const MetroIntroLevelBit = "StolenMetroIntro";
const DoubleRestartBit = "DoubleRestart";

//
// KEY FUNCTIONS
//

//Called when a time piece is collected for the current compilation
function int OnTimePieceCollected(string Identifier, optional bool ReceivedViaOnline = false, optional int LevelReceived = -1) { return -1; }

//Called when the final level of a compilation is completed
function OnFinishLastLevel() {}

//Key function for all Level Compilation subclasses. Assigns the Levels array with the levels of the compilation.
function LevelsList() {} 

//This function begins a Level Compilation from the first level
function Initialize() {}

//
// LEVEL FUNCTIONS
//

function int GetLevelsCount() {
    if(Levels.Length == 0) {
        LevelsList();
    }

    return Levels.Length;
}

static function bool IsValidIdentifier(CompilationLevel CL, string Identifier) {
	return (CL.TP ~= Identifier || CL.TP ~= "NOREQUIREMENT");
}

function array<CompilationLevel> GetLevelsList() {
    If(Levels.Length == 0) {
        LevelsList();
    }

    return Levels;
}

function CompilationLevel GetFirstLevel() {
    local CompilationLevel FirstLevel;
    if(Levels.Length == 0) LevelsList();

    if(Levels.Length > 0) {
        FirstLevel = Levels[0];
    }

    return FirstLevel;
}

function CompilationLevel GetCurrentLevel() {
    if(Levels.Length == 0) LevelsList();

    return Levels[GetLevelNumber(GetCompilationID())];
}

//Also Increments Level Number
function CompilationLevel GetNextLevel() {
    local CompilationLevel Empty;
    if(Levels.Length == 0) LevelsList();

    IncreaseLevelNumber(GetCompilationID());

    if(Levels.Length > GetLevelNumber(GetCompilationID())) {
        Print("[LevelComps] => Getting Next Level: " $ GetLevelNumber(GetCompilationID()) @ Levels[GetLevelNumber(GetCompilationID())].ActName);
        return Levels[GetLevelNumber(GetCompilationID())];
    }
    else {
        return Empty;
    }
}

function bool IsLastLevelNum(int LevelNum) {
    if(Levels.Length == 0) LevelsList();
    return LevelNum >= Levels.Length - 1;
}

//
// HELPER FUNCTIONS
//

function bool SetBestTime(float t, optional bool force = false, optional bool HigherIsBetter = false)
{
	local Hat_SaveGame SaveGame;
	local int time;

	SaveGame = Hat_SaveGame(`SaveManager.SaveData);
	time = int(t * 1000);

	if (SaveGame != None)
	{
		if (force || GetBestTime() <= 0 || (HigherIsBetter ? (GetBestTime() < t) : (GetBestTime() >= t)))
		{
			class'Hat_SaveBitHelper'.static.SetLevelBits(string(default.Class) $ "_BestTime", time, default.CompilationsMap);
			return true;
		}
	}
	return false;
}

function float GetBestTime()
{
	local Hat_SaveGame SaveGame;

	SaveGame = Hat_SaveGame(`SaveManager.SaveData);
	if (SaveGame != None)
		return float(class'Hat_SaveBitHelper'.static.GetLevelBits(string(default.Class) $ "_BestTime", default.CompilationsMap)) / 1000;
	else
		return 0;
}

static function string FormatNumber(int number, optional int mindigits = 1)
{
	local string r;
	
	r = "" $ number;
	if (mindigits <= 1) return r;

	while (Len(r) < mindigits)
	{
		r = "0" $ r;
	}

	return r;
}

static function string FormatTime(float time, bool ShowCentiseconds, bool AlwaysShowHours)
{
	local int hours, minutes, seconds, centiseconds;
	local string HoursString, CentiString;

	hours = (time / 3600);
	minutes = ((time % 3600) / 60);
	seconds = time % 60;
	centiseconds = int((time - int(time))*100);

	if (hours > 0 || AlwaysShowHours)
	{
		HoursString = FormatNumber(hours, 1) $ ":";
	}
	if (ShowCentiseconds)
	{
		CentiString = "." $ FormatNumber(centiseconds, 2);
	}
	
	return HoursString $ FormatNumber(minutes, 2) $ ":" $ FormatNumber(seconds, 2) $ CentiString;
}

static function array< class<Yoshi_LevelCompilation> > GetAllLevelComps() {
    local array< class<Yoshi_LevelCompilation> > AllCompClasses;
    local int i;

    local array< class<Object> > AllClasses;
    AllClasses = class'Hat_ClassHelper'.static.GetAllScriptClasses("Yoshi_LevelCompilation");
    for(i = 0; i < AllClasses.length; i++) {
        if(class<Yoshi_LevelCompilation>(AllClasses[i]) != None) {
            AllCompClasses.AddItem(class<Yoshi_LevelCompilation>(AllClasses[i]));
        }
    }

    return AllCompClasses;
}

//
// LEVEL DATA FUNCTIONS
//

//TODO: ACTUALLY MAKE THIS STATIC.
static function Yoshi_LevelCompilation GetActiveComp(optional array< class<Yoshi_LevelCompilation> > CompClasses) {
    local int i;
    local int CurrentCompID;

    CurrentCompID = GetLevelBit(CurrentCompIDBit);

    //Bypass calling GetAllScriptClasses when convenient
    if(CompClasses.length > 0) {
        for(i = 0; i < CompClasses.Length; i++) {
            if(CompClasses[i].default.CompilationID == CurrentCompID)
                return (new CompClasses[i]);
        }
    }

    return class'Yoshi_LevelCompilation'.static.ReturnByID(CurrentCompID);
}

static function ResetContinueData() {
    Print("[LevelComps] => Resetting Continue Data");

    class'Hat_SaveBitHelper'.static.ResetLevelBitsForLevel(default.LevelDataMap);

    SetInComp(false);
    SetLevelBit(CurrentCompIDBit, -1);
}

static function bool IsInCompilation() {
    return GetInComp() && GetCompilationID() > -1 && GetLevelNumber(GetCompilationID()) > -1;
}

static function bool IsInCompilationNum(int CompID) {
    return GetInComp() && GetCompilationID() == CompID;
}

static function SetInComp(bool State) {
    SetLevelBit(InCompBit, (State) ? 1 : 0);
}

static function bool GetInComp() {
    return GetLevelBit(InCompBit) == 1;
}

static function SetStartFromContinue(bool State) {
    SetLevelBit(StartFromContinueBit, (State) ? 1 : 0);
}

static function bool GetStartFromContinue() {
    return GetLevelBit(StartFromContinueBit) == 1;
}

static function SetCompilationID(int NewID) {
    SetLevelBit(CurrentCompIDBit, NewID);
}

static function int GetCompilationID() {
    return GetLevelBit(CurrentCompIDBit);
}

static function SetLevelNumber(int NewNum, int CompID) {
    SetLevelBit(CurrentLevelNumberBit $ "_" $ CompID, NewNum);
}

static function IncreaseLevelNumber(int CompID) {
    if(CompID > -1)
        SetLevelBit(CurrentLevelNumberBit $ "_" $ CompID, GetLevelNumber(CompID) + 1);
}

static function int GetLevelNumber(int CompID) {
    return GetLevelBit(CurrentLevelNumberBit $ "_" $ CompID);
}

static function SetCustomCompilationID(int NewID) {
    SetLevelBit(CurrentCustomCompIDBit, NewID);
}

static function int GetCustomCompilationID() {
    return GetLevelBit(CurrentCustomCompIDBit);
}

//
// Misc State Functions
//

static function bool ShouldAcceptTimePiece() {
    return GetLevelBit(CanAcceptTimePieceBit) == 1;
}

static function SetAcceptTimePiece(bool NewAccept) {
    SetLevelBit(CanAcceptTimePieceBit, (NewAccept) ? 1 : 0);
}

static function DoTimerCheck(optional array< class<Yoshi_LevelCompilation> > CompClasses) {

    if(GetActiveComp(CompClasses).GetCurrentLevel().isRift == 2 && class'Hat_GlobalTimer'.static.IsPaused()) {
        class'Hat_GlobalTimer'.static.Unpause();
     }
}

//Checks for the need to Double Restart a level
static function SetDoubleRestart(int DoubleRestartNum) {
    SetLevelBit(DoubleRestartBit, DoubleRestartNum);
}

function CheckDoubleRestart() {
    if(GetLevelBit(DoubleRestartBit) == 1 && Yoshi_LevelCompilation(self) != None) {
        Yoshi_LevelCompilation(self).StartCompLevel(GetCurrentLevel());
        SetLevelBit(DoubleRestartBit, 0);
    }
}

static function SetMetroIntroTimePiece(int MetroIntroNum) {
    SetLevelBit(MetroIntroLevelBit, MetroIntroNum);
}

//Checks for restoration of the Metro Intro Time Piece
static function RestoreMetroIntroTimePiece() {
    if(GetLevelBit(MetroIntroLevelBit) == 1) {
        `GameManager.GiveTimePiece("Metro_Intro", true);
        SetLevelBit(MetroIntroLevelBit, 0);
    }
}

//
// Base Functions
//

static function int GetLevelBit(string LevelBit) { 
    return class'Hat_SaveBitHelper'.static.GetLevelBits(LevelBit, default.LevelDataMap); 
}
static function SetLevelBit(string LevelBit, int NewBit) { 
    class'Hat_SaveBitHelper'.static.SetLevelBits(LevelBit, NewBit, default.LevelDataMap); 
    Print("Setting Level Bit " $ LevelBit $ " with value " $ NewBit $ " Result: " $ GetLevelBit(LevelBit));
}

//
// THE PRINT FUNCTION IS COOL
//

static final function Print(const string msg)
{
    class'Yoshi_levelCompilations_GameMod'.static.Print(msg);
}

defaultproperties
{
    CompilationsMap="yoshi_levelcompilations_progress"
    LevelDataMap="yoshi_levelcompilations_data"
}