class Yoshi_ModLevelCompilation_ModdersChoice1 extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60007
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.RandomizedComp'
    CompName="Modder's Choice #1"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976442599"
}

function LevelsList() {
    Levels.Add(6);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.NoBonkSurfing();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.MafiaChucksterTrainingGrounds();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.RiftRunner();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.Farewell();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.MonkyBallEscapeFromHell();
    Levels[5] = class'Yoshi_ModLevelsSheet'.static.EveryBossAtOnce();

}