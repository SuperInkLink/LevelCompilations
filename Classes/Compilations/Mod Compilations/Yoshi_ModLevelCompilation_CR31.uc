class Yoshi_ModLevelCompilation_CR31 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50031
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 31"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010168337"
    ChallengeRoadID=("2824221093_2818305189")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TheHandsOfTime();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.SpiralingTower();
}