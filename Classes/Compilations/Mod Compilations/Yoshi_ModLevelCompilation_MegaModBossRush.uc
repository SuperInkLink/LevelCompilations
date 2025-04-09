class Yoshi_ModLevelCompilation_MegaModBossRush extends Yoshi_ModLevelCompilation;
//I'd like to give a quick shoutout to SuperInkLink, whom I dedicate this Compilation to. They're awesome.

defaultproperties
{
    CompilationID=60004
    Icon=Texture2D'yoshi_levelcomp_content.Textures.STD'
    CompName="Mega Mod Boss Rush"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976439655"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.MafiaBoss3D();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.HatKidDeliversaNinktontoProControllerTheGrandeJourneyofaLifetime();
    Levels[1].Checkpoint = 8;
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.DwellersRevenge();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.BattleAgainstLight();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.HyperSnatcher();
}


