class Yoshi_LevelCompilation_BirdsIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=4
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Battle of the Birds IW"
}

function LevelsList() {
    Levels.Add(10);
    Levels[0] = class'Yoshi_LevelsSheet'.static.DBS();
    Levels[1] = class'Yoshi_LevelsSheet'.static.MOTOE();
    Levels[2] = class'Yoshi_LevelsSheet'.static.PP();
    Levels[3] = class'Yoshi_LevelsSheet'.static.OwlExpress();
    Levels[4] = class'Yoshi_LevelsSheet'.static.TR();
    Levels[5] = class'Yoshi_LevelsSheet'.static.Parade();
    Levels[6] = class'Yoshi_LevelsSheet'.static.Moon();
    Levels[7] = class'Yoshi_LevelsSheet'.static.DBSRift();
    Levels[8] = class'Yoshi_LevelsSheet'.static.FakeAwardCeremony();
    Levels[9] = class'Yoshi_LevelsSheet'.static.AwardCeremony();
}