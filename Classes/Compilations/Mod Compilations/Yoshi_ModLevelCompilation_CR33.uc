class Yoshi_ModLevelCompilation_CR33 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50033
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 33"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010171088"
    ChallengeRoadID=("2864140131_2863738668_2811144310_2422485117")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.LuminousForest();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftPopp();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.OutOfSight();
	Levels[3] = class'Yoshi_ModLevelsSheet'.static.GrapeJuiceGulf();
}