class Yoshi_ModLevelCompilation_CR1 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50001
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 1"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976375711"
    ChallengeRoadID=("1758385712_1757019439_1747469442")
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.RunwayRift();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.MetroRift();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.FogginFunkyMauveMetro();
}