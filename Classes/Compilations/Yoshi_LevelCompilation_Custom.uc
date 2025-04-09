/*
* A special kind of Compilation which holds user-selected levels in a file. 
* Because technically multiple compilations are stored in one, we need to override a few functions to make our level bits work properly
*/
class Yoshi_LevelCompilation_Custom extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=99999
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts'
    CompName="Custom Compilation"
}

function LevelsList() {
    local int CustomSelection;
    local Yoshi_CustomCompilationStorage CustomComp;
    CustomComp = new class'Yoshi_CustomCompilationStorage';
    class'Engine'.static.BasicLoadObject(CustomComp, "LevelCompilations/CustomCompilations.levelcomp", false, 1);

    CustomSelection = GetCustomCompilationID();
    if(CustomSelection >= 0 && CustomSelection < CustomComp.CustomComps.Length) {
        Levels = CustomComp.CustomComps[CustomSelection].Levels;
    }
}

//Special function needed to move all the level bits to their proper places when a Custom Comp is deleted
static function ShiftLevelBits(int Index, Yoshi_CustomCompilationStorage AllCustomComps) {
    local int i;
    local int NextLevelNum;

    //First remove the deleted custom comp level bit
    if(Index < AllCustomComps.CustomComps.length) {
        SetLevelBit(CurrentLevelNumberBit $ "_" $ default.CompilationID $ "_" $ Index, -1);
    }

    //Next shift over any further level bits left one.
    for(i = Index + 1; i < AllCustomComps.CustomComps.length; i++) {

        //Grab the level bit of the next level
        NextLevelNum = GetLevelBit(CurrentLevelNumberBit $ "_" $ default.CompilationID $ "_" $ i);

        //Replace the previous level bit
        SetLevelBit(CurrentLevelNumberBit $ "_" $ default.CompilationID $ "_" $ i - 1, NextLevelNum);

        //Delete the now moved level bit
        SetLevelBit(CurrentLevelNumberBit $ "_" $ default.CompilationID $ "_" $ i, -1);
    }
}

static function SetLevelNumber(int NewNum, int CompID) {
    SetLevelBit(CurrentLevelNumberBit $ "_" $ CompID $ "_" $ GetCustomCompilationID(), NewNum);
}

static function IncreaseLevelNumber(int CompID) {
    if(CompID > -1)
        SetLevelBit(CurrentLevelNumberBit $ "_" $ CompID $ "_" $ GetCustomCompilationID(), GetLevelNumber(CompID) + 1);
}

static function int GetLevelNumber(int CompID) {
    return GetLevelBit(CurrentLevelNumberBit $ "_" $ CompID $ "_" $ GetCustomCompilationID());
}

