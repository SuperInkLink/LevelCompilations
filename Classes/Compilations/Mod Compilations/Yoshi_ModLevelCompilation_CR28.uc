class Yoshi_ModLevelCompilation_CR28 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50028
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 28"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007710074"
    ChallengeRoadID=("2740364755_2623295998_2359975490")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.SimplyAesthetic();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.HookshotHavoc();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.SkyTreeWalkway();
}