class Yoshi_ModLevelCompilation_CR24 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50024
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 24"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2431794263"
    ChallengeRoadID=("1439844465_1444853809_1471946659_1530471945")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.JustLikeClockwork();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.BlueTimeRiftTwistyTrialsGalaxy();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.QuickRift();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.MafiasIcebox();
}