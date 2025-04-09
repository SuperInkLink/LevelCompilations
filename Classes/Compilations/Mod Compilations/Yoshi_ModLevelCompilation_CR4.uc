class Yoshi_ModLevelCompilation_CR4 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50004
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 4"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976417594"
    ChallengeRoadID=("1764291985_1783277839")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.IronskyFactory();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.GreenCleanRooftops();
}