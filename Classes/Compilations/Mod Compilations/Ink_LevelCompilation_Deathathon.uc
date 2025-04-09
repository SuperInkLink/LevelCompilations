/*
* THE EPIC DEATHATHON, BRINGER OF PAIN, A SOURCE OF AMUSEMENT FOR AT LEAST 2 SOULS. 
* MANY WONDER WHY SOMEONE WOULD SUBJECT THEMSELVES TO PLAYING SO MANY LEVELS.
* I WONDER TOO, WILL YOU CONQUER THE ULTIMATE GAUNTLET AND JOIN THE RANKS OF CHAMPIONS?
*/
class Ink_LevelCompilation_Deathathon extends Yoshi_RandomizerLevelCompilation;

const OldDeathathonLevelCount = 115;

var const string OldDeathathonURL;

defaultproperties
{
    CompilationID=99998 //Wow what an ID, this one needs to always be last.
    Icon=Texture2D'Yoshi_LevelComp_Content2.Textures.Deathathon';
    CompName="Deathathon"
    RandomizerLevelCount=201
    RandomizerTitlecard=Texture2D'Yoshi_LevelComp_Content2.Textures.Deathathon_Titlecard_Final'
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2120872753";
    OldDeathathonURL="https://steamcommunity.com/workshop/filedetails/?id=2446324265";
}

function int GetLevelsCount() {
    if(IsOnNewLevelCompsVersion()){
        return RandomizerLevelCount;
    }

    return OldDeathathonLevelCount;
}

function Initialize() {
    local int i;

    Levels = (!IsOnNewLevelCompsVersion()) ? GetARandomSetOfLevels(OldDeathathonLevelCount) : GetARandomSetOfLevels(default.RandomizerLevelCount);
    
    for(i = 0; i < Levels.Length; i++) {
        Levels[i].Titlecard = RandomizerTitlecard;
    }

    Super(Yoshi_ModLevelCompilation).Initialize(); //The parent class will get the level set again, we don't want that
}

function LevelsList() {
    local int i;
    
    Levels = (!IsOnNewLevelCompsVersion()) ? GetARandomSetOfLevels(OldDeathathonLevelCount) : GetARandomSetOfLevels(default.RandomizerLevelCount);

    //Obscure Level Information
    
    for(i = 0; i < Levels.Length; i++) {
        Levels[i].Titlecard = RandomizerTitlecard;
    }
}

static function OpenCollection()
{
	local string WorkshopURL;

    if(IsOnNewLevelCompsVersion()) {
        WorkshopURL = default.CompilationURL;
    }
    else {
        WorkshopURL = default.OldDeathathonURL;
    }

	class'Hat_GameManager_Base'.static.OpenBrowserURL(WorkshopURL);
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
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MafiaBoss3D());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DwellersRevenge());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BattleAgainstLight());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.HyperSnatcher());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SecretHellRectangles());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.EveryEXBossAtOnce());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.Killing2DBirds());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.UnlikelyDuo());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SightOfTooManyKnives());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.KillingAllBeefedBirds());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RevengeOfTwoBirds());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.InfernoOfTheCosmos());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TourCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ThroughTheCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunPerfect());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FirePitOfPain());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.AutumnDreamsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OMNIPRESENT());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DeclarationJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DeclarationSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.NyatronicRush());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.Hatter());
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
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OffTheRailsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SleepingHollowsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FourFloorCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ResurrectionPeckSide());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ElectricUndergroundCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FracturedMask());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ClockStrikesBack());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PurplePonChaos());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MechanicalMemorySpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DeadBirdMetroCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SlipperySlope());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FranticNightShift());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CafeEleganzeCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FrappeSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.HyperMafiaBoss());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.killingtwoobirds());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JumplessWindmill());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.KillingFourBirds());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.UnpeacefulRoad());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BlueBonanzaCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.mafiaboss());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.InCloseQuarters());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.StressBoogaloo());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.StressEndless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TurningDoubleTime());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.LateToTheRescue());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TripleSnootch());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwoBirdsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.AlrightLassy());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisinPlus());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ShipShapeButWalls());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SurvivingTheStorm());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BouncinCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OpenTheDoor());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroMafiaBoss());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroDirectors());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroMU());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PreMetroUltraSnootch());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PinkManholeJumpless());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.EricsRevenge());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisePons());

    //
    // ALL MODS PAST THE INT LIMIT ARE BELOW
    //

    if(!IsOnNewLevelCompsVersion()) return; //We don't want them getting these levels, they won't function properly with the old ID system

    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DwellerSpeenTower());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TrainBrainWreck());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CruisinJumpin());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwilightJumps());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.VaultJumps());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.VanessaJumps());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.HeatingSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CakeSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MailSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BirdSeason());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.AllZonesRun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PonVoyage());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JumpTheBoat());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SinkingFeeling());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunVoyage());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunShape());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunBoat());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BurgerSpectrum());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SummertimeSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BarrelingForwards());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.YellowSpeedrunStation());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.YellowSpeedrunManhole());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JumplessHour());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DoleDipDie());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PushyPain());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.HotelJumps());

    //The oh no update levels are below

    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RushHorButGud());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.HellCubes());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OHGODOHPECK());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TripleULTRASnootch());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SandBehindTheSlaughter());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.YoIceSurfingPog());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedyPolice());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SandySailsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OneFlask());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CountdownToPumpkin());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PumpkinTour());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MoonjumperEX());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MafiaMania());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CollectathonCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.VacationTourCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TimesEndCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.EightBallsOhNo());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ClashAgainstLight());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ShipShapButGud());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.UltraDirectors());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MetroCollectathon());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpeedrunAwardCeremony());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.VanessaSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OhHelloMafiaRiftOfModderAlabra());

    //JESUS PECK THAT'S A LOT OF NEW LEVELS
    
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ReachingOverclock());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RhythmCollapseStudio());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DanceRealmDisco());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TragedyOfSmolChild());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BIGBIGRUMBUS());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BurntWallet());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FireHazard());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ToiletButBonuses());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CookinForABruisin());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PenthouseJumps());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DeepCollapseButGud());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CrateParade());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PackingIt());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CrateHour());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BoxedIn());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RecyclingDay());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ProperFilming());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.RoadToTimeTrial());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.UnstableBirdhouse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ExplosiveObligations());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.NitroFueled());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.NitroBirdStudios());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MoonCrater());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.WinnerWinnerDirectorDinner());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OuterwallScale());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.PerfectRun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TheLongRun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BlueBonanzaJumps());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OyxgenNotIncluded());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SpringBreakout());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OvercookedCake());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ColdHearted());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.KickStart());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.GreyRiftSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MovementSpeedrun());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MafiaPurgatory());
}