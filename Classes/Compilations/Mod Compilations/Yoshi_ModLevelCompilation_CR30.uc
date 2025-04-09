class Yoshi_ModLevelCompilation_CR30 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50030
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 30"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007711630"
    ChallengeRoadID=("2778599067_2649503587_2299859278")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TimeRiftBazaarsSewers();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.TheAshPit();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.LowPolyHell();
}