class Yoshi_LevelCompilation_TheParadeOfParades extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=16
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.TBP';
    CompName="The Parading Parades"
}

function LevelsList() {
    Levels.Add(4);
    Levels[0] = class'Yoshi_LevelsSheet'.static.Moon();
    Levels[1] = class'Yoshi_LevelsSheet'.static.Parade();
    Levels[2] = class'Yoshi_LevelsSheet'.static.AwardCeremony();
    Levels[2].Map = "djgrooves_boss";
    if(class'Hat_SeqCond_DeadBirdWinner'.static.GetDeadBirdWinner() <= 1) {
	    Levels[2].Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.chapter3_6_conductor';
	}
	else {
		Levels[2].Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.chapter3_6_dj';
	}
    Levels[3] = class'Yoshi_LevelsSheet'.static.Hootenanny();
}