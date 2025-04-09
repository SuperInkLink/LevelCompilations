class Yoshi_ModLevelCompilation_CR9 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50009
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 9"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976432294"
    ChallengeRoadID=("1871342197_1872109003")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.YellowJelloRift();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.CasinoRift();

}