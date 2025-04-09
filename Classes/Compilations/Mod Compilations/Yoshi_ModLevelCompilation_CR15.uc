class Yoshi_ModLevelCompilation_CR15 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50015
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 15"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2061246314"
    ChallengeRoadID=("1927885536_1932861442_1952205936")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.Geothermal();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftObstacleCourse();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.LowPolyHeaven();

}