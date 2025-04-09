class Yoshi_ModLevelCompilation_CR14 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50014
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 14"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976436282"
    ChallengeRoadID=("1747469442_1858074314_1860578539_1862158198_1867356359_1871813199_1872109003", "1747469442_1858074314_1860578539_1867356359_1871813199_1872109003", "1747469442_1858074314_1860578539_1867356359_1872109003")
}

function LevelsList() {
    Levels.Add(7);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.YellowJelloRift();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.PinkMeltedDonutsTimeRift();
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.ZestyOrange();
    Levels[3] = class'Yoshi_ModLevelsSHeet'.static.RedAsHeckRift();
    Levels[4] = class'Yoshi_ModLevelsSHeet'.static.TheBlues();
    Levels[5] = class'Yoshi_ModLevelsSHeet'.static.RainbowBlues();
    Levels[6] = class'Yoshi_ModLevelsSHeet'.static.FogginFunkyMauveMetro();
}