class Yoshi_ModLevelCompilation_BirdsOfPrey extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60006
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.BirdsOfPrey';
    CompName="Birds of Prey"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2069950864"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.ConductorAndGrooves2D();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.TheDayThatTimeCollapsed();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.ConductorsBulletHell();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.KillingAllBirds();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.TheRevengeOfAward42();
}