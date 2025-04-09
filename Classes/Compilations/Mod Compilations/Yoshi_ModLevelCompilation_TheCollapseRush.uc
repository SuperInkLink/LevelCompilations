//All Rift Collapses Modded and Un-Modded
class Yoshi_ModLevelCompilation_TheCollapseRush extends Yoshi_RandomizerLevelCompilation;

defaultproperties
{
    CompilationID=60008
    Icon=Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    CompName="The Collapse Rush"
    RandomizerLevelCount=22
    CompilationURL="https://steamcommunity.com/sharedfiles/filedetails/?id=2157873112";
    RandomizerTitlecard=Texture2D'HatInTime_Titlecards_DW.caverift'
}

function PossibleLevelsList() {
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiaOfCooksRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeadBirdStudioRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.SleepySubconRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.AlpineSkylineRC());
    PossibleLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeepSeaRC());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TourCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ThroughTheCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.AutumnDreamsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CBBRumbiCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.MountainRiftCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwilightTravelsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.JabRumbiCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OffTheRailsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.SleepingHollowsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.FourFloorCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.ElectricUndergroundCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.DeadBirdMetroCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.CafeEleganzeCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BlueBonanzaCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.TwoBirdsCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.BouncinCollapse());
    PossibleLevels.AddItem(class'ALLDEATHWISHESAAA'.static.OpenTheDoor());
}