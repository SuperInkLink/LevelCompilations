class Yoshi_ModLevelCompilation_HeavenAndHell extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60000
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.HeavenAndHell'
    CompName="Heaven and Hell"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976438761"
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.WetMushroomHeaven();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.WhiteTowerForest();
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.WetMushroomHell();
    Levels[3] = class'Yoshi_ModLevelsSHeet'.static.WhiteTowerHell();
}