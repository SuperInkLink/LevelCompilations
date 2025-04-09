class Yoshi_ModLevelCompilation_CR20 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50020
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 20"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2211392506"
    ChallengeRoadID=("2093601179_2175767296_2178746597")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.AlpineDreamstate();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.ASpiralClimb();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.CookiesAndCreamRift();
}