class Yoshi_LevelCompilation_CruiseIW extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=7
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.CruiseIW'
    CompName="The Arctic Cruise IW"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_LevelsSheet'.static.BonVoyage();
    Levels[1] = class'Yoshi_LevelsSheet'.static.ShipShape();
    Levels[2] = class'Yoshi_LevelsSheet'.static.RockTheBoat();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Balcony();
    Levels[4] = class'Yoshi_LevelsSheet'.static.DeepSea();
}