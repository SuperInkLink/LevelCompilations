/**
*
*   Code by EpicYoshiMaster
*   This subclass defines a specific variant of the Mod Level Compilation designed for Challenge Roads.
*
*/
class Yoshi_ChallengeRoadLevelCompilation extends Yoshi_ModLevelCompilation
    abstract;

var const array<string> ChallengeRoadID; //Has to be an array because of CR 14 messing up.

function OnFinishLastLevel() {
    if(default.ChallengeRoadID[0] != "" && class'GameMod'.static.GetConfigValue(class'Yoshi_LevelCompilations_GameMod', 'AwardChallengeRoadTrophies') == 0) {
        AwardChallengeRoadTrophy(default.ChallengeRoadID);
    }

    Super.OnFinishLastLevel();
}

//Because of the inconsistencies of Challenge Road IDs which I had not previously realized, the mod must account for faulty IDs which were based upon level order.
//This function is run when the player enters the hub and will ensure their file does not contain any of the faulty IDs of old versions.
static function FixFaultyChallengeRoadIDs() {
    FixFaultyCRID("1764360895_1752423506", "1752423506_1764360895"); //CR 2
    FixFaultyCRID("1773428285_1763897578_1488378746", "1488378746_1763897578_1773428285"); //CR 3
    FixFaultyCRID("1790976083_1555258731_1553065007_1729621873", "1553065007_1555258731_1729621873_1790976083"); //CR 5
    FixFaultyCRID("1836094966_1833176836", "1833176836_1836094966"); //CR 6
    FixFaultyCRID("1872109003_1871813199_1867356359_1862158198_1860578539_1858074314_1747469442", "1747469442_1858074314_1860578539_1862158198_1867356359_1871813199_1872109003", true); //CR 14
    FixFaultyCRID("1395430644_1870181629_1943894751_2092051902_2034880681", "1395430644_1870181629_1943894751_2092051902_2114501114"); //CR 19 dummy

    //Most of the CR faults were actually just the level order which thankfully doesn't impact IDs.

}

static function FixFaultyCRID(string FaultyID, string NewID, optional bool isCR14 = false) {
    local array<string> NewIDs; //Because AwardChallengeRoadTrophy needs a string
	
    if(Hat_SaveGame(`SaveManager.SaveData).ChallengeRoadIDs.Find(FaultyID) != INDEX_NONE) {
        Hat_SaveGame(`SaveManager.SaveData).ChallengeRoadIDs.RemoveItem(FaultyID);
        NewIDs.AddItem(NewID);
        if(isCR14) {
            NewIDs.AddItem("1747469442_1858074314_1860578539_1867356359_1871813199_1872109003");
            NewIDs.AddItem("1747469442_1858074314_1860578539_1867356359_1872109003");
        }
        AwardChallengeRoadTrophy(NewIDs);
    }
}

static function AwardChallengeRoadTrophy(array<string> CRID) {
    local int i;

    for(i = 0; i < CRID.Length; i++) {
        if(Hat_SaveGame(`SaveManager.SaveData).ChallengeRoadIDs.Find(CRID[i]) != INDEX_NONE) {
            return;
        }
    }

    if (CRID.length > 0 && CRID[0] != "")
	{
		Hat_SaveGame(`SaveManager.SaveData).ChallengeRoadIDs.AddItem(CRID[0]);
		Hat_PlayerController(class'Engine'.static.GetEngine().GamePlayers[0].Actor).UnlockAchievement(56); // HAT_ACHIEVEMENT_CHALLENGEROAD
	}
}