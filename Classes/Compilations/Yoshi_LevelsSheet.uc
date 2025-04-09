class Yoshi_LevelsSheet extends Object
    dependsOn(Yoshi_LevelCompilation);

//Spaceship COMPLETE!
static function CompilationLevel Lab() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Spaceship_Mail";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.hub_spaceship';
    L.ActName = "The Lab";
    L.isRift = 1;
    L.TP = "Spaceship_WaterRift_Mailroom";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel Gallery() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Spaceship";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.hub_spaceship';
    L.ActName = "The Gallery";
    L.isRift = 1;
    L.TP = "Spaceship_WaterRift_Gallery";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel Tour() {
    Local CompilationLevel L;
    L.Map = "TimeRift_Cave_Tour";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.hub_spaceship';
    L.ActName = "Tour";
    L.isRift = 2;
    L.TP = "TimeRift_Cave_Tour";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Mafia Town COMPLETE!
static function CompilationLevel WTMT() {
    local CompilationLevel L;
    L.Map = "mafia_town";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 1;
    L.ActName = "Welcome to Mafia Town";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter1_1';
    L.TP = "chapter1_tutorial";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.MafiaTownIW';
    return L;
}

static function CompilationLevel BB() {
    local CompilationLevel L;
    L.Map = "mafia_town";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 2;
    L.ActName = "Barrel Battle";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter1_2';
    L.TP = "chapter1_barrelboss";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.BB';
    return L;
}

static function CompilationLevel SCFOS() {
    local CompilationLevel L;
    L.Map = "mafia_town_night";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 3;
    L.ActName = "She Came From Outer Space";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter1_3';
    L.TP = "chapter1_cannon_repair";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SCFOS';
    return L;
}

static function CompilationLevel DWTM() {
    local CompilationLevel L;
    L.Map = "mafia_town_night";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 4;
    L.ActName = "Down With the Mafia";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter1_4';
    L.TP = "chapter1_boss";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.DWTM';
    return L;
}

static function CompilationLevel GV() {
    local CompilationLevel L;
    L.Map = "mafia_town";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 7;
    L.ActName = "The Golden Vault";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter_1_7';
    L.TP = "mafiatown_goldenvault";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.GV';
    return L;
}

static function CompilationLevel HUMT() {
    local CompilationLevel L;
    L.Map = "mafia_town_lava";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 6;
    L.ActName = "Heating Up Mafia Town";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter1_6';
    L.TP = "mafiatown_lava";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.HUMT';
    return L;
}

static function CompilationLevel CTR() {
    local CompilationLevel L;
    L.Map = "mafia_town";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ChapterID = 1;
    L.Act = 5;
    L.ActName = "Cheating the Race";
    L.ChapterName = "MAFIA TOWN";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch1.Textures.chapter_1_5';
    L.TP = "harbor_impossible_race";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.CTR';
    return L;
}

static function CompilationLevel Sewers() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Mafia_Easy";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ActName = "Sewers";
    L.isRift = 1;
    L.TP = "TimeRift_Water_Mafia_Easy";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel Bazaar() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Mafia_Hard";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ActName = "Bazaar";
    L.isRift = 1;
    L.TP = "TimeRift_Water_Mafia_Hard";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel MafiaOfCooks() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_Mafia";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.MafiaTown';
    L.ActName = "Mafia of Cooks";
    L.isRift = 2;
    L.TP = "TimeRift_Cave_Mafia";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Battle of the Birds COMPLETE!
static function CompilationLevel DBS() {
    local CompilationLevel L;
    L.Map = "DeadBirdStudio";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 1;
    L.ActName = "Dead Bird Studio";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_1';
    L.TP = "DeadBirdStudio";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.DBS';
    return L;
}

static function CompilationLevel MOTOE() {
    local CompilationLevel L;
    L.Map = "chapter3_murder";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 2;
    L.ActName = "Murder on the Owl Express";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_2';
    L.TP = "chapter3_murder";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.MOTOE';
    return L;
}

static function CompilationLevel PP() {
    local CompilationLevel L;
    L.Map = "themoon";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 3;
    L.ActName = "Picture Perfect";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_3';
    L.TP = "moon_camerasnap";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.PP';
    return L;
}

static function CompilationLevel TR() {
    local CompilationLevel L;
    L.Map = "trainwreck_selfdestruct";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 4;
    L.ActName = "Train Rush";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_4';
    L.TP = "trainwreck_selfdestruct";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TR';
    return L;
}

static function CompilationLevel Parade() {
    local CompilationLevel L;
    L.Map = "themoon";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 5;
    L.ActName = "The Big Parade";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_5';
    L.TP = "moon_parade";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TBP';
    return L;
}

static function CompilationLevel FakeAwardCeremony() {
    local CompilationLevel L;
    L.Map = "dead_cinema";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 6;
    L.ActName = "(Fake) Award Ceremony";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_6';
    L.TP = "award_ceremony";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW';
    return L;
}

static function CompilationLevel AwardCeremony() {
    local CompilationLevel L;
    L.Map = "DeadBirdStudio";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ChapterID = 2;
    L.Act = 6;
    L.ActName = "Award Ceremony";
    L.ChapterName = "BATTLE OF THE BIRDS";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch3.Textures.Chapter3_6';
    L.TP = "chapter3_secret_finale";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.BattleOfTheBirdsIW';
    return L;
}

static function CompilationLevel OwlExpress() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_TWreck_Panels";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ActName = "The Owl Express";
    L.isRift = 1;
    L.TP = "TimeRift_Water_TWreck_Panels";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel Moon() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_TWreck_Parade";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ActName = "The Moon";
    L.isRift = 1;
    L.TP = "TimeRift_Water_TWreck_Parade";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel DBSRift() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_DeadBird";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.trainwreck_of_science';
    L.ActName = "Dead Bird Studio";
    L.isRift = 2;
    L.TP = "TimeRift_Cave_BirdBasement";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Subcon Forest COMPLETE!
static function CompilationLevel CO() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 1;
    L.ActName = "Contractual Obligations";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter2_1';
    L.TP = "subcon_village_icewall";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.CO';
    return L;
}

static function CompilationLevel SW() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 2;
    L.ActName = "The Subcon Well";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter_2_2';
    L.TP = "subcon_cave";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.sw';
    return L;
}

static function CompilationLevel TOD() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 3;
    L.ActName = "Toilet of Doom";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter2_3';
    L.TP = "chapter2_toiletboss";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TOD';
    return L;
}

static function CompilationLevel Manor() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 4;
    L.ActName = "Queen Vanessa's Manor";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter_2_4';
    L.TP = "vanessa_manor_attic";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.VM';
    return L;
}

static function CompilationLevel MDS() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 5;
    L.ActName = "Mail Delivery Service";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter2_5';
    L.TP = "subcon_maildelivery";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.MDS';
    return L;
}

static function CompilationLevel YCHE() {
    local CompilationLevel L;
    L.Map = "subconforest";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ChapterID = 3;
    L.Act = 6;
    L.ActName = "Your Contract Has Expired";
    L.ChapterName = "SUBCON FOREST";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter2_7';
    L.TP = "snatcher_boss";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SubconIW';
    return L;
}

static function CompilationLevel Pipe() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Subcon_Hookshot";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ActName = "Pipe";
    L.isRift = 1;
    L.TP = "TimeRift_Water_Subcon_Hookshot";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel Village() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Subcon_Dwellers";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ActName = "Village";
    L.isRift = 1;
    L.TP = "TimeRift_Water_Subcon_Dwellers";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel SleepySubcon() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_Raccoon";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.subconforest';
    L.ActName = "Sleepy Subcon";
    L.isRift = 2;
    L.TP = "TimeRift_Cave_Raccoon";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Alpine Skyline COMPLETE!
static function CompilationLevel AlpineFreeRoam() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 1;
    L.ActName = "Free Roam";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_1';
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW';
    return L;
}

static function CompilationLevel LavaCake() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 3;
    L.ActName = "The Lava Cake";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_1';
    L.TP = "AlpineSkyline_WeddingCake";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW';
    return L;
}

static function CompilationLevel Birdhouse() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 4;
    L.ActName = "The Birdhouse";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_1';
    L.TP = "Alps_Birdhouse";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW';
    return L;
}

static function CompilationLevel Windmill() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 13;
    L.ActName = "The Windmill";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_1';
    L.TP = "AlpineSkyline_Windmill";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW';
    return L;
}

static function CompilationLevel TwilightBell() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 15;
    L.ActName = "The Twilight Bell";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_1';
    L.TP = "Alpine_Twilight";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineIW';
    return L;
}

static function CompilationLevel Illness() {
    local CompilationLevel L;
    L.Map = "alpsandsails";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ChapterID = 4;
    L.Act = 1;
    L.ActName = "The Illness Has Spread";
    L.ChapterName = "ALPINE SKYLINE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch4.Textures.Chapter4_2';
    L.TP = "AlpineSkyline_Finale";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TIHS';
    return L;
}

static function CompilationLevel CurlyTailTrail() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Alp_Cats";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ActName = "Curly Tail Trail";
    L.isRift = 1;
    L.TP = "TimeRift_Water_AlpineSkyline_Cats";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel TwilightBellRift() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Alp_Goats";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ActName = "Twilight Bell";
    L.isRift = 1;
    L.TP = "TimeRift_Water_Alp_Goats";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel AlpineSkylineRift() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_Alps";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Sand_and_Sails';
    L.ActName = "Alpine Skyline";
    L.isRift = 2;
    L.TP = "TimeRift_Cave_Alps";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Finale COMPLETE!
static function CompilationLevel Finale() {
    local CompilationLevel L;
    L.Map = "castle_mu";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo.maingame.Mu_Finale';
    L.ChapterID = 5;
    L.Act = 1;
    L.ActName = "The Finale";
    L.ChapterName = "TIME'S END";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch5.Textures.chapter5_1';
    L.TP = "TheFinale_FinalBoss";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.Finale';
    return L;
}
//Arctic Cruise COMPLETE!
static function CompilationLevel BonVoyage() {
    local CompilationLevel L;
    L.Map = "ship_main";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo_DLC1.ChapterInfos.ChapterInfo_Cruise';
    L.ChapterID = 6;
    L.Act = 1;
    L.ActName = "Bon Voyage!";
    L.ChapterName = "THE ARCTIC CRUISE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Cruise.Textures.Cruise_Act1';
    L.TP = "Cruise_Boarding";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.CruiseIW';
    return L;
}

static function CompilationLevel ShipShape() {
    local CompilationLevel L;
    L.Map = "ship_main";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo_DLC1.ChapterInfos.ChapterInfo_Cruise';
    L.ChapterID = 6;
    L.Act = 2;
    L.ActName = "Ship Shape";
    L.ChapterName = "THE ARCTIC CRUISE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Cruise.Textures.Cruise_Act2';
    L.TP = "Cruise_Working";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SS';
    return L;
}

static function CompilationLevel RocktheBoat() {
    local CompilationLevel L;
    L.Map = "ship_main";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo_DLC1.ChapterInfos.ChapterInfo_Cruise';
    L.ChapterID = 6;
    L.Act = 3;
    L.ActName = "Rock the Boat";
    L.ChapterName = "THE ARCTIC CRUISE";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Cruise.Textures.Cruise_Act3';
    L.TP = "Cruise_Sinking";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.RTB';
    return L;
}

static function CompilationLevel Balcony() {
    local CompilationLevel L;
    L.Map = "TimeRift_Water_Cruise_Slide";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo_DLC1.ChapterInfos.ChapterInfo_Cruise';
    L.ActName = "Balcony";
    L.isRift = 1;
    L.TP = "Cruise_WaterRift_Slide";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
    return L;
}

static function CompilationLevel DeepSea() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_Aquarium";
    L.Chapter = Hat_ChapterInfo'HatinTime_ChapterInfo_DLC1.ChapterInfos.ChapterInfo_Cruise';
    L.ActName = "Deep Sea";
    L.isRift = 2;
    L.TP = "Cruise_CaveRift_Aquarium";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//Nyakuza Metro COMPLETE!
static function CompilationLevel FreeRoam() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 98;
    L.ActName = "Free Roam";
    L.ChapterName = "NYAKUZA METRO";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel MainStation() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 99;
    L.ActName = "(Intro) Free Roam";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_Intro";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel YellowOverpass() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 1;
    L.ActName = "Yellow Overpass Station";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_RouteA";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel GreenClean() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 2;
    L.ActName = "Green Clean Station";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_RouteB";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel BluefinTunnels() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 3;
    L.ActName = "Bluefin Tunnels";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_RouteC";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel PinkPaw() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 4;
    L.ActName = "Pink Paw Station";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_RouteD";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel YellowOverpassManhole() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 5;
    L.ActName = "Yellow Overpass Manhole";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_ManholeA";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel GreenCleanManhole() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 6;
    L.ActName = "Green Clean Manhole";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_ManholeB";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel PinkPawManhole() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 7;
    L.ActName = "Pink Paw Manhole";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'HatInTime_Titlecards_Metro.Textures.Metro_FreeRoam';
    L.TP = "Metro_ManholeC";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NyakuzaIW';
    return L;
}

static function CompilationLevel RushHour() {
    local CompilationLevel L;
    L.Map = "dlc_metro";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ChapterID = 7;
    L.Act = 8;
    L.ActName = "Rush Hour";
    L.ChapterName = "NYAKUZA METRO";
    L.Titlecard = Texture2D'hatintime_titlecards_metro.Textures.Metro_Finale';
    L.TP = "Metro_Escape";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.RH';
    return L;
}

static function CompilationLevel RumbiFactory() {
    local CompilationLevel L;
    L.Map = "TimeRift_Cave_RumbiFactory";
    L.Chapter = Hat_ChapterInfo'hatintime_chapterinfo_dlc2.ChapterInfos.ChapterInfo_Metro';
    L.ActName = "Rumbi Factory";
    L.isRift = 2;
    L.TP = "Metro_CaveRift_RumbiFactory";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    return L;
}

//
//Death Wish
//

//Mafia Town COMPLETE!
static function CompilationLevel BeatTheHeat() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_HeatingUpHarder';
    L.ActName = "Beat the Heat";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.BTH';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.MafiaTown_Lava';
    return L;
}

static function CompilationLevel SYBFOS() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_BackFromSpace';
    L.ActName = "So You're Back From Outer Space";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SYBFOS';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_alien';
    return L;
}

static function CompilationLevel Collectathon() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_PonFrenzy';
    L.ActName = "Collectathon";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.Collectathon';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_pons';
    return L;
}

static function CompilationLevel VaultCodesInTheWind() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_MovingVault';
    L.ActName = "Vault Codes In The Wind";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.VCITW';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_vault';
    return L;
}

static function CompilationLevel SSFOS() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_Speedrun_MafiaAlien';
    L.ActName = "She Speedran From Outer Space";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SYBFOS';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_alien';
    return L;
}

static function CompilationLevel MafiasJumps() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_NoAPresses_MafiaAlien';
    L.ActName = "Mafia's Jumps";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SYBFOS';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_alien';
    return L;
}

static function CompilationLevel EncoreEncore() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_MafiaBossEX';
    L.ActName = "Encore! Encore!";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.EE';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.mafiatown_boss';
    return L;
}

static function CompilationLevel MafiaOfCooksRC() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_RiftCollapse_MafiaTown';
    L.ActName = "Rift Collapse: Mafia of Cooks";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.caverift';
    return L;
}

//Battle of the Birds COMPLETE!

static function CompilationLevel SecurityBreach() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_DeadBirdStudioMoreGuards';
    L.ActName = "Security Breach";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.sb';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.botb_studio';
    return L;
}

static function CompilationLevel Hootenanny() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_DifficultParade';
    L.ActName = "The Great Big Hootenanny";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TGBH';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.botb_parade';
    return L;
}

static function CompilationLevel TenSeconds() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_TrainRushShortTime';
    L.ActName = "10 Seconds Until Self-Destruct";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.TSUSD';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.botb_train';
    return L;
}

static function CompilationLevel KillingTwoBirds() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_BirdBossEX';
    L.ActName = "Killing Two Birds";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.KTB';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.botb_boss';
    return L;
}

static function CompilationLevel DeadBirdStudioRC() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_RiftCollapse_Birds';
    L.ActName = "Rift Collapse: Dead Bird Studio";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.caverift';
    return L;
}

static function CompilationLevel RhythmJumpStudio() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_CommunityRift_RhythmJump';
    L.ActName = "Community Rift: Rhythm Jump Studio";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Misc.Textures.TimeRift_Cave';
    return L;
}

//Subcon Forest COMPLETE!
static function CompilationLevel Impossible() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_Speedrun_SubWell';
    L.ActName = "Speedrun Well";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.sw';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter_2_2';
    L.UseDWOverlay = true;
    return L;
}

static function CompilationLevel QualityTime() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_SurvivalOfTheFittest';
    L.ActName = "Quality Time with Snatcher";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SubconIW';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Ch2.Textures.chapter2_7';
    L.UseDWOverlay = true;
    return L;
}

static function CompilationLevel BreachingTheContract() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_SnatcherEX';
    L.ActName = "Breaching the Contract";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.BTC';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.subcon_boss';
    return L;
}

static function CompilationLevel SleepySubconRC() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_RiftCollapse_Subcon';
    L.ActName = "Rift Collapse: Sleepy Subcon";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.caverift';
    return L;
}

static function CompilationLevel TwilightTravels() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_CommunityRift_TwilightTravels';
    L.ActName = "Community Rift: Twilight Travels";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Misc.Textures.TimeRift_Cave';
    return L;
}

//Alpine Skyline
static function CompilationLevel BirdSanctuary() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_NiceBirdhouse';
    L.ActName = "Bird Sanctuary";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineDW';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.alpine_boss';
    return L;
}

static function CompilationLevel WoundUpWindmill() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_FastWindmill';
    L.ActName = "Wound-Up Windmill";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineDW';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.alpine_boss';
    return L;
}

static function CompilationLevel TheIllnessHasSpeedrun() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_Speedrun_Illness';
    L.ActName = "The Illness Has Speedrun";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AlpineDW';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.alpine_boss';
    return L;
}

static function CompilationLevel AlpineSkylineRC() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.Deathwish = class'Hat_SnatcherContract_DeathWish_RiftCollapse_Alps';
    L.ActName = "Rift Collapse: Alpine Skyline";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.caverift';
    return L;
}

static function CompilationLevel TheMountainRift() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_CommunityRift_MountainRift';
    L.ActName = "Community Rift: The Mountain Rift";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Misc.Textures.TimeRift_Cave';
    return L;
}

//Finale
static function CompilationLevel MustacheGauntlet() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_HardCastle';
    L.ActName = "The Mustache Gauntlet";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NMBG';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.finale_boss';
    return L;
}

static function CompilationLevel NoMoreBadGuys() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_MuGirlEX';
    L.ActName = "No More Bad Guys";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.NMBG';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.finale_boss';
    return L;
}

//The Arctic Cruise
static function CompilationLevel CruisinForABruisin() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_EndlessTasks';
    L.ActName = "Cruisin' For A Bruisin'";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.SS';
    L.Titlecard = Texture2D'HatInTime_Titlecards_Cruise.Textures.Cruise_Act2';
    L.UseDWOverlay = true;
    return L;
}

static function CompilationLevel DeepSeaRC() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_RiftCollapse_Cruise';
    L.ActName = "Rift Collapse: Deep Sea";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'Yoshi_LevelComp_Content.Textures.AllRifts';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.caverift';
    return L;
}

//Boss Rushes USE WITH CAUTION
static function CompilationLevel BossRush() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_BossRush';
    L.ActName = "Boss Rush";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'yoshi_levelcomp_content.Textures.STD';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.boss_rush';
    return L;
}

static function CompilationLevel SealTheDeal() {
    local CompilationLevel L;
    L.isDeathWish = true;
    L.DeathWish = class'Hat_SnatcherContract_DeathWish_BossRushEX';
    L.ActName = "Seal the Deal";
    L.TP = "NOREQUIREMENT";
    L.Icon = Texture2D'yoshi_levelcomp_content.Textures.STD';
    L.Titlecard = Texture2D'HatInTime_Titlecards_DW.boss_rush';
    return L;
}
