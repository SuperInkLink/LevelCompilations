/*
* Handles the core Level Compilations functionality of the HUD
*
*/
class Yoshi_HUDElementGhostPartyJoinLevelComp extends Yoshi_HUDElementGhostPartyJoinLevelComp_Base;

var Yoshi_LevelCompilation LevelComp;

// What to join
var int CompilationID;
var string CompilationName;

var int RandomizerSeed; //The sent Rando seed, if relevant

var bool HasMissingMods;

function RequestJoinLevelCompilation(HUD H) {
	local Yoshi_LevelCompilations_GameMod Mod;

	Mod = class'Yoshi_LevelCompilations_GameMod'.static.GetGameMod();

	Print("[LevelComps] => SEND REQUEST JOIN: (Comp: " $ CompilationID $ ")");
	HasAcceptedInvitation = true;
	Mod.SendOnlinePartyCommand(CompilationID $ "+" $ 1, class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnCompilationRequest, H.PlayerOwner.Pawn);
	AddPlayerToList(Hat_GhostPartyPlayerState(class'Hat_GhostPartyPlayerStateBase'.static.GetLocalPlayerState(0)));

	if(`GameManager.IsCoop()) {
		AddPlayerToList(Hat_GhostPartyPlayerState(class'Hat_GhostPartyPlayerStateBase'.static.GetLocalPlayerState(1)));
		Mod.SendOnlinePartyCommand(CompilationID $ "+" $ 1, class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnCompilationRequest, Hat_Player(H.PlayerOwner.Pawn).GetOtherPlayer());
	}
}

function StartLevelCompilation(HUD H) {

	if(LevelComp == None) {
		if(CompilationID < 0) {
			Print("[LevelComps] => ERROR: No Compilation to Start!");
			return;
		}

		LevelComp = class'Yoshi_LevelCompilation'.static.ReturnByID(CompilationID);
	} 

	if(Yoshi_RandomizerLevelCompilation(LevelComp) != None && RandomizerSeed > 0) {
		Yoshi_RandomizerLevelCompilation(LevelComp).SetSeed(RandomizerSeed);
	}

    LevelComp.Initialize();
	CloseHUD(H);
} 

function bool OnClick(HUD H, bool release)
{
	if(LevelComp == None) {
		LevelComp = class'Yoshi_LevelCompilation'.static.ReturnByID(CompilationID);
	}

	if(HasMissingMods) {
		JoinButtonHoldTime = -1;
		TriggerCooldownMaterial(false);
		return false;
	}

	return Super.OnClick(H, release);
}

// I'm asking others to join me in this Compilation. If the CompilationID's do not match between players (due to different mod versions) this will possibly break.
function HostJoinAct(int CompID)
{
    local Yoshi_LevelCompilations_GameMod Mod;
    local PlayerController pc;

	if(LevelComp != None) Print("[LevelComps] => Whoops! Hosting a new Level Compilation but one is already open?");
    LevelComp = class'Yoshi_LevelCompilation'.static.ReturnByID(CompID);

	CompilationID = CompID;
	HasAcceptedInvitation = true;
	IsHostingJoinAct = true;
	CompilationName = LevelComp.CompName;

	Mod = class'Yoshi_LevelCompilations_GameMod'.static.GetGameMod();
    pc = class'Engine'.static.GetEngine().GamePlayers[0].Actor;

	if(Yoshi_RandomizerLevelCompilation(LevelComp) != None) {
		RandomizerSeed = class'Yoshi_RandomizerLevelCompilation'.static.GenerateNewSeed();
	}

	if(Yoshi_ModLevelCompilation(LevelComp) != None) {
		HasMissingMods = Yoshi_ModLevelCompilation(LevelComp).CheckForMissingMods();
	}

	Mod.SendOnlinePartyCommand(CompilationID $ "+" $ 0 $ "+" $ RandomizerSeed, class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnCompilationRequest, pc.Pawn);
	AddPlayerToList(Hat_GhostPartyPlayerState(class'Hat_GhostPartyPlayerStateBase'.static.GetLocalPlayerState(0)), true);

	if(`GameManager.IsCoop()) {
		AddPlayerToList(Hat_GhostPartyPlayerState(class'Hat_GhostPartyPlayerStateBase'.static.GetLocalPlayerState(1)), true);
		Mod.SendOnlinePartyCommand(CompilationID $ "+" $ 1, class'YoshiPrivate_OnlineParty_LevelCompilations'.const.OnCompilationRequest, Hat_Player(pc.Pawn).GetOtherPlayer());
	}
}

// When we get a prompt to join someone.
function AskToJoinAct(int CompID)
{
	if(LevelComp != None) Print("[LevelComps] => Whoops! Received a new Level Compilation but one is already open?");
    LevelComp = class'Yoshi_LevelCompilation'.static.ReturnByID(CompID);

	if(Yoshi_ModLevelCompilation(LevelComp) != None) {
		HasMissingMods = Yoshi_ModLevelCompilation(LevelComp).CheckForMissingMods();
	}

	CompilationID = CompID;
	IsHostingJoinAct = false;
	HasAcceptedInvitation = false;
	CompilationName = LevelComp.CompName;
}

//If it's a randomizer, the seed should be sent right after
function SetRandomizerSeed(int Seed) {
	RandomizerSeed = Seed;
}

function bool Tick(HUD H, float d) {
	if (!Super.Tick(H, d)) return false;

	if(LevelComp == None && CompilationID > -1) {
		LevelComp = class'Yoshi_LevelCompilation'.static.ReturnByID(CompilationID);
	}

	return true;
}

function RenderClickToJoin(HUD H, string Text, float PosX, float PosY, float Width, float Height)
{
	if(HasMissingMods) {
		Text = "Whoops! Missing Required Mods";
	}

	Super.RenderClickToJoin(H, Text, PosX, PosY, Width, Height);
}

function RenderJoinActMenu(HUD H, string Text, float PosX, float PosY, float Width, float Height)
{
	Text=CompilationName;
	Super.RenderJoinActMenu(H, Text, PosX, PosY, Width, Height);
}

defaultproperties
{
	CompilationID=-1
	RandomizerSeed=-1
	HasMissingMods=false
}