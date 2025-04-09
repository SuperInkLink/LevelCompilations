class Yoshi_LevelCompilation_DeliveryAgent extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=15
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.SS';
    CompName="Delivery Agent"
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_LevelsSheet'.static.MDS();
    Levels[1] = class'Yoshi_LevelsSheet'.static.ShipShape();
    Levels[2] = class'Yoshi_LevelsSheet'.static.CruisinForABruisin();
}