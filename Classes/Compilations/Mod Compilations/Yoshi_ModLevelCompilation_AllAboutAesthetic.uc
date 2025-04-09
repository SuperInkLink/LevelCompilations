class Yoshi_ModLevelCompilation_AllAboutAesthetic extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60003
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.AllAboutAesthetic'
    CompName="All About Aesthetic"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=1976437249"
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.RetroRomp();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.CherryMountainSprings();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.VaporwaveDream();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.ShinySlushieFalls();

}