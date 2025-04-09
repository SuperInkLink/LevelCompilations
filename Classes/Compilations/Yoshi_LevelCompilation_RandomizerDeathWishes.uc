/*
* RandomizerDeathWishes - Contains All Base Game Death Wishes (that can be played in Level Comps) and chooses 10. 
*
*/
class Yoshi_LevelCompilation_RandomizerDeathWishes extends Yoshi_RandomizerLevelCompilation;

defaultproperties
{
    CompilationID=20
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.RandomizedComp';
    CompName="Randomizer (Death Wish)"
    RandomizerLevelCount=10
}

function PossibleLevelsList() {
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.BeatTheHeat());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.SYBFOS());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.Collectathon());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.VaultCodesInTheWind());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.SSFOS());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiasJumps());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.EncoreEncore());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiaOfCooksRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.SecurityBreach());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.Hootenanny());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.TenSeconds());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.KillingTwoBirds());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeadBirdStudioRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.RhythmJumpStudio());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.Impossible());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.BreachingTheContract());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.SleepySubconRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.TwilightTravels());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.BirdSanctuary());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.WoundUpWindmill());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.TheIllnessHasSpeedrun());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.AlpineSkylineRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.TheMountainRift());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.MustacheGauntlet());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.NoMoreBadGuys());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.CruisinForABruisin());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeepSeaRC());
}