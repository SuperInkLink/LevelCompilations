class Yoshi_ModLevelCompilation_CR3 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50003
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 3"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976416016"
    ChallengeRoadID=("1488378746_1763897578_1773428285")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.ExactlyTwelveRedBalloons();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.NyatronicManhole();
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.FourFloorRun();
}