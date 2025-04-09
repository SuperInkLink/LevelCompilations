class Yoshi_ModLevelCompilation_CR6 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50006
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 6"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976429636"
    ChallengeRoadID=("1833176836_1836094966")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.MetroNyascent();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.TheTempleOfHats();
}