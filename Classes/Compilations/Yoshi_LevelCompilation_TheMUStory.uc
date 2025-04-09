class Yoshi_LevelCompilation_TheMUStory extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=17
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.Finale';
    CompName="The Story of MU"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_LevelsSheet'.static.WTMT();
    Levels[1] = class'Yoshi_LevelsSheet'.static.BB();
    Levels[2] = class'Yoshi_LevelsSheet'.static.DWTM();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Finale();
    Levels[4] = class'Yoshi_LevelsSheet'.static.Tour();
}