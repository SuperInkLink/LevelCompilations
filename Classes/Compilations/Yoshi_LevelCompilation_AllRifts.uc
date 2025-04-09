class Yoshi_LevelCompilation_AllRifts extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=2
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts'
    CompName="All Rifts"
}

function LevelsList() {
    Levels.Add(26);
    Levels[0] = class'Yoshi_LevelsSheet'.static.Lab();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Gallery();
    Levels[2] = class'Yoshi_LevelsSheet'.static.Sewers();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Bazaar();
    Levels[4] = class'Yoshi_LevelsSheet'.static.MafiaOfCooks();
    Levels[5] = class'Yoshi_LevelsSheet'.static.OwlExpress();
    Levels[6] = class'Yoshi_LevelsSheet'.static.Moon();
    Levels[7] = class'Yoshi_LevelsSheet'.static.DBSRift();
    Levels[8] = class'Yoshi_LevelsSheet'.static.Pipe();
    Levels[9] = class'Yoshi_LevelsSheet'.static.Village();
    Levels[10] = class'Yoshi_LevelsSheet'.static.SleepySubcon();
    Levels[11] = class'Yoshi_LevelsSheet'.static.CurlyTailTrail();
    Levels[12] = class'Yoshi_LevelsSheet'.static.TwilightBellRift();
    Levels[13] = class'Yoshi_LevelsSheet'.static.AlpineSkylineRift();
    Levels[14] = class'Yoshi_LevelsSheet'.static.Balcony();
    Levels[15] = class'Yoshi_LevelsSheet'.static.DeepSea();
    Levels[16] = class'Yoshi_LevelsSheet'.static.RumbiFactory();
    Levels[17] = class'Yoshi_LevelsSheet'.static.RhythmJumpStudio();
    Levels[18] = class'Yoshi_LevelsSheet'.static.TheMountainRift();
    Levels[19] = class'Yoshi_LevelsSheet'.static.TwilightTravels();
    Levels[20] = class'Yoshi_LevelsSheet'.static.MafiaOfCooksRC();
    Levels[21] = class'Yoshi_LevelsSheet'.static.DeadBirdStudioRC();
    Levels[22] = class'Yoshi_LevelsSheet'.static.SleepySubconRC();
    Levels[23] = class'Yoshi_LevelsSheet'.static.AlpineSkylineRC();
    Levels[24] = class'Yoshi_LevelsSheet'.static.DeepSeaRC();  
    Levels[25] = class'Yoshi_LevelsSheet'.static.Tour();
}