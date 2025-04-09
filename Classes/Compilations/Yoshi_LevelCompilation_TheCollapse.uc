class Yoshi_LevelCompilation_TheCollapse extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=12
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts'
    CompName="The Collapse"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_LevelsSheet'.static.MafiaOfCooksRC();
    Levels[1] = class'Yoshi_LevelsSheet'.static.DeadBirdStudioRC();
    Levels[2] = class'Yoshi_LevelsSheet'.static.SleepySubconRC();
    Levels[3] = class'Yoshi_LevelsSheet'.static.AlpineSkylineRC();
    Levels[4] = class'Yoshi_LevelsSheet'.static.DeepSeaRC();
}