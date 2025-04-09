class Yoshi_LevelCompilation_MafiaTownIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=3
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.MafiaTownIW'
    CompName="Mafia Town IW"
}

function LevelsList() {
    Levels.Add(10);
    Levels[0] = class'Yoshi_LevelsSheet'.static.WTMT();
    Levels[1] = class'Yoshi_LevelsSheet'.static.SCFOS();
    Levels[2] = class'Yoshi_LevelsSheet'.static.BB();
    Levels[3] = class'Yoshi_LevelsSheet'.static.DWTM();
    Levels[4] = class'Yoshi_LevelsSheet'.static.GV();
    Levels[5] = class'Yoshi_LevelsSheet'.static.Sewers();
    Levels[6] = class'Yoshi_LevelsSheet'.static.HUMT();
    Levels[7] = class'Yoshi_LevelsSheet'.static.Bazaar();
    Levels[8] = class'Yoshi_LevelsSheet'.static.MafiaOfCooks();
    Levels[9] = class'Yoshi_LevelsSheet'.static.CTR();
}