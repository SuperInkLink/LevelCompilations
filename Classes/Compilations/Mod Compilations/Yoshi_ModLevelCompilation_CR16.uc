class Yoshi_ModLevelCompilation_CR16 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50016
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 16"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2061250778"
    ChallengeRoadID=("1964866705_1987659543_1999598176")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.SkyHighStation();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftCherryOcean();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.FrostburnCliffsDemo();

}