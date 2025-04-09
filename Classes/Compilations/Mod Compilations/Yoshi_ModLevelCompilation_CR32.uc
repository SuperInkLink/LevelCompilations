class Yoshi_ModLevelCompilation_CR32 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50032
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 32"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010168988"
    ChallengeRoadID=("2839446922_2819080591")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TimePieces();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.CreatorDLCImmersion();
}