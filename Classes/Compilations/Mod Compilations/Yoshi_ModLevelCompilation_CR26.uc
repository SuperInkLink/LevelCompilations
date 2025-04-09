class Yoshi_ModLevelCompilation_CR26 extends Yoshi_ChallengeRoadLevelCompilation;

defaultproperties
{
    CompilationID=50026
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW'
    CompName="Challenge Road 26"
    IsPastIntLimit=true
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=3007707867"
    ChallengeRoadID=("2280207510_2331180798_2402771634_2409047837")
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.PersonalSpace();
	Levels[1] = class'Yoshi_ModLevelsSheet'.static.TimeRiftCogs();
	Levels[2] = class'Yoshi_ModLevelsSheet'.static.ColdHearted();
	Levels[3] = class'Yoshi_ModLevelsSheet'.static.GlitterWaterSanctuary();
}