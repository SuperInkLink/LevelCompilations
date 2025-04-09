class Yoshi_ModLevelCompilation_CR19 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50019
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 19"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2156821922"
    ChallengeRoadID=("1395430644_1870181629_1943894751_2092051902_2114501114")
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.CrystalCove();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.AMistyDream();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.ChillRift();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.Farewell();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.SmallRelaxingLevel();
}