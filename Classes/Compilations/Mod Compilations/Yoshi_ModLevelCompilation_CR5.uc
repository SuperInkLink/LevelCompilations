class Yoshi_ModLevelCompilation_CR5 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50005
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 5"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976424384"
    ChallengeRoadID=("1553065007_1555258731_1729621873_1790976083")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.PickYourPoison();
    Levels[1] = class'Yoshi_ModLevelsSHeet'.static.GearTowerRift();
    Levels[2] = class'Yoshi_ModLevelsSHeet'.static.RandomObjectsPlatforming();
    Levels[3] = class'Yoshi_ModLevelsSHeet'.static.ThatBuilding();

}