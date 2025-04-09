class Yoshi_ModLevelCompilation_FireAndIce extends Yoshi_ModLevelCompilation;

defaultproperties
{
    CompilationID=60005
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.FireAndIce'
    CompName="Fire and Ice"
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2069946424"
}

function LevelsList() {
    Levels.Add(6);
    Levels[0] = class'Yoshi_ModLevelsSheet'.static.IceSurfingRift();
    Levels[1] = class'Yoshi_ModLevelsSheet'.static.FlawlessFireFrensy();
    Levels[2] = class'Yoshi_ModLevelsSheet'.static.SnowsideValley();
    Levels[3] = class'Yoshi_ModLevelsSheet'.static.TheLavaLands();
    Levels[4] = class'Yoshi_ModLevelsSheet'.static.ColdsnapCanyon();
    Levels[5] = class'Yoshi_ModLevelsSheet'.static.InfernoOfTheCosmos();
}