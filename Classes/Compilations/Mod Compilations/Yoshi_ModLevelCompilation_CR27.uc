class Yoshi_ModLevelCompilation_CR27 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50027
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 27"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007708924"
    ChallengeRoadID=("2420781865_2339956873_2298299124")
}

function LevelsList() {
    Levels.Add(2);
	//Welcome to Mafia Rift was removed from the workshop
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.BlueRiftRopes();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.ThroughTheLeaves();
}