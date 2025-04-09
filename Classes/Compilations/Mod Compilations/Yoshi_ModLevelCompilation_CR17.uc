class Yoshi_ModLevelCompilation_CR17 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50017
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 17"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2061253118"
    ChallengeRoadID=("2016921743_2032666415")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.SkydomeMadness();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.AfternoonTimeRift();

}