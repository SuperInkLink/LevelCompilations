class Yoshi_ModLevelCompilation_CR13 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50013
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 13"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976435278"
    ChallengeRoadID=("1868564702_1881806683")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.WindyAlpineRift();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftBarrage();

}