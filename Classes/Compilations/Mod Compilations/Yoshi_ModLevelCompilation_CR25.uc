class Yoshi_ModLevelCompilation_CR25 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50025
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 25"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007706734"
    ChallengeRoadID=("2355007342_2277188345_2082859638")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.MafiaCliffside();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.TheDarknessTimeRift();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.BlueRiftMetroPoint();
}