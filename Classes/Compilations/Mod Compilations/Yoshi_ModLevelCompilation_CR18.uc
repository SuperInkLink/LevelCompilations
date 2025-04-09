class Yoshi_ModLevelCompilation_CR18 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50018
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 18"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2156818967"
    ChallengeRoadID=("2034880681_2062053686_2067407764")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.ConcertCrashing();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.FadolaPurpleTimeRift();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.ChocolateRift();

}