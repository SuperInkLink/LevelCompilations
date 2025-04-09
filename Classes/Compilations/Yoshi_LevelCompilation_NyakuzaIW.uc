class Yoshi_LevelCompilation_NyakuzaIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=8
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW'
    CompName="Nyakuza Metro IW"
}

function LevelsList() {
    Levels.Add(10);
    Levels[0] = class'Yoshi_LevelsSheet'.static.MainStation();
    Levels[1] = class'Yoshi_LevelsSheet'.static.YellowOverpass();
    Levels[2] = class'Yoshi_LevelsSheet'.static.GreenClean();
    Levels[3] = class'Yoshi_LevelsSheet'.static.BluefinTunnels();
    Levels[4] = class'Yoshi_LevelsSheet'.static.PinkPaw();
    Levels[5] = class'Yoshi_LevelsSheet'.static.YellowOverpassManhole();
    Levels[6] = class'Yoshi_LevelsSheet'.static.GreenCleanManhole();
    Levels[7] = class'Yoshi_LevelsSheet'.static.PinkPawManhole();
    Levels[8] = class'Yoshi_LevelsSheet'.static.RushHour();
    Levels[9] = class'Yoshi_LevelsSheet'.static.RumbiFactory();
}