class Yoshi_ModLevelCompilation_CR12 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50012
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 12"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976434466"
    ChallengeRoadID=("1859566887_1872193830_1904110937", "1859566887_1868564702_1872193830_1904110937")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.TimeRiftSealGardens();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.SkyRift();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.TimeRiftRougeEchoes();
}