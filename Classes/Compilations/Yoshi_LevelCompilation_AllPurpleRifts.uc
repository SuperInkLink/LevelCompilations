class Yoshi_LevelCompilation_AllPurpleRifts extends Yoshi_LevelCompilation;

defaultproperties 
{
    CompilationID=1
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts'
    CompName="All Purple Rifts"
}

function LevelsList() {
    Levels.Add(10);
    Levels[0] = class'Yoshi_LevelsSheet'.static.MafiaOfCooks();
    Levels[1] = class'Yoshi_LevelsSheet'.static.DBSRift();
    Levels[2] = class'Yoshi_LevelsSheet'.static.SleepySubcon();
    Levels[3] = class'Yoshi_LevelsSheet'.static.AlpineSkylineRift();
    Levels[4] = class'Yoshi_LevelsSheet'.static.DeepSea();
    Levels[5] = class'Yoshi_LevelsSheet'.static.RumbiFactory();
    Levels[6] = class'Yoshi_LevelsSheet'.static.RhythmJumpStudio();
    Levels[7] = class'Yoshi_LevelsSheet'.static.TheMountainRift();
    Levels[8] = class'Yoshi_LevelsSheet'.static.TwilightTravels();
    Levels[9] = class'Yoshi_LevelsSheet'.static.Tour();
}