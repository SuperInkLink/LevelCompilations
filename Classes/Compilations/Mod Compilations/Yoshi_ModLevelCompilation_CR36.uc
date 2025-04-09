class Yoshi_ModLevelCompilation_CR36 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50036
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 36"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3010179096"
    ChallengeRoadID=("2878714864_2793071100")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TimeRiftClimb();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.TheHorselessHeadlessHorsemann();
}