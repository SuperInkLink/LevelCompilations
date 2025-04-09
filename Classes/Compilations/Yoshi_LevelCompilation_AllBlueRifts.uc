class Yoshi_LevelCompilation_AllBlueRifts extends Yoshi_LevelCompilation;

defaultproperties 
{
    CompilationID=0
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts'
    CompName="All Blue Rifts"
}

function LevelsList() {
    Levels.Add(11);
    Levels[0] = class'Yoshi_LevelsSheet'.static.Lab();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Gallery();
    Levels[2] = class'Yoshi_LevelsSheet'.static.Sewers();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Bazaar();
    Levels[4] = class'Yoshi_LevelsSheet'.static.OwlExpress();
    Levels[5] = class'Yoshi_LevelsSheet'.static.Moon();
    Levels[6] = class'Yoshi_LevelsSheet'.static.Pipe();
    Levels[7] = class'Yoshi_LevelsSheet'.static.Village();
    Levels[8] = class'Yoshi_LevelsSheet'.static.CurlyTailTrail();
    Levels[9] = class'Yoshi_LevelsSheet'.static.TwilightBellRift();
    Levels[10] = class'Yoshi_LevelsSheet'.static.Balcony();
}
