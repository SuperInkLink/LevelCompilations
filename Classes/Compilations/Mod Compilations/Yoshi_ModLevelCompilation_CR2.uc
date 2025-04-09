class Yoshi_ModLevelCompilation_CR2 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50002
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 2"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976398593"
    ChallengeRoadID=("1752423506_1764360895")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.OperationReRail();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.JustOutOfReach();
}