class Yoshi_ModLevelCompilation_CR8 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50008
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 8"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976431457"
    ChallengeRoadID=("1746856004_1807533276_1859132297")
}

function LevelsList() {
    Levels.Add(3);
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.PurpleBlueRift();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.TrainbowRoad();
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.UncalmGalaxy();

}