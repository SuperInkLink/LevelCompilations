class Yoshi_ModLevelCompilation_CR7 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50007
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 7"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976430932"
    ChallengeRoadID=("1756543599_1838984027")
}

function LevelsList() {
    Levels.Add(2);
    Levels[0] = class'Yoshi_ModLevelsSHeet'.static.TimeRiftCosmic();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.AglaophotisTransitHub();
    
}