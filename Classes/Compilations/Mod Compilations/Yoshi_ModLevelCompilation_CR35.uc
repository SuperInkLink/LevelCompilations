class Yoshi_ModLevelCompilation_CR35 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50035
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 35"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010172627"
    ChallengeRoadID=("2863788900_2372662695_2080700978")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.CookieHeaven();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.RiftLock();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.DeeperSea();
}