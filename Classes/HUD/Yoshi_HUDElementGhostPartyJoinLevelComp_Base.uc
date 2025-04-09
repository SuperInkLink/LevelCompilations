/*
* Handles most of the base functionality for the HUD, it's pretty cluttered and hard to read so I tried to split most of the key Level Compilations parts into the main class
* to have easier maintenance.
*
*/
class Yoshi_HUDElementGhostPartyJoinLevelComp_Base extends Hat_HUDMenu
    abstract;


const FillPercent = 0.06;
const JoinActCountdownTime = 10;

struct JoinActPlayerState
{
	var Hat_GhostPartyPlayerState PlayerState;
	var Surface PlayerAvatar;
	var float FadeIn;
};

var MaterialInstanceTimeVarying TimerMaterial;
var float JoinButtonHoldTime; //The time that the player has held the join button for.
var float TimeToJoin; //How long the player needs to hold the button for in order to join.
var transient float IsJoiningAct_FadeIn;
var transient string JoinActText[2];
var transient bool HasAcceptedInvitation; //When the player holds the button long enough to request to join.
var transient float TimeOutCountdown; //How long this HUD is shown on screen.
var transient Array<JoinActPlayerState> JoiningPlayerStates;
var transient bool IsInstigatorAndClosedActSelectMenu;
var transient int PlayersInSpaceship;
var transient int NewPlayersJoining;
var transient float UpdatePlayerListCooldown;
var transient float FadeInTime;
var transient bool IsHostingJoinAct;
var transient Surface BoxMaterial;
var SoundCue PlayerJoinSound;
var SoundCue AppearSound;
var ParticleSystem AppearParticle;
var ParticleSystemComponent AppearParticleSystemComponent;

var transient bool OtherMenuIsActive;

//
// Added functions for Level Comps defined in the main HUD
//

function RequestJoinLevelCompilation(HUD H) {} //Function called when player queue's to join

function StartLevelCompilation(HUD H) {} //Function called when the time expires and we're ready to begin

//
// The rest.
//

function OnOpenHUD(HUD H, optional String command)
{
	local Hat_HUDElementPlayerList PlayerList;
	Super.OnOpenHUD(H, command);
	TimeOutCountdown = JoinActCountdownTime;
	TriggerCooldownMaterial(false);
	UpdatePlayerList(H, true);
	FadeInTime = 0;
	
	PlayerList = Hat_HUDElementPlayerList(Hat_HUD(H).GetHUD(class'Hat_HUDElementPlayerList'));
	if (PlayerList != None) PlayerList.IsInJoinAct = true;
	
	if (AppearParticle != None)
	{
		AppearParticleSystemComponent = new class'ParticleSystemComponent';
		AppearParticleSystemComponent.SetTemplate(AppearParticle);
		AppearParticleSystemComponent.KillParticlesForced();
		H.PlayerOwner.Pawn.AttachComponent(AppearParticleSystemComponent);
		AppearParticleSystemComponent.SetScale(4.0);
		AppearParticleSystemComponent.CanvasExclusive();
		AppearParticleSystemComponent.ActivateSystem(true);
	}
    Print("Opening GhostParty HUD");
	PlayOwnerSound(H, AppearSound);

	if (Hat_HUD(H).IsHUDClassEnabled(class'Hat_Ability_Camera'.default.CameraHUDClass))
		OtherMenuIsActive = true;
	if (Hat_HUD(H).IsHUDEnabled('Hat_HUDMenu_GhostPartyLobbies'))
		OtherMenuIsActive = true;
	if(Hat_HUD(h).IsHUDEnabled('Hat_HUDElement_GhostPartyJoinAct'))
		OtherMenuIsActive = true;
}

function bool DisablePause(HUD H)
{
	return IsHostingJoinAct || HasAcceptedInvitation;
}

function OnCloseHUD(HUD H)
{
	if (AppearParticleSystemComponent != None)
		AppearParticleSystemComponent.DetachFromAny();
	AppearParticleSystemComponent = None;
	
	Super.OnCloseHUD(H);
}

function LocalizeJoinText()
{
	JoinActText[0] = class'Hat_Localizer'.static.GetGhostParty("joinact", "JoinPrompt");
	JoinActText[1] = class'Hat_Localizer'.static.GetGhostParty("joinact", "WaitingToStart");	
}

function UpdatePlayerList(HUD H, bool IsFirstUpdate)
{
	local Array<Object> gpstates;
	local int i, j;
	local Hat_GhostPartyPlayerState playerstate;
	UpdatePlayerListCooldown = 0.1f;
	
	PlayersInSpaceship = class'Hat_GhostPartyPlayerStateBase'.static.GetPlayersInLobby(true,false);
	Hat_PlayerController(H.PlayerOwner).GetGhostPartyPlayerStates(gpstates);
	
	// Remove entries that do not exist
	for (i = JoiningPlayerStates.Length-1; i >= 0; i--)
	{
		if (gpstates.Find(JoiningPlayerStates[i].PlayerState) != INDEX_NONE) continue;
		JoiningPlayerStates.Remove(i,1);
	}
	
	for (i = 0; i < gpstates.Length; i++)
	{
		playerstate = Hat_GhostPartyPlayerState(gpstates[i]);
		
		for (j = 0; j < JoiningPlayerStates.Length; j++)
		{
			if (JoiningPlayerStates[j].PlayerState != PlayerState) continue;
			j = INDEX_NONE;
			break;
		}
		if (j == INDEX_NONE) continue; // Already exists
	}
}

function AddPlayerToList(Hat_GhostPartyPlayerState State, optional bool IsLocal = false) {
	local PlayerController PC;
    NewPlayersJoining += 1;
    JoiningPlayerStates.Add(1);
    JoiningPlayerStates[JoiningPlayerStates.Length - 1].PlayerState = State;

	if (class'Hat_GhostPartyPlayer'.static.ShouldCensorAvatars())
		JoiningPlayerStates[JoiningPlayerStates.Length - 1].PlayerAvatar = class'Hat_HUDMenuGhostPartyScoreboard'.static.CreateAvatarBubble(class'Hat_HUDElementPlayerList'.static.GetCensoredAvatar(State));
	else
		JoiningPlayerStates[JoiningPlayerStates.Length - 1].PlayerAvatar = class'Hat_HUDMenuGhostPartyScoreboard'.static.CreateAvatarBubble(State.Avatar);    

	if(!IsLocal) {
		pc = class'Engine'.static.GetEngine().GamePlayers[0].Actor;
		JankPlaySound(pc, PlayerJoinSound, 1, Lerp(1, 1.5, float(Min(JoiningPlayerStates.Length - 1,6))/6.f));
	}
}

function JankPlaySound(PlayerController PC, Soundcue c, optional Float volume, optional Float Pitch) {
	local AudioComponent ac;
	if (volume != 1 || pitch != 1)
	{
		ac = PC.CreateAudioComponent(c, false, true);
		ac.VolumeMultiplier = volume;
		ac.PitchMultiplier = pitch;
		ac.Play();
		return;
	}
	PC.PlaySound(c);
}

function bool Tick(HUD H, float d)
{
	local Hat_PlayerController PC;
	local Hat_PlayerController_Base OtherPC;
	local bool ShouldBeShared;
	local int i;
	local Hat_HUDElementPlayerList PlayerList;

	if (!Super.Tick(H, d)) return false;
	
	if(Hat_HUD(H).GetHUD(class'Hat_HUDElementGhostPartyJoinAct') != None) { //Not today. We don't want other level prompts to appear if this is already up.
		Hat_HUD(H).CloseHUD(class'Hat_HUDElementGhostPartyJoinAct');
	}

	if (FadeInTime < 1)
	{
		FadeInTime = FMin(FadeInTime+d/0.4,1);
	}
	
	// Ensures we aren't calling expensive calls every tick
	if (UpdatePlayerListCooldown > 0)
	{
		UpdatePlayerListCooldown -= d;
		if (UpdatePlayerListCooldown <= 0)
		{
			UpdatePlayerList(H,false);
		}
	}
	
	PC = Hat_PlayerController(GetController(H));

	if (`GameManager.IsCoop())
	{
		OtherPC = PC.GetOtherPlayer();
		ShouldBeShared = (`GameManager.IsInExclusiveSplitscreen() && 
			(PC.GetPlayerIndex() == 0 || OtherPC == None || OtherPC.Pawn == None || Hat_Player(OtherPC.Pawn).IsDead));
		if (ShouldBeShared != SharedInCoop)
		{
			SharedInCoop = ShouldBeShared;
			class'Hat_HUD'.static.RecacheHUDs();
		}
	}

	if (JoinActText[0] == "")
		LocalizeJoinText();
	
	if (!HasAcceptedInvitation)
	{
		if (JoinButtonHoldTime>= 0)
			JoinButtonHoldTime+= d;
		if (JoinButtonHoldTime>= TimeToJoin)
		{
			RequestJoinLevelCompilation(H);
		}
	}
	else
		JoinButtonHoldTime= -1;
	
	if (IsJoiningAct_FadeIn < 1.0f)
		IsJoiningAct_FadeIn = Lerp(IsJoiningAct_FadeIn, 1.f, FMin(d/0.05f,1));

	if (JoiningPlayerStates.Length == PlayersInSpaceship && TimeOutCountdown > 0) //JoiningPlayerStates.Length > 1 && 
	{
		TimeOutCountdown = FMin(TimeOutCountdown,0.5); // Need 0.5s to see the last player join
	}

	if (TimeOutCountdown > 0.0)
	{
		TimeOutCountdown -= d;
		if (TimeOutCountdown <= 0)
		{
			if (HasAcceptedInvitation)
			{
                StartLevelCompilation(H);
			}
			else
			{
				PlayerList = Hat_HUDElementPlayerList(Hat_HUD(H).GetHUD(class'Hat_HUDElementPlayerList'));
				if (PlayerList != None) PlayerList.IsInJoinAct = false;
				CloseHUD(H);
			}
		}
	}
	
	for (i = 0; i < JoiningPlayerStates.Length; i++)
	{
		JoiningPlayerStates[i].FadeIn = FMin(JoiningPlayerStates[i].FadeIn+d/0.3f,1.f);
	}

	return true;
}

function bool Render(HUD H)
{	
	if (!Super.Render(H)) return false;
	if (Hat_HUD(H).IsHUDEnabled('Hat_HUDElementInventoryCamera2018')) return false;
	if (H.PlayerOwner.IsPaused()) return false;
	if (class'Hat_HUDElementCinematic'.static.IsConversationBubbleOpen(H)) return false;
	
	RenderJoinAct(H);
	return true;
}

function bool OnClick(HUD H, bool release)
{
	if (HasAcceptedInvitation) return false;
	if (`GameManager.IsCoop() && !SharedInCoop && Hat_HUD(H).GetOtherPlayerHUD() != None && Hat_HUD(H).GetOtherPlayerHUD().GetElementCinematic().SharedInCoop)
		return false;
	if (OtherMenuIsActive || H.PlayerOwner.IsPaused()) return false;
	if (class'Hat_HUDElementCinematic'.static.IsConversationBubbleOpen(H)) return false;
	if (Hat_HUD(H).IsHUDEnabled('Hat_HUDElementInventoryCamera2018')) return false;

	if (!release)
	{
		if (JoinButtonHoldTime< 0)
		{
			JoinButtonHoldTime= 0;
			TriggerCooldownMaterial(true);
			return true;
		}
	}
	if (release)
	{
		JoinButtonHoldTime= -1;
		TriggerCooldownMaterial(false);
		return true;
	}
	return false;
}

function TriggerCooldownMaterial(bool fill)
{
	if (TimerMaterial == None)
	{
		TimerMaterial = new class'materialInstanceTimeVarying';
		TimerMaterial.SetParent(MaterialInstanceTimeVarying'HatInTime_Hud.Cooldown.Materials.Cooldown_Skip_Cinematic');
	}
	if (TimerMaterial == None) return;
	TransitionMaterialParameter(TimerMaterial, 'Value', 0, (fill ? 1.0 : 0.0), TimeToJoin);
}

function RenderJoinAct(HUD H)
{
	local float width, height, posx, posy, alpha, alphasize, AdjustedCountdown;
	
	width = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.6;
	height = width*0.6;
	posx = H.Canvas.ClipX/2;
	posy = H.Canvas.ClipY/2;
	
	if (IsHostingJoinAct)
	{
		H.Canvas.SetDrawColor(0,0,0, 180);
		DrawCenter(H, H.Canvas.ClipX/2, H.Canvas.ClipY/2, H.Canvas.ClipX, H.Canvas.ClipY, H.Canvas.DefaultTexture);
		
		if (TimeOutCountdown > 0 && TimeOutCountdown <= 2.f)
		{
			alpha = 2.0f - TimeOutCountdown;
			alpha = FMin(alpha/0.5,1.f);
			PosX += width*alpha*0.003f*RandRange(-1,1);
			PosY += width*alpha*0.003f*RandRange(-1,1);
		}
		AdjustedCountdown = TimeOutCountdown - 0.05f;
		if (AdjustedCountdown <= 0.3f)
		{
			alpha = FClamp(0.3f - AdjustedCountdown,0,1);
			alpha = FMax(Lerp(1, -1.0, alpha**3),0);
			width *= alpha;
			height *= alpha;
		}
	}
	else
	{
		width *= 0.7f;
		height *= 0.7f;
		
		posx = H.Canvas.ClipX - width*0.5 - width*0.1;
		posy = height*0.5 + width*0.1;
	}
	
	alpha = 1-((1-FadeInTime)**1.5f);
	
	if (!IsHostingJoinAct && !HasAcceptedInvitation)
	{
		alpha *= 1-((1-FClamp(TimeOutCountdown/0.2f,0,1))**1.5);
	}
	
	alphasize = Lerp(0.95,1,alpha);
	
	H.Canvas.SetDrawColor(255,255,255,255*alpha);
	RenderJoinActMenu(H, "None Compilation", posx, posy, width*alphasize, height*alphasize);
}

function RenderJoinActMenu(HUD H, string Text, float PosX, float PosY, float Width, float Height)
{
	local float CountdownTimeLeft;
	local int OriginalAlpha;
	
	OriginalAlpha = H.Canvas.DrawColor.A;
	
	H.Canvas.SetDrawColor(255,255,255, H.Canvas.DrawColor.A);
	DrawCEnter(H, PosX, PosY, Width, Height, BoxMaterial);
	
	H.Canvas.SetDrawColor(32,32,32, H.Canvas.DrawColor.A);
	DrawCenter(H, PosX, PosY-Height*0.2, Width*0.95, Height*0.005, H.Canvas.DefaultTexture);
	
	H.Canvas.SetDrawColor(255,255,255, H.Canvas.DrawColor.A);
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(text);
	DrawBorderedText(H.Canvas, text, posx, posy-Height*0.39, width*0.0016, false, TextAlign_Center);
	
	CountdownTimeLeft = TimeOutCountdown >= 0 ? FClamp(TimeOutCountdown / JoinActCountdownTime,0,1) : 0.f;
	RenderJoinCountdownTimer(H, PosX, PosY-Height*0.25, Width*0.8, Height*0.015, CountdownTimeLeft);
	
	RenderPlayerAcceptRow(H, PosX, PosY+Height*0.02f, Width*0.9, Height*0.42);
	
	H.Canvas.SetDrawColor(32,32,32, H.Canvas.DrawColor.A);
	DrawCenter(H, PosX, PosY+Height*0.25, Width*0.95, Height*0.005, H.Canvas.DefaultTexture);
	
	
	RenderClickToJoin(H, JoinActText[0], PosX, PosY+Height*0.37, Width*0.95, Height*0.2f);
	
	if (AppearParticleSystemComponent != None)
	{
		H.Canvas.SetPos(PosX, PosY);
		H.Canvas.SetDrawColor(255,255,255,255);
		AppearParticleSystemComponent.RenderToCanvas(H.Canvas);
		H.Canvas.SetDrawColor(255,255,255,OriginalAlpha);
	}
}

function RenderClickToJoin(HUD H, string Text, float PosX, float PosY, float Width, float Height)
{

	local float ButtonSize;
	
	H.Canvas.SetDrawColor(255,255,255, H.Canvas.DrawColor.A);
	
	if (HasAcceptedInvitation)
	{
		Text = JoinActText[1];
		H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(Text);
		DrawBorderedText(H.Canvas, text, posx, posy, Height*0.012, false, TextAlign_Center);
	}
	else
	{
		if (OtherMenuIsActive || H.PlayerOwner.IsPaused()) return;
		ButtonSize = Height;
		posx = posx + Width*0.5f-ButtonSize*0.5f;
		
		DrawCenterMat(H, posx, posy, ButtonSize, ButtonSize, TimerMaterial);
		class'Hat_HUDInputButtonRender'.static.Render(H, HatControllerBind_Menu_Confirm, posx, posy, ButtonSize*0.8f);
		
		posx -= ButtonSize*0.6f;

		H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(Text);
		DrawBorderedText(H.Canvas, Text, posx, posy, Height*0.012, false, TextAlign_Right);
	}
}

function RenderJoinCountdownTimer(HUD H, float PosX, float PosY, float Width, float Height, float CountdownTimeLeft)
{
	local int OriginalAlpha;
	
	OriginalAlpha = H.Canvas.DrawColor.A;
	
	H.Canvas.SetDrawColor(0,0,0, OriginalAlpha*0.5f);
	DrawCenter(H, PosX, PosY, Width, Height, H.Canvas.DefaultTexture);
	
	H.Canvas.SetDrawColor(255,255,255, OriginalAlpha);
	DrawCenterLeft(H, PosX + Width*0.5*Lerp(1,-1,CountdownTimeLeft), PosY, Width*CountdownTimeLeft, Height, H.Canvas.DefaultTexture);
	
	H.Canvas.DrawColor.A = OriginalAlpha;
}

function RenderPlayerAcceptRow(HUD H, float PosX, float PosY, float Width, float Height)
{
	local int OriginalAlpha;
	local int i, j, totalnum, currentnum, numrows;
	local float iconspacing, iconwidth, myposx, myposy, iconscale;
	
	OriginalAlpha = H.Canvas.DrawColor.A;
	
	totalnum = PlayersInSpaceship;
	totalnum = Min(totalnum,30);
	if (totalnum <= 0) return;
	
	numrows = max(ffloor((totalnum-1)/10),0);
	iconspacing = FMin(Width/Min(totalnum,10),Height/float(numrows+1));
	iconwidth = iconspacing/1.1;
	for (j = 0; j < totalnum; j += 10)
	{
		currentnum = Min(totalnum-j,10);
		for (i = 0; i < currentnum; i++)
		{
			myposx = PosX + (i - (currentnum-1)*0.5f)*iconspacing;
			myposy = PosY + ((j/10) - numrows*0.5f)*iconspacing;
			H.Canvas.SetDrawColor(0,0,0, OriginalAlpha*0.2f);
			DrawCenter(H, MyPosX, MyPosY, iconwidth, iconwidth, class'Hat_HUDMenuMainMenu'.default.RadioTextures[0]);
			if (JoiningPlayerStates.Length > (i+j))
			{
				H.Canvas.SetDrawColor(255,255,255, OriginalAlpha*FMin(JoiningPlayerStates[i+j].FadeIn*5,1));
				iconscale = class'Hat_Math'.static.InterpolationBounce(1.7, 1.0, JoiningPlayerStates[i+j].FadeIn);
				DrawCenter(H, MyPosX, MyPosY, iconwidth*iconscale, iconwidth*iconscale, JoiningPlayerStates[i+j].PlayerAvatar);
			}
		}
		currentnum -= 10;
	}
	H.Canvas.DrawColor.A = OriginalAlpha;
}

static function Print(coerce string s)
{
	class'Yoshi_LevelCompilations_GameMod'.static.Print(s);
}


defaultproperties
{
	//SharedInCoop = true
	RealTime = true

	JoinButtonHoldTime= -1
	TimeToJoin = 0.7
	RenderIndex = 1

	PlayerJoinSound = SoundCue'hatintime_sfx_ghostparty.SoundCues.PlayerJoinActQueue'
	BoxMaterial = Material'HatinTime_GhostParty.Materials.JoinActMenuBox'
	AppearParticle = ParticleSystem'HatinTime_GhostParty.ParticleSystems.JoinActAppear'
	AppearSound = SoundCue'hatintime_sfx_ghostparty.SoundCues.ActQueueAppear'
}