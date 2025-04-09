class Yoshi_LevelCompilations_GameMod extends GameMod
    dependsOn(Yoshi_LevelCompilation)
    config(Mods);

var config int OnlinePartySupport; //Determines if we receive the HUD calls to join compilations
var config int CoopCompilation; //Determines if all players grabbing a time piece will travel together
var config int AwardChallengeRoadTrophies; //Determines if completing a Challenge Road Compilation will grant the ACTUAL Challenge Road Trophy
var config int ResetOnExit; //Determines if Compilations should be reset upon heading to Main Menu and Spaceship, if your game crashes this lets you go back into a compilation.

var array< class<Yoshi_LevelCompilation> > CompClassesCache; //We don't want to call GetAllScriptClasses Repeatedly

var bool SpawnedNPC;

event OnModLoaded() {

    SpawnedNPC = false;

    CompClassesCache = class'Yoshi_LevelCompilation'.static.GetAllLevelComps();

    if(`GameManager.GetCurrentMapFilename() == `GameManager.TitleScreenMapName) {
        return;
	}

    if(`GameManager.GetCurrentMapFilename() == `GameManager.HubMapName) {

        class'Yoshi_LevelCompilation'.static.RestoreMetroIntroTimePiece();

        if(class'Yoshi_LevelCompilation'.static.GetCompilationID() > -1) {
            `GameManager.SetCurrentChapterAct(1, 0); //Send them over to the Mafia Town spawn
            class'Yoshi_LevelCompilation'.static.SetCompilationID(-1);
        }

        class'Yoshi_ChallengeRoadLevelCompilation'.static.FixFaultyChallengeRoadIDs();

        class'Yoshi_LevelCompilation'.static.SetInComp(false); //We no longer reset their data, instead we just know if we're in a comp or not

        if(!SpawnedNPC) {
            SpawnProps();
        }
        return;
    }

    if(class'Yoshi_LevelCompilation'.static.IsInCompilation()) {
        class'Yoshi_LevelCompilation'.static.SetAcceptTimePiece(true);
        class'Yoshi_LevelCompilation'.static.GetActiveComp(CompClassesCache).CheckDoubleRestart();
    }
}

function OnPostInitGame() {
    if(class'Yoshi_LevelCompilation'.static.IsInCompilation()) {
        class'Yoshi_LevelCompilation'.static.DoTimerCheck(CompClassesCache);
    }
}

static function Yoshi_LevelCompilations_GameMod GetGameMod() {
    local Yoshi_LevelCompilations_GameMod Mod;
    foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Yoshi_LevelCompilations_GameMod', Mod)
		return Mod;
}

event Tick(float delta) {
    local Hat_TimeObject_Base TimePiece;

    if(!class'Yoshi_LevelCompilation'.static.IsInCompilation() || `GameManager.GetCurrentMapFilename() == `GameManager.TitleScreenMapName || `GameManager.GetCurrentMapFilename() == `GameManager.HubMapName) {
        return;
	}

    foreach DynamicActors(class'Hat_TimeObject_Base', TimePiece) {
        if(TimePiece != None) {
            if(TimePiece.Triggered) {
                class'Hat_GlobalTimer'.static.Pause();
            }
            if(TimePiece.FinalTimePiece) {
                TimePiece.FinalTimePiece = false;
            }
        }
    }
}

event OnOnlinePartyCommand(string Command, Name CommandChannel, Hat_GhostPartyPlayerStateBase Sender) {
    local Hat_GhostPartyPlayer GhostPlayer;
    local Array<String> arr;
    local PlayerController pc;
	local Hat_HUD MyHUD;
	local Yoshi_HUDElementGhostPartyJoinLevelComp JoinActHUD;

	GhostPlayer = Hat_GhostPartyPlayer(Sender.GhostActor);
	if (GhostPlayer == None) return;

    //Source file not included for privacy of CommandChannels
    if(CommandChannel == class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnTimePieceCollected && CoopCompilation == 0) {
        Print("Received OnTimePieceCollected call with Command " $ Command);
        //The Command is split into the Time Piece Identifier and the Result of the Time Piece check. If 0, we are moving to the next level, if 1 we finished the last level.
        arr = SplitString(Command, "+");
        if(arr.length == 3) {
            if(int(arr[1]) == 0 && int(arr[2]) == class'Yoshi_LevelCompilation'.static.GetCompilationID()) {
                Print("Moving to Next Level.");
                if(class'Yoshi_LevelCompilation'.static.IsInCompilation()) {
                    OnTimePieceReceived(arr[0]);
                }
            }
        } 
    }

    //Requests are split into CompilationID, type of request, and seed if a Randomizer. Request Type 0 is the Host's initial send. Request Type 1 is a player requesting to join.
    if(CommandChannel == class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnCompilationRequest && OnlinePartySupport == 0 && `GameManager.GetCurrentMapFilename() == `GameManager.HubMapName) {
        arr = SplitString(Command, "+");
        Print("Received Online Party Comp Request" $ arr[0] $ " " $ arr[1]);
        pc = class'Engine'.static.GetEngine().GamePlayers[0].Actor;
		MyHUD = pc != None ? Hat_HUD(pc.MyHUD) : None;
        if(arr.length >= 2) {

            if(int(arr[1]) == 0) {

			    if (MyHUD.GetHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp') != None) return; // Prompt already open
                if (MyHUD.GetHUD(class'Hat_HUDElementGhostPartyJoinAct') != None) return; //Another act prompt is open
                
			    JoinActHUD = Yoshi_HUDElementGhostPartyJoinLevelComp(MyHUD.OpenHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp'));
			    JoinActHUD.AskToJoinAct(int(arr[0]));
                JoinActHUD.AddPlayerToList(Hat_GhostPartyPlayerState(Sender));

                if(arr.length >= 3) {
                    //TODO: MAKE THIS WORK
                    JoinActHUD.SetRandomizerSeed(int(arr[2]));
                }
            }
            else if(int(arr[1]) == 1) {

                //This check *should* never fail
                if (MyHUD.GetHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp') != None) {
                    JoinActHUD = Yoshi_HUDElementGhostPartyJoinLevelComp(MyHUD.GetHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp'));
                } 
                else {
                    JoinActHUD = Yoshi_HUDElementGhostPartyJoinLevelComp(MyHUD.OpenHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp'));
                }

                JoinActHUD.AddPlayerToList(Hat_GhostPartyPlayerState(Sender));
            }
        }
    }
}

event OnModUnloaded() {
    local Yoshi_NPC_TimeObjectLC TO;
    foreach DynamicActors(class'Yoshi_NPC_TimeObjectLC',TO) {
        if(TO.isA('Yoshi_NPC_TimeObjectLC')) {
            TO.Destroy();
        }
    }

     class'Yoshi_LevelCompilation'.static.SetInComp(false);
}

//Online Party Time Piece
function OnTimePieceReceived(string Identifier) {
    class'Yoshi_LevelCompilation'.static.GetActiveComp(CompClassesCache).OnTimePieceCollected(Identifier, true);
}

//Local Player Time Piece
function OnTimePieceCollected(string Identifier) {
    local int Result;
    local Hat_Player ply;

    if(class'Yoshi_LevelCompilation'.static.IsInCompilation()) {
        Result = class'Yoshi_LevelCompilation'.static.GetActiveComp(CompClassesCache).OnTimePieceCollected(Identifier, false);
        if(Result == -1 || CoopCompilation != 0) {
            return;
        }
        ply = Hat_Player(class'Engine'.static.GetEngine().GamePlayers[0].Actor.Pawn);

        Print("Sending OnTimePieceCollected with Identifier " $ Identifier $ " and Result " $ Result);
        SendOnlinePartyCommand(Identifier $ "+" $ Result $ "+" $ class'Yoshi_LevelCompilation'.static.GetCompilationID(), class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnTimePieceCollected, ply);
    }
}

function SpawnProps() {
    local Vector HubLocationCog;
    local Rotator HubRotationCog;
    HubLocationCog.X = 3.310;
    HubLocationCog.Y = 409.703;
    HubLocationCog.Z = 71.807;

    HubRotationCog.Pitch = 0;
    HubRotationCog.Yaw = 0;
    HubRotationCog.Roll = 0;

    Spawn(class'Yoshi_NPC_TimeObjectLC',,,HubLocationCog,HubRotationCog,,);
    SpawnedNPC = true;
}

static final function Print(const string msg)
{
    /*
    local WorldInfo wi;
    wi = class'WorldInfo'.static.GetWorldInfo();
    if (wi != None)
    {
        if (wi.GetALocalPlayerController() != None)
            wi.GetALocalPlayerController().TeamMessage(None, msg, 'Event', 6);
        else
            wi.Game.Broadcast(wi, msg);
    }*/
}