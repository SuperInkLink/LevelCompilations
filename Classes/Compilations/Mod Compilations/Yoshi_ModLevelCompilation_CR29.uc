class Yoshi_ModLevelCompilation_CR29 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50029
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 29"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007711115"
    ChallengeRoadID=("2304365430_2523560851_2722352887_2786299591")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TimeRiftConvolutedCatastrophe();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.RandomLevel2();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.SkyHighRidge();
	Levels[3] = class'Yoshi_ModLevelsSheet'.static.EarlyWings();
}