//All Mod Death Wishes that take place in Base-Game Levels
class Yoshi_ModLevelCompilation_DeathWishModderMashup extends Yoshi_RandomizerLevelCompilation;

defaultproperties
{
    CompilationID=60009
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.RandomizedComp';
    CompName="Base-Game DW Modded Mania"
    RandomizerLevelCount=40 //41
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2157891934";
}

function PossibleLevelsList() {
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TourCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunPerfect());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PinkPawJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.GreenCleanSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PinkSpeedrunManhole());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.QuickGetaway());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CBBRumbiCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.LimitedBudget());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RiftOfCrows());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.LimitsOfMafia());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.VoyageJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CakeJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.StudioJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ToiletJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SnatcherLimits());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwilightSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.WelcomeToSpeedrunTown());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunObligations());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MyurderSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ShipTimer());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PicturePrecision());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RiftOfRaccoons());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MountainRiftCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwilightTravelsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeeedPinkPaw());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JabRumbiCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RushedHour());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FracturedMask());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JumplessWindmill());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.InCloseQuarters());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.AlrightLassy());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisinPlus());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ShipShapeButWalls());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SurvivingTheStorm());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroMafiaBoss());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroDirectors());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroMU());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroUltraSnootch());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PinkManholeJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisePons());
    //PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisinJumpin());   // :( Mods above the int limit will not work
}