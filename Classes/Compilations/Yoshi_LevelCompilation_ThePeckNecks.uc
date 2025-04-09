class Yoshi_LevelCompilation_ThePeckNecks extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=18
    Icon=Texture2D'yoshi_levelcomp_content.Textures.MOTOE';
    CompName="The Peck Necks"
}

function LevelsList() {
    Levels.Add(5);
    Levels[0] = class'Yoshi_LevelsSheet'.static.Birdhouse();
    Levels[1] = class'Yoshi_LevelsSheet'.static.DBS();
    Levels[2] = class'Yoshi_LevelsSheet'.static.MOTOE();
    Levels[3] = class'Yoshi_LevelsSheet'.static.Lab();
    Levels[4] = class'Yoshi_LevelsSheet'.static.BirdSanctuary();
}