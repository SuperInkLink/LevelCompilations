class Yoshi_ModLevelCompilation_CR10 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50010
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 10"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976432803"
    ChallengeRoadID=("1858074314_1860578539_1867356359")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.ZestyOrange();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.RainbowBlues();
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.TheBlues();

}