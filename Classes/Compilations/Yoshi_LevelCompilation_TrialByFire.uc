class Yoshi_LevelCompilation_TrialByFire extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=10
    Icon=Texture2D'yoshi_levelcomp_content.Textures.HUMT'
    CompName="Trial By Fire"
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_LevelsSheet'.static.HUMT();
    Levels[1] = class'Yoshi_LevelsSheet'.static.LavaCake();
    Levels[2] = class'Yoshi_LevelsSheet'.static.Finale();
}