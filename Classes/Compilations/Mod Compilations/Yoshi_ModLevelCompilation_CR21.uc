class Yoshi_ModLevelCompilation_CR21 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50021
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 21"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2211393855"
    ChallengeRoadID=("1747469442_1763897578_1868564702_2184242017")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.HotelWarped();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftBarrage();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.NyatronicManhole();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.FogginFunkyMauveMetro();
}