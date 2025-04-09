class Yoshi_LevelCompilation_GottaGoFast extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=14
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.CTR';
    CompName="Gotta Go Fast"
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_LevelsSheet'.static.SSFOS();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Impossible();
    Levels[2] = class'Yoshi_LevelsSheet'.static.TheIllnessHasSpeedrun();
    Levels[3] = class'Yoshi_LevelsSheet'.static.CTR();
}