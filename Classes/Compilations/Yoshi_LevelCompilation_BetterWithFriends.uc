class Yoshi_LevelCompilation_BetterWithFriends extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=11
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.BetterWithFriends'
    CompName="Better With Friends"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_LevelsSheet'.static.GV();
    Levels[1] = class'Yoshi_LevelsSheet'.static.HUMT();
    Levels[2] = class'Yoshi_LevelsSheet'.static.CO();
    Levels[3] = class'Yoshi_LevelsSheet'.static.MDS();
    Levels[4] = class'Yoshi_LevelsSheet'.static.DWTM();
}