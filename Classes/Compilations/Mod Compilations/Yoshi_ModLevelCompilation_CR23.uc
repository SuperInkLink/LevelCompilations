class Yoshi_ModLevelCompilation_CR23 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50023
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 23"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/workshop/filedetails/?id=2431791881"
    ChallengeRoadID=("2308885325_2245723287_2067407764")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.ConcertCrashing();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.WassupEightBallTimeRift();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.ForestCascade();
}