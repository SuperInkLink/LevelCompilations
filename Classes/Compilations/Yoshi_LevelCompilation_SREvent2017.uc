class Yoshi_LevelCompilation_SREvent2017 extends Yoshi_LevelCompilation;
//Shoutouts to doesthisusername the winner of the 2017 Speedrunning Event
//https://www.speedrun.com/ahitbb/run/y458r4nm

defaultproperties
{
    CompilationID=9
    Icon=Texture2D'yoshi_levelcomp_content.Textures.TR'
    CompName="2017 Speedrunning Event"
}

function LevelsList() {
    Levels.Add(3);
    Levels[0] = class'Yoshi_LevelsSheet'.static.MafiaOfCooks();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Bazaar();
    Levels[2] = class'Yoshi_LevelsSheet'.static.TR();
}
