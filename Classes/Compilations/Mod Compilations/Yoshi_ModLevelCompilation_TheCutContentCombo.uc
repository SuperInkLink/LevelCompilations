class Yoshi_ModLevelCompilation_TheCutContentCombo extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60002
    Icon=Texture2D'HatInTime_UI_DemoMenu.Textures.chapter1act1'
    CompName="The Past Revisited"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976444788"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.TheLostFloor();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.SecretBehindTheBookcase();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.SecretLevelRectangles();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.MafiasCutActs();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.BetaHeroChallenge();
}