class Yoshi_ModLevelCompilation_RetroStyle extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60001
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.AWholeNewWorld'
    CompName="A Whole New World"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976441541"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.SuperHatGirlOneDashOne();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.BreakTheTargets();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.SweetSweetGalaxy();
    Levels[3] = class'Yoshi_ModLevelsSHeet'.static.DungeonOfTheEagle();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.HatKidsAdventureInSouthIsland();
}
