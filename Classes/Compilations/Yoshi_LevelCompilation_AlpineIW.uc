class Yoshi_LevelCompilation_AlpineIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=6
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW'
    CompName="Alpine Skyline IW"
}

function LevelsList() {
    Levels.Add(8);
    Levels[0] = class'Yoshi_LevelsSheet'.static.LavaCake();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Birdhouse();
    Levels[2] = class'Yoshi_LevelsSheet'.static.Windmill();
    Levels[3] = class'Yoshi_LevelsSheet'.static.TwilightBell();
    Levels[4] = class'Yoshi_LevelsSheet'.static.Illness();
    Levels[5] = class'Yoshi_LevelsSheet'.static.CurlyTailTrail();
    Levels[6] = class'Yoshi_LevelsSheet'.static.TwilightBellRift();
    Levels[7] = class'Yoshi_LevelsSheet'.static.AlpineSkylineRift();
}