class Yoshi_ModLevelCompilation_CR22 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50022
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 22"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2300908725"
    ChallengeRoadID=("1870549042_2192592337_2247271361")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.MetroCityMidnight();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.RoadToNowhere();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.PinkSunrise();
}