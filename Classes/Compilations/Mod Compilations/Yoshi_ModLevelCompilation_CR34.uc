class Yoshi_ModLevelCompilation_CR34 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50034
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 34"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010171860"
    ChallengeRoadID=("2862305228_2796898388_2796185915")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TimeRiftWallrun();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.AlphineVillage();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.RippleBendReef();
}