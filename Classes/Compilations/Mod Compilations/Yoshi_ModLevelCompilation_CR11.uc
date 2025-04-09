class Yoshi_ModLevelCompilation_CR11 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50011
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 11"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976433601"
    ChallengeRoadID=("1870549042_1898397262")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.TimeRiftSuperheatedPanic();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.PinkSunrise();

}