class Yoshi_LevelCompilation_SubconIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=5
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.SubconIW'
    CompName="Subcon Forest IW"
}

function LevelsList() {
    Levels.Add(9);
    Levels[0] = class'Yoshi_LevelsSheet'.static.CO();
    Levels[1] = class'Yoshi_LevelsSheet'.static.SW();
    Levels[2] = class'Yoshi_LevelsSheet'.static.MDS();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Manor();
    Levels[4] = class'Yoshi_LevelsSheet'.static.Pipe();
    Levels[5] = class'Yoshi_LevelsSheet'.static.Village();
    Levels[6] = class'Yoshi_LevelsSheet'.static.TOD();
    Levels[7] = class'Yoshi_LevelsSheet'.static.SleepySubcon();
    Levels[8] = class'Yoshi_LevelsSheet'.static.YCHE();
}