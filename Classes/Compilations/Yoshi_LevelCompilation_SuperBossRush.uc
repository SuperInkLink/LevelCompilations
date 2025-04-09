class Yoshi_LevelCompilation_SuperBossRush extends Yoshi_LevelCompilation;

defaultproperties
{
    CompilationID=13
    Icon=Texture2D'yoshi_levelcomp_content.Textures.STD'
    CompName="Super Boss Rush"
}

function LevelsList() {
    Levels.Add(10);

    Levels[0] = class'Yoshi_LevelsSheet'.static.DWTM();
    Levels[0].Map = "mafia_hq";
    Levels[0].Checkpoint = 2;
    Levels[1] = class'Yoshi_LevelsSheet'.static.AwardCeremony();
    Levels[1].Map = "djgrooves_boss";
    if(class'Hat_SeqCond_DeadBirdWinner'.static.GetDeadBirdWinner() <= 1) {
	    Levels[1].Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.chapter3_6_conductor';
	}
	else {
		Levels[1].Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.chapter3_6_dj';
	}
    Levels[2] = class'Yoshi_LevelsSheet'.static.TOD();
    Levels[2].Checkpoint = 1;
    Levels[3] = class'Yoshi_LevelsSheet'.static.YCHE();
    Levels[3].Checkpoint = 1;
    Levels[4] = class'Yoshi_LevelsSheet'.static.Finale();
    Levels[4].Checkpoint = 8;
    Levels[5] = class'Yoshi_LevelsSheet'.static.EncoreEncore();
    Levels[6] = class'Yoshi_LevelsSheet'.static.KillingTwoBirds();
    Levels[7] = class'Yoshi_LevelsSheet'.static.BreachingTheContract();
    Levels[8] = class'Yoshi_LevelsSheet'.static.NoMoreBadGuys();
    Levels[9] = class'Yoshi_LevelsSheet'.static.SealTheDeal();
    Levels[9].Map = "subconforest";
    Levels[9].Act = 6;

}