/*
*
*	Code by EpicYoshiMaster. Based on code in HUDs made by Jawchecha and the Mod Level Select, credit to them.
*	This HUD carries out all tasks related to accessing Level Compilations. It displays Regular, Mod, Custom, and allows you to remove Custom Comps.
*
*/
class Yoshi_HUDMenu_LevelComps extends Hat_HUDMenu
	dependson(Yoshi_LevelCompilation);

const IconSelectAnimationTime = 0.1;

var array<string> DeathathonCompletionists;

//Basic HUD Properties
var Surface BackgroundGradient; //Background for the HUD
var Surface DeathathonHallOfFameBackground; //Background for the Hall of Fame
var Texture2D HighlightBox; //Box used to Highlight around selected items
var string HUDTitle; //Title displayed on the HUD
var int LevelMode; // 0 = Regular Comps, 1 = Mod Comps, 2 = Custom Comps, 3 = Remove Comps
var transient ParticleSystem BackgroundParticle;
var transient ParticleSystemComponent BackgroundParticleComponent;
var array< class<Yoshi_LevelCompilation> > AllLevelCompilations; //Contains all Regular and Mod Compilations. Sifted through upon OnOpenHUD for the relevant level compilations
var Yoshi_CustomCompilationStorage AllCustomComps; //Contains all Custom Compilations.
var int CustomID; //Contains relevant Custom Compilation ID

//Submenu properties
var bool InCompPreview; //Determines if we're in the submenu
var Yoshi_LevelCompilation PreviewYLC; //Contains the current Previewed Level Compilation

var EModLevelPreviewButton SelectedButton; //Currently selected button. There is only one: Play.
var Array<EModLevelPreviewButton> PreviewButtons; //Array of buttons to be displayed
var transient Array<string> PreviewButtonsText; //Text on the buttons
var Array<Surface> PreviewButtonsIcon; //Icons of the buttons
var float PreviewButtonsInterp;
var Surface PreviewButtonImage;
var Surface PreviewButtonImage_Silhouette;

var bool InHallOfFame; //Determines if we're viewing the Deathathon Hall of Fame


//HUD Specifics
var int SelectedInTab; //The current level compilation the mouse is on
var int PrevMouseSelection;
var int SelectedIndex;

var int LScrollbarState; //Main HUD Scrollbar stats
var bool LScrollbarPress;
var float LScrollbarOutput;
var float LScrollbarDrag;

var float ScrollOffset; //Offset when using a scrollbar for main HUD
var float ScrollTarget;

var int PScrollbarState; //Preview HUD Scrollbar stats
var bool PScrollbarPress;
var float PScrollbarOutput;
var float PScrollbarDrag;

var float PreviewScrollOffset; //Offset when using a scrollbar for preview submenu
var float PreviewScrollMax;

var float FadeOut;
var float FadeIn;
var int NumItemsPerRow;

var color ScrollbarColorBack;
var color ScrollbarColorButtons;
var color ScrollbarColorHover;
var color ScrollbarColorPressed;

var SoundCue SelectionChangedSound;
var SoundCue SelectSound;
var SoundCue ExitSound;
var SoundCue RemoveSound;
var SoundCue WorkshopSound;

var bool MouseClear;

var int TotalSelections;


function int LevelSort(class<Yoshi_LevelCompilation> A, class<Yoshi_LevelCompilation> B) {
	return A.default.CompilationID > B.default.CompilationID ? -1 : 0;
}

function OnOpenHUD(HUD H, optional string command)
{
	local PlayerController pc;
    Super.OnOpenHUD(H, command);

	CreateBackgroundParticle(H);
	
	if (command == "close")
		DoClose(H);
	else
	{
		switch(command) {
			case "Regular":
				LevelMode = 0;
				break;
			case "Mod":
				LevelMode = 1;
				break;
			case "Custom":
				LevelMode = 2;
				break;
			case "CustomRemove":
				LevelMode = 3;
				break;
		}
		AllLevelCompilations = class'Yoshi_LevelCompilation'.static.GetAllLevelComps();
		AllLevelCompilations.Sort(LevelSort);

		AllCustomComps = new class'Yoshi_CustomCompilationStorage';
		class'Engine'.static.BasicLoadObject(AllCustomComps, "LevelCompilations/CustomCompilations.levelcomp", false, 1);

		SetLevelCompsByMode();

		if(LevelMode < 2) {
			TotalSelections = AllLevelCompilations.Length;
		}
		else {
			TotalSelections = AllCustomComps.CustomComps.Length;
		}
		
		PreviewButtonsText[LevelPreview_Play] = class'Hat_Localizer'.static.GetMenu("Modding", "PreviewButtonsText_Play");
		PreviewButtonsText[LevelPreview_DownloadMod] = class'Hat_Localizer'.static.GetMenu("Modding", "PreviewButtonsText_Install");
		PreviewButtonsText[LevelPreview_Enable] = "Continue!";
		PreviewButtonsText[LevelPreview_Config] = "Champs"; 
		FadeIn = 0;
		FadeOut = 1.0;		
		Hat_HUD(H).bShowDefaultHUD = false;
		foreach GetWorldInfo().AllActors(class'PlayerController',pc)
			SetCinematicMode(pc, true);
			
		//Checks if you have nothing selected and forces a selection.	
		if (SelectedInTab == -1 && Hat_HUD(H).IsGamepad())
			SelectedInTab = 0;
	}
}

// 0 = Regular Comps, 1 = Mod Comps, 2 = Custom Comps, 3 = Remove Comps
//
// Level Comps ID Pattern:
// Base Compilations < 10000
// Challenge Roads >= 50000 AND < 60000
// Mod Compilations >= 60000 < 70000
// Deathathon 99998
// Custom Compilation 99999
//
//
function SetLevelCompsByMode() {
	local int i;
	local bool LCVersion;

	LCVersion = class'Yoshi_ModLevelCompilation'.static.IsOnNewLevelCompsVersion();

	for(i = 0; i < AllLevelCompilations.Length; i++) {

		//These Compilations don't support 110% Patch
		if(class<Yoshi_ModLevelCompilation>(AllLevelCompilations[i]) != None && class<Yoshi_ModLevelCompilation>(AllLevelCompilations[i]).default.IsPastIntLimit && !LCVersion) {
			AllLevelCompilations.Remove(i, 1);
			i--;
			continue;
		}

		if(LevelMode == 0 && AllLevelCompilations[i].default.CompilationID >= 10000) {
			AllLevelCompilations.Remove(i, 1);
			i--;
			continue;
		}

		if(LevelMode == 1 && (AllLevelCompilations[i].default.CompilationID < 10000 || AllLevelCompilations[i].default.CompilationID > 99998)) {
			AllLevelCompilations.Remove(i, 1);
			i--;
			continue;
		}

		if(LevelMode == 2 && !(AllLevelCompilations[i].default.CompilationID == 99999)) {
			AllLevelCompilations.Remove(i, 1);
			i--;		
			continue;	
		}
	}

	switch(LevelMode) {
		case 0:
			BackgroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Blue';
			HUDTitle = "Level Compilations";
			break;
		case 1:
			BackGroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Purple';
			HUDTitle = "Mod Compilations";
			break;
		case 2:
			BackGroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Green';
			HUDTitle = "Custom Compilations";
			break;
		case 3:
			BackGroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Yellow';
			HUDTitle = "Remove Custom Compilations";
			break;
	}
}

//Upon closing the menu, remove particle effects
function OnCloseHUD(HUD H)
{
	Super.OnCloseHUD(H);

	if (BackgroundParticleComponent != None)
	{
		BackgroundParticleComponent.DetachFromAny();
		BackgroundParticleComponent = None;
	}
}

function bool DisablePause(HUD H)
{
	return true;
}

//Make sure nothing else is happening while the player is in the menu
function SetCinematicMode(PlayerController pc, bool active)
{
	pc.SetCinematicMode(active, false, true, true, true, true);
	Hat_PlayerController(pc).HideCinematicBars = active;
}

//Essentially checks if we're already closing the menu
function bool IsClosing(HUD H)
{
	return (FadeOut < 1.0);
}

//Sets up closing the menu
function DoClose(HUD H)
{
	if (IsClosing(H)) return;

	FadeOut = 0.999;
	CloseHUD(H,class'Yoshi_HUDMenu_LevelComps');

}

//Controls frame by frame actions, for example Fades.

function bool Tick(HUD H, float d)
{
	local float ScrollSpeed;

	if (!Super.Tick(H, d)) return false;

	if (FadeIn < 1.0)
		FadeIn = Lerp(FadeIn, 1.0, FMin(d*15,1.0));
	if (FadeOut < 1.0)
	{
		FadeOut = FMax(FadeOut - d*0.15, 0.0);
		FadeOut = Lerp(FadeOut, 0.0, FMin(d*15,1.0));
		if (FadeOut <= 0.0)
		{
			CloseHUD(H);
			return false;
		}
	}

	PreviewButtonsInterp = FMin(PreviewButtonsInterp+d/IconSelectAnimationTime,1);

	if (LScrollbarOutput == -1)
	{
		ScrollSpeed = 6;
		if (Abs(ScrollTarget - ScrollOffset) > 2) ScrollSpeed = 18;
		if (ScrollOffset < ScrollTarget)
			ScrollOffset = FMin(ScrollOffset + d*ScrollSpeed, ScrollTarget);
		if (ScrollOffset > ScrollTarget)
			ScrollOffset = FMax(ScrollOffset - d*ScrollSpeed, ScrollTarget);
	}
	ReactivateMouseCheck(H);

	return true;
}


//Draws the HUD to the screen
function bool Render(HUD H)
{
	//local delegate<LevelSort> Sort;
	local float Scale;

	if (!Super.Render(H)) return false;

	Scale = FMin(H.Canvas.ClipX / 1600, H.Canvas.ClipY / 900);
	H.Canvas.SetDrawColor(255,255,255,255);
	ApplyFont(H, true);
	
	MouseClear = true;

	if(!InCompPreview) {
		RenderLevelCompTileList(H, scale);
	}
	else if(!InHallOfFame) {
		RenderCompPreview(H, scale);
	}
	else {
		RenderHallOfFame(H, scale);
	}
	
	if (MouseClear && !Hat_HUD(H).IsGamepad() && MouseActivated)
		WipeAllSelections();

    return true;
}

static function Print(coerce string msg)
{
	class'Yoshi_LevelCompilations_GameMod'.static.Print(msg);
}

//Like leaving the mod menu, don't save your last location
function WipeAllSelections()
{
	SelectedIndex = -1;
	SelectedInTab = -1;
	SelectedButton = LevelPreview_None;
}

//Called by the Render function, gets the font.
function ApplyFont(HUD H, bool Big)
{
	class'Hat_BubbleTalker_Render'.static.GetStandardFont(H.Canvas, Big);
}

//Likely the particles that show up on the menus
function CreateBackgroundParticle(HUD H)
{
	local ParticleSystemComponent pc;
	if (BackgroundParticle == None) return;
	
	pc = new class'ParticleSystemComponent';
	
	//defaultproperties
	pc.SetTemplate(BackgroundParticle);
	
	H.AttachComponent(pc);
	pc.CanvasExclusive();
	pc.SecondsBeforeInactive = 0;
	pc.SetScale(3);
	pc.Trigger(true);
	
	//defaultproperties
	BackgroundParticleComponent = pc;
}

function RenderLevelCompTileList(HUD H, float scale)
{
	local int i;
	local float posX, posY, TileSpace, selectX, selectY;
	posX = Scale*380;
	posY = Scale*380;
	TileSpace = Scale*210;
	posY -= ScrollOffset * TileSpace;

	// background
	//680
	DrawCenter(H, Scale*800, Scale*450, Scale*1200, Scale*710, BackgroundGradient);
	
	if (BackgroundParticleComponent != None)
	{
		H.Canvas.PushMaskRegion(Scale*204, Scale*84, Scale*(1200-7), Scale*(680-10));
		H.Canvas.SetPos(H.Canvas.ClipX/2, H.Canvas.ClipY);
		BackgroundParticleComponent.RenderToCanvas(H.Canvas);
		H.Canvas.PopMaskRegion();
	}

	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(HUDTitle); //Title is specified in OnOpenHUD
	class'Hat_HUDElementItemUnlock'.static.DrawFancyUnlockText(H.Canvas, self, HUDTitle, Scale*220, Scale*120, Scale*1.5, TextAlign_BottomLeft);

	if (!MouseActivated)
	{
		ScrollTarget = FFloor(SelectedInTab / NumItemsPerRow) - 1;
		if (SelectedInTab < NumItemsPerRow) ScrollTarget += 1;
		if (FFloor(SelectedInTab / NumItemsPerRow) > 1 && FFloor(SelectedInTab / NumItemsPerRow) + 1 > FFloor((TotalSelections - 1) / NumItemsPerRow)) ScrollTarget -= 1;
	}

	// scrollbar
	if (TotalSelections != 0)
	{
		if (LScrollbarOutput > -1)
		{
			ScrollOffset = LScrollbarOutput*((TotalSelections-1)/NumItemsPerRow - 2);
			ScrollTarget = Round(ScrollOffset);
		}

		if (float(TotalSelections)/NumItemsPerRow/3 > 1)
			RenderScrollbar(H, self, Scale*1337, Scale*115, Scale*26, Scale*600, Scale, 3/(FFloor((TotalSelections-1)/NumItemsPerRow)+1), ScrollOffset/(FFloor((TotalSelections-1)/NumItemsPerRow)-2), LScrollbarState, LScrollbarPress, LScrollbarDrag, LScrollbarOutput, ScrollbarColorBack, ScrollbarColorButtons, ScrollbarColorHover, ScrollbarColorPressed);
		else
			LScrollbarState = -1;
	}
	
	// tiles 115
	H.Canvas.PushMaskRegion(0, Scale*122, Scale*1600, Scale*655);
	
	for (i = 0; i < TotalSelections; i++)
	{

		if (posY > 0)
		{
			if (SelectedInTab == i)
			{
				SelectedIndex = i;
				selectX = posX;
				selectY = posY-(1)*Scale*150;
			}
			if ((SelectedInTab != i || ScrollOffset != ScrollTarget) && posY < Scale*1000)
			{
				H.Canvas.SetDrawColor(255,255,255,255);
				RenderLevelCompTile(H, i, posX, posY-(1)*Scale*150, Scale, false, i, true);
				H.Canvas.SetDrawColor(255,255,255,255);
			}
		}
		if ((i+1)%NumItemsPerRow == 0)
		{
			posX -= TileSpace * (NumItemsPerRow -1);
			posY += TileSpace;
		} 
		else
		{
			posX += TileSpace;
		}
	}
	H.Canvas.PopMaskRegion();

	// selected
	if (SelectedInTab != -1 && ScrollOffset == ScrollTarget)
	{
		if (selectY < Scale*800 && selectY > 0)
			RenderLevelCompTile(H, SelectedIndex, selectX, selectY, Scale, true, SelectedInTab);
	}
}

//Renders the Scrollbar, if necessary
static function RenderScrollbar(HUD H, Hat_HUDMenu e, float x, float y, float bw, float bh, float Scale, float PageSize, float PagePosition, out int BarHover, bool BarPress, out float BarStart, out float BarOutput, color ColorBack, color ColorButtons, color ColorHover, color ColorPressed)
{
	local float oldX, oldY, oldZ, barY, trackHeight;
	local Color originalC;

	// note: PageSize, PagePosition, and BarOutput are 0-1 floats

	oldX = H.Canvas.CurX;
	oldY = H.Canvas.CurY;
	oldZ = H.Canvas.CurZ;
	originalC = H.Canvas.DrawColor;

	trackHeight = bh - bw*2 - Scale*8;
	barY = y + bw + Scale*4 + trackHeight*PagePosition*(1-PageSize);

	if (BarPress && BarHover == 0 && BarStart == -1 && !Hat_HUD(H).IsGamepad() && e.MouseActivated)
		BarStart = e.GetMousePosY(H) - trackHeight*PagePosition*(1-PageSize);

	if (!BarPress)
	{
		BarStart = -1;
		BarOutput = -1;
	}

	if (BarStart == -1)
	{
		BarHover = -1;// nothing
		if (!Hat_HUD(H).IsGamepad() && e.MouseActivated)
		{
			if (e.IsMouseInArea(H, x + bw/2, barY + trackHeight*PageSize/2, bw, trackHeight*PageSize))
				BarHover = 0;// handle
			else if (e.IsMouseInArea(H, x + bw/2, y + bw/2, bw, bw))
				BarHover = 1;// top
			else if (e.IsMouseInArea(H, x + bw/2, y + bh - bw/2, bw, bw))
				BarHover = 2;// bottom
		}
	}
	else
	{
		BarOutput = FMin((trackHeight - trackHeight*PageSize),FMax(0, e.GetMousePosY(H) - BarStart)) / (trackHeight - trackHeight*PageSize);
	}
	
	// draw track
	H.Canvas.SetPos(x - Scale*4,y - Scale*4);
	H.Canvas.DrawColor = ColorBack;
	H.Canvas.DrawColor.A = originalC.A;
	H.Canvas.DrawRect(bw + Scale*8, bh + Scale*8);

	// draw handle
	H.Canvas.SetPos(x, barY);
	H.Canvas.DrawColor = BarHover == 0 ? (BarPress ? ColorPressed : ColorHover) : ColorButtons;
	H.Canvas.DrawColor.A = originalC.A;
	H.Canvas.DrawRect(bw, trackHeight*PageSize);
	
	// draw top arrow
	H.Canvas.SetPos(x, y);
	H.Canvas.DrawColor = BarHover == 1 ? (BarPress ? ColorPressed : ColorHover) : ColorButtons;
	H.Canvas.DrawColor.A = originalC.A;
	H.Canvas.DrawRect(bw, bw);
	
	// draw bottom arrow
	H.Canvas.SetPos(x, y + bh - bw);
	H.Canvas.DrawColor = BarHover == 2 ? (BarPress ? ColorPressed : ColorHover) : ColorButtons;
	H.Canvas.DrawColor.A = originalC.A;
	H.Canvas.DrawRect(bw, bw);
	
	H.Canvas.DrawColor = originalC;
	H.Canvas.SetPos(oldX, oldY, oldZ);
}

//Renders each individual Level Comp Tile in the Main HUD
function RenderLevelCompTile(HUD H, int index, float posX, float posY, float Scale, optional bool selected = false, optional int IndexInTab = INDEX_NONE, optional bool CanBeSelected = true)
{
	local int i;
	local Array<String> Title;
	local Surface SectionIcon;
	local Color originalC;
	local string SectionName;

	selected = IndexInTab != -1 && SelectedInTab == IndexInTab;

	if (CanBeSelected && CheckMouseHover(H, posX, posY, Scale*160, Scale*160) && CheckMouseHover(H,Scale*800, Scale*470, Scale*1200, Scale*710))
	{
		if (!selected)
		{
			selected = true;
			SelectedInTab = IndexInTab;
			PrevMouseSelection = IndexInTab;
			PlayOwnerSound(H, SelectionChangedSound);
		}
	}

	if(LevelMode >= 2) {
		SectionIcon = AllCustomComps.CustomComps[index].Icon;
		SectionName = AllCustomComps.CustomComps[index].Name;
	}
	else {
		SectionIcon = AllLevelCompilations[index].default.Icon;
		SectionName = AllLevelCompilations[index].default.CompName;
	}

	originalC = H.Canvas.DrawColor;

	if (selected)
	{
		RenderPulse(H, self, HighlightBox, PosX, PosY, Scale*180, Scale*180);
	}

	H.Canvas.DrawColor = originalC;
	if (!selected) H.Canvas.SetDrawColor(0,0,0,originalC.A);
	DrawCenter(H, posX, posY, Scale*185, Scale*185, HighlightBox);
	if (SectionIcon != None)
	{
		H.Canvas.DrawColor = originalC;
		DrawCenter(H, posX, posY, Scale*160, Scale*160, SectionIcon);
	}

	H.Canvas.DrawColor = originalC;
	Title = class'Hat_Localizer'.static.SplitStringByLength(SectionName, 25);
	
	for (i = 0; i < Title.Length; i++)
	{
		H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(Title[i]);
		RenderBorderedText(H, self, Title[i], posX, posY + Scale*85 + Scale*22*i, Scale*0.4, TextAlign_Center,,,,, 0.125);
	}
}

static function RenderPulse(HUD H, Hat_HUDElement el, Surface Texture, float PosX, float PosY, float SizeX, float SizeY, optional bool UseOriginalDrawColors)
{
	local float alpha, ScaleMulti;
	local Color originalC;
	local int i;
	
	originalC = H.Canvas.DrawColor;
	
	for (i = 0; i < 2; i++)
	{
		alpha = (class'WorldInfo'.static.GetWorldInfo().RealTimeSeconds+(i == 1 ? 0.5 : 0.0))%1;
		ScaleMulti = Lerp(1, 1.3, alpha);
		H.Canvas.DrawColor.A = originalC.A*Lerp(0.8f,0,alpha**2);
		if (!UseOriginalDrawColors)
			H.Canvas.SetDrawColor(255,0,0,H.Canvas.DrawColor.A);
		DrawCenter(H, posX, posY, SizeX*ScaleMulti, SizeY*ScaleMulti, Texture);
	}
	H.Canvas.DrawColor = OriginalC;
}

function RenderCompPreview(HUD H, float scale)
{
	local array<string> Desc;
	local int i;
	local float width, posx;
	local Texture2D PreviewIcon;
	local string PreviewTitle, PreviewSubtitle;
	local string PreviewDesc;
	local string CompTime;
	// background
	H.Canvas.DrawColor.A = 255;
	DrawCenter(H, Scale*800, Scale*395, Scale*1040, Scale*670, BackgroundGradient);
	H.Canvas.DrawColor.A = 255;
	
	if (BackgroundParticleComponent != None)
	{
		H.Canvas.PushMaskRegion(Scale*284, Scale*64, Scale*(1040-7), Scale*(670-10));
		H.Canvas.SetPos(H.Canvas.ClipX/2, H.Canvas.ClipY);
		BackgroundParticleComponent.RenderToCanvas(H.Canvas);
		H.Canvas.PopMaskRegion();
	}

	if(LevelMode != 2) {
		PreviewIcon = PreviewYLC.Icon;
		PreviewTitle = PreviewYLC.CompName;
		PreviewSubtitle = "A Compilation with " $ PreviewYLC.GetLevelsCount() $ " Levels";
		PreviewDesc = PreviewYLC.GetAllLevelNames();
	}
	else {
		PreviewIcon = AllCustomComps.CustomComps[CustomID].Levels[0].Icon;
		PreviewTitle = AllCustomComps.CustomComps[CustomID].Name;
		PreviewSubtitle = "A Compilation with " $ AllCustomComps.CustomComps[CustomID].Levels.Length $ " Levels";
		PreviewDesc = class'Yoshi_LevelCompilation'.static.GetAllLevelNamesByArray(AllCustomComps.CustomComps[CustomID].Levels);
	}
	
	// icon
	if (PreviewIcon != None)
	{
		H.Canvas.SetDrawColor(255,255,255,255);
		DrawTopLeft(H, Scale*320, Scale*110, Scale*270, Scale*270, PreviewIcon);
	}

	// title
	H.Canvas.SetDrawColor(255,255,255,255);
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(PreviewTitle);
	RenderBorderedText(H, self, PreviewTitle, Scale*615, Scale*130, Scale*0.7, TextAlign_Left);

	// subtitle
	H.Canvas.SetDrawColor(255,255,255,128);
	DrawTopLeftText(H.Canvas, PreviewSubtitle, Scale*635, Scale*160, Scale*0.45, Scale*0.45);
	H.Canvas.SetDrawColor(255,255,255,255);

	// Levels List
	H.Canvas.PushMaskRegion(Scale*610, Scale*200, Scale*650, Scale*400);

	Desc = class'Hat_Localizer'.static.SplitStringByLength(PreviewDesc, 82);
	for (i = 0; i < Desc.Length; i++)
	{
		H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(Desc[i]);
		DrawTopLeftText(H.Canvas, Desc[i], Scale*620, Scale*210 + Scale*25*i - PreviewScrollOffset*Scale*25, Scale*0.37, Scale*0.37);
	}
	H.Canvas.PopMaskRegion();

	if (Desc.Length > 15)
	{
		PreviewScrollMax = Desc.Length - 15.5;

		// scrollbar
		if (PScrollbarOutput > -1)
			PreviewScrollOffset = PScrollbarOutput*PreviewScrollMax;
		
		RenderScrollbar(H, self, Scale*1250, Scale*200, Scale*26, Scale*400, Scale, 15.5/Desc.Length, PreviewScrollOffset/PreviewScrollMax, PScrollbarState, PScrollbarPress, PScrollbarDrag, PScrollbarOutput, ScrollbarColorBack, ScrollbarColorButtons, ScrollbarColorHover, ScrollbarColorPressed);
	}
	else
		PScrollbarState = -1;


	// level options
	width = scale*330;
	for (i = 0; i < PreviewButtons.Length; i++)
	{
		posx = Scale*800;
		
		posx -= PreviewButtons.Length >= 2 ? 2*width*0.5f : 0.0;
		posx += i*width;
		
		DrawPreviewButton(H, PreviewButtonsText[PreviewButtons[i]], posx, Scale*660, Scale, PreviewButtons[i] < PreviewButtonsIcon.Length ? PreviewButtonsIcon[PreviewButtons[i]] : None, PreviewButtons[i]);
	}
	if(PreviewButtons.Length == 0) {
		RenderBorderedText(H, self, "To play this Compilation, check that\nyou have all the required Mods installed!", Scale*800 + i*width, Scale*660, Scale*0.4, TextAlign_Center);
	}
	//Check for Compilation completion. If so, we display a trophy
	if(PreviewYLC.default.CompilationID != 99999 && class'Hat_SaveBitHelper'.static.GetLevelBits(string(PreviewYLC.default.Class), PreviewYLC.default.CompilationsMap) == 1) {
		DrawTopLeft(H, Scale*327+32, Scale*400, Scale*256*0.75, Scale*256*0.75, Texture2D'HatInTime_HUD_ConvBubbles.Textures.Trophy');
	}
	//Check for a Clear Time. If so, we display it
	//Don't display on Custom Comps or Deathathon (Deathathon can have 3 buttons so it'll overlap)
	if(PreviewYLC.default.CompilationID != 99999 && PreviewYLC.default.CompilationID != 99998 && PreviewYLC.GetBestTime() > 0) {

		CompTime = class'Yoshi_LevelCompilation'.static.FormatTime(PreviewYLC.GetBestTime(), true, false);
		RenderBorderedText(H, self, "Best Time: " $ CompTime, Scale*1020, Scale*640, Scale*0.6, TextAlign_TopLeft);

	}
}

function RenderHallOfFame(HUD H, float scale) {
	local string CompChamp;
	local float width;
	local int i;
	local float posx, posy;
	// background
	H.Canvas.DrawColor.A = 255;
	DrawCenter(H, Scale*800, Scale*395, Scale*1040, Scale*670, DeathathonHallOfFameBackground);
	H.Canvas.DrawColor.A = 255;

	CompChamp = "Compilation Champions";
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(CompChamp); //Title is specified in OnOpenHUD
	class'Hat_HUDElementItemUnlock'.static.DrawFancyUnlockText(H.Canvas, self, CompChamp, Scale*800, Scale*120, Scale*1.5, TextAlign_Center);


	width = scale*75;
	posx = Scale*800;
	posy = Scale*240;
	for(i = 0; i < DeathathonCompletionists.Length; i++) {
		RenderBorderedText(H, self, DeathathonCompletionists[i], posx, posy + i*width, Scale*0.75, TextAlign_Center);
	}

}

function DrawPreviewButton(HUD H, string text, float posX, float posY, float Scale, optional Surface Icon, optional EModLevelPreviewButton Button = LevelPreview_None)
{
	local Color originalC;
	local bool selected;
	local float sizex, sizey, textsize, scalealpha, TextOffsetY;
	local Surface MyPreviewButtonImage, MyPreviewButtonImage_Silhouette;
	originalC = H.Canvas.DrawColor;

	selected = Button != LevelPreview_None && SelectedButton == Button;
	sizex = Scale*275;
	sizey = Scale*75;
	textsize = Scale*0.8;
	TextOffsetY = 0;
	
	MyPreviewButtonImage = PreviewButtonImage;
	MyPreviewButtonImage_Silhouette = PreviewButtonImage_Silhouette;		

	if (CheckMouseHover(H, posX, posY, sizex, sizey))
	{
		if (!selected)
		{
			selected = true;
			SelectedButton = Button;
			PlayOwnerSound(H, SelectionChangedSound);
			PreviewButtonsInterp = 0;
		}
	}
	
	if (selected)
	{
		scalealpha = class'Hat_Math'.static.InterpolationOvershoot(1, 1.1, PreviewButtonsInterp, 10);
		SizeX *= scalealpha;
		SizeY *= scalealpha;
		TextSize *= scalealpha;
		
		RenderPulse(H, self, MyPreviewButtonImage_Silhouette, PosX, PosY, sizex, sizey);
	}

	if (selected) H.Canvas.SetDrawColor(128,230,255,originalC.A);
	else if (Button == LevelPreview_Play || Button == LevelPreview_DownloadMod || Button == LevelPreview_Enable || Button == LevelPreview_DownloadModMap || Button == LevelPreview_CancelDownload) H.Canvas.SetDrawColor(255,128,128,originalC.A);
	else if (Button == LevelPreview_UnSubscribe) H.Canvas.SetDrawColor(255,32,32,originalC.A);
	else H.Canvas.SetDrawColor(128,128,128,originalC.A);
	
	TextOffsetY = SizeY*-0.05;
	if (Button == LevelPreview_Workshop)
		TextOffsetY = SizeY*-0.4;
	
	DrawCenter(H, posX, posY, sizex, sizey, MyPreviewButtonImage);
	H.Canvas.SetDrawColor(0,0,0,255);
	if (Icon != None)
	{
		DrawCenter(H, posX - (text != "" ? sizex*0.3 : 0.0), posY, sizey*0.75, sizey*0.75, Icon);
		posx += sizex*0.1;
	}
	
	H.Canvas.DrawColor = originalC;
	if (text != "")
	{
		H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(text);
		RenderBorderedText(H, self, text, posX, posY+TextOffsetY, TextSize, TextAlign_Center);
	}
}

function ExitCompPreview()
{
	InCompPreview = false;
	PScrollbarState = -1;
	PreviewScrollOffset = 0;
	PreviewYLC = None;
}

function UpdatePreviewButtons(HUD H)
{
	PreviewButtons.Length = 0;
	if(Yoshi_ModLevelCompilation(PreviewYLC) != None && Yoshi_ModLevelCompilation(PreviewYLC).CheckForMissingMods()) {
		PreviewButtons.AddItem(LevelPreview_DownloadMod);
	}
	else {
		//Continue Button
		if(PreviewYLC.GetLevelNumber(PreviewYLC.default.CompilationID) > 0) {
			PreviewButtons.AddItem(LevelPreview_Enable);
		}

		PreviewButtons.AddItem(LevelPreview_Play);
	}

	//Deathathon Champs
	if(PreviewYLC.default.CompilationID == 99998) {
		PreviewButtons.AddItem(LevelPreview_Config);
	}
}


function bool CheckMouseHover(HUD H, float PosX, float PosY, float SizeX, float SizeY)
{
	local bool r;
	r = !Hat_HUD(H).IsGamepad() && MouseActivated && IsMouseInArea(H, PosX, PosY, SizeX, SizeY);
	if (r && MouseClear) MouseClear = false;
	return r;
}

//Self explanatory, the action taken upon clicking
function bool OnClick(HUD H, bool release)
{
	local PlayerController pc;
	local Hat_HUD MyHUD;
	local Yoshi_HUDElementGhostPartyJoinLevelComp JoinActHUD;

	if (release)
	{
		LScrollbarPress = false;
		PScrollbarPress = false;
		return false;
	}

	if (!InCompPreview && !Hat_HUD(H).IsGamepad() && MouseActivated && LScrollbarState > -1)
	{
		if (LScrollbarState == 0)
		{
			LScrollbarPress = true;
			return true;
		}
		else if (LScrollbarState == 1)
		{
			ScrollTarget = FMax(ScrollTarget - 1, 0);
			LScrollbarPress = true;
			return true;
		}
		else if (LScrollbarState == 2)
		{
			ScrollTarget = FMin(ScrollTarget + 1, (FFloor((TotalSelections-1)/NumItemsPerRow)-2));
			LScrollbarPress = true;
			return true;
		}
	}

	if(InCompPreview) {
		//Preview Scrollbar
		if (!Hat_HUD(H).IsGamepad() && MouseActivated && PScrollbarState > -1)
		{
			if (PScrollbarState == 0)
			{
				PScrollbarPress = true;
				return true;
			}
			else if (PScrollbarState == 1)
			{
				PreviewScrollOffset = FMax(PreviewScrollOffset - 3, 0);
				PScrollbarPress = true;
				return true;
			}
			else if (PScrollbarState == 2)
			{
				PreviewScrollOffset = FMin(PreviewScrollOffset + 3, PreviewScrollMax);
				PScrollbarPress = true;
				return true;
			}
		}

		if (InCompPreview && SelectedButton == LevelPreview_Play) {
			pc = class'Engine'.static.GetEngine().GamePlayers[0].Actor;
			MyHUD = pc != None ? Hat_HUD(pc.MyHUD) : None;

			//LevelMode checks determine what to do upon pressing play.
			//LevelMode 0 and 1 check for Online Party requirements, if true open the HUD, otherwise just play the Compilation locally.
			//LevelMode 2 is custom, so just play the compilation.

			//PreviewYLC contains the information in the current Preview
			if(LevelMode == 2) {
				if(PreviewYLC != None)
					PreviewYLC.Initialize();
				foreach GetWorldInfo().AllActors(class'PlayerController',pc)
					SetCinematicMode(pc, false);
			}
			else if(class'GameMod'.static.GetConfigValue(class'Yoshi_LevelCompilations_GameMod', 'OnlinePartySupport') == 0 && class'Hat_GhostPartyPlayerStateBase'.static.ConfigGetUseOnlineFunctionality() && class'Hat_GhostPartyPlayerStateBase'.static.HasNonLocalPrivatePlayerStates(true)) 
			{
			
				if (MyHUD.GetHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp') != None) return false; // Prompt already open
				if (MyHUD.GetHUD(class'Hat_HUDElementGhostPartyJoinAct') != None) return false; //Regular Level Prompt is already open
				JoinActHUD = Yoshi_HUDElementGhostPartyJoinLevelComp(MyHUD.OpenHUD(class'Yoshi_HUDElementGhostPartyJoinLevelComp'));
				//Print("Opening HUD with CompilationID " $ CompilationID);
				if(PreviewYLC != None)
					JoinActHUD.HostJoinAct(PreviewYLC.default.CompilationID);
			
			}
			else {
				if(PreviewYLC != None) {

					if(Yoshi_RandomizerLevelCompilation(PreviewYLC) != None) {
						Yoshi_RandomizerLevelCompilation(PreviewYLC).SetSeed(class'Yoshi_RandomizerLevelCompilation'.static.GenerateNewSeed());
					}

					PreviewYLC.Initialize();
				}
					
				foreach GetWorldInfo().AllActors(class'PlayerController',pc)
					SetCinematicMode(pc, false);
			}
		
			//We may want to remove more than one comp.
			if(LevelMode != 3) {}
				CloseHUD(H);
			PlayOwnerSound(H, SelectSound);
			return true;
		}
		//Continue Button does not call OP, just join
		else if(InCompPreview && SelectedButton == LevelPreview_Enable) {
			if(PreviewYLC != None) {
				PreviewYLC.RejoinActiveCompilation();
			}
			foreach GetWorldInfo().AllActors(class'PlayerController',pc)
					SetCinematicMode(pc, false);

			CloseHUD(H);
			PlayOwnerSound(H, SelectSound);
		}
		else if(InCompPreview && SelectedButton == LevelPreview_DownloadMod && Yoshi_ModLevelCompilation(PreviewYLC).default.CompilationURL != "") {
			Yoshi_ModLevelCompilation(PreviewYLC).OpenCollection();
			PlayOwnerSound(H, WorkshopSound);
		}
		else if(InCompPreview && SelectedButton == LevelPreview_Config) {
			InHallOfFame = true;
		}
	}
	else if (SelectedInTab != -1) //SelectedInTab is our selected Compilation.
	{	
		pc = class'Engine'.static.GetEngine().GamePlayers[0].Actor;
		MyHUD = pc != None ? Hat_HUD(pc.MyHUD) : None;

		if(LevelMode == 3) {
			class'Yoshi_LevelCompilation_Custom'.static.ShiftLevelBits(SelectedInTab, AllCustomComps);
			AllCustomComps.CustomComps.Remove(SelectedInTab, 1);
			class'Engine'.static.BasicSaveObject(AllCustomComps, "LevelCompilations/CustomCompilations.levelcomp", false, 1);
			TotalSelections = AllCustomComps.CustomComps.Length;
			PlayOwnerSound(H, RemoveSound);
		}
		else if(LevelMode == 2) {
			CustomID = SelectedInTab;
			class'Yoshi_LevelCompilation'.static.SetCustomCompilationID(CustomID);
			InCompPreview = true;
			PreviewYLC = class'Yoshi_LevelCompilation'.static.ReturnByID(99999, AllLevelCompilations);
			if(PreviewYLC == None) {
				Print("Error: YLC is None, Attempted with SelectedInTab " $ SelectedInTab $ " and ALC Length" $ AllLevelCompilations.length);
			}
			
			PlayOwnerSound(H, SelectSound);
			UpdatePreviewButtons(H);
			if (Hat_HUD(H).IsGamepad() || !MouseActivated) SelectedButton = PreviewButtons.Length > 0 ? PreviewButtons[0] : LevelPreview_ThumbsUp;
		}
		else {
			InCompPreview = true;
			PreviewYLC = class'Yoshi_LevelCompilation'.static.ReturnByID(AllLevelCompilations[SelectedInTab].default.CompilationID, AllLevelCompilations);
			if(PreviewYLC == None) {
				Print("Error: YLC is None, Attempted with SelectedInTab " $ SelectedInTab $ " and ALC Length" $ AllLevelCompilations.length);
			}
			
			PlayOwnerSound(H, SelectSound);
			UpdatePreviewButtons(H);
			if (Hat_HUD(H).IsGamepad() || !MouseActivated) SelectedButton = PreviewButtons.Length > 0 ? PreviewButtons[0] : LevelPreview_ThumbsUp;
		}
	}
	else {
		return false;
	}
	
	PlayOwnerSound(H, SelectSound);
	return true;
}

function bool OnAltClick(HUD H, bool release)
{
	local PlayerController pc;
	if (release) return false;

	if(InHallOfFame) {
		InHallOfFame = false;
		PlayOwnerSound(H, ExitSound);
		return true;
	}

	if(InCompPreview && !InHallOfFame) {
		ExitCompPreview();
		PlayOwnerSound(H, ExitSound);
		return true;
	}

	foreach GetWorldInfo().AllActors(class'PlayerController',pc)
		SetCinematicMode(pc, false);
	CloseHUD(H);
	PlayOwnerSound(H, ExitSound);
    return true;
}

// There are 4 functions for pressing directions
// OnPressDown
// OnPressUp
// OnPressLeft
// OnPressRight

function bool OnPressDown(HUD H, bool menu, bool release)
{
	if (release) return false;
	if(InCompPreview) {
		if(InHallOfFame) return false;
		if(SelectedButton == LevelPreview_None) {
			SelectedButton = PreviewButtons[0];
			SetMouseHidden(H,true);
			PlayOwnerSound(H, SelectionChangedSound);
			return true;
		}
		return false;
	}

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;
	if (SelectedInTab + 5 < TotalSelections)
		SelectedInTab += 5;
	else return false;

	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);
	return true;
}

function bool OnPressUp(HUD H, bool menu, bool release)
{
	if (release) return false;
	if(InCompPreview) {
		if(InHallOfFame) return false;
		if(SelectedButton == LevelPreview_None) {
			SelectedButton = PreviewButtons[0];
			SetMouseHidden(H,true);
			PlayOwnerSound(H, SelectionChangedSound);
			return true;
		}
		return false;
	}

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;
	if (SelectedInTab - 5 >= 0)
		SelectedInTab -= 5;
	else return false;
	
	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);
	return true;
}

function bool OnPressLeft(HUD H, bool menu, bool release)
{
	if (release) return false;
	if(InCompPreview) {
		if(InHallOfFame) return false;
		if(SelectedButton == LevelPreview_None) {
			SelectedButton = PreviewButtons[0];
			SetMouseHidden(H,true);
			PlayOwnerSound(H, SelectionChangedSound);
			return true;
		}

		if(SelectedButton == PreviewButtons[1] && PreviewButtons.Length >= 2) {
			SelectedButton = PreviewButtons[0];
			SetMouseHidden(H, true);
			PlayOwnerSound(H, SelectionChangedSound);
			return true;
		}
		return false;
	}

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;
	if (SelectedInTab%NumItemsPerRow > 0 && SelectedInTab - 1 >= 0)
		SelectedInTab--;
	else return false;

	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);
	return true;
}


function bool OnPressRight(HUD H, bool menu, bool release)
{
	if (release) return false;
	if(InCompPreview) {
		if(InHallOfFame) return false;
		if(SelectedButton == LevelPreview_None) {
			SelectedButton = PreviewButtons[0];
			SetMouseHidden(H,true);
			PlayOwnerSound(H, SelectionChangedSound);
			return true;
		}

		if(SelectedButton == PreviewButtons[0] && PreviewButtons.Length >= 2) {
			SelectedButton = PreviewButtons[1];
			SetMouseHidden(H, true);
			PlayOwnerSound(H, SelectionChangedSound);
		}
		return false;
	}

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;

	if (SelectedInTab%NumItemsPerRow < 4 && SelectedInTab + 1 < TotalSelections)
		SelectedInTab++;
	else return false;

	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);
	return true;
}

defaultproperties
{
	BackgroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Blue';
	DeathathonHallOfFameBackground = Material'Yoshi_LevelComp_Content2.Materials.DeathathonHallOfFameBackground'

	BackgroundParticle = ParticleSystem'HatinTime_HUD_Modding.Particles.ModMenuBackgroundParticles';

	HighlightBox = Texture2D'HatinTime_HUD_Settings.Main.Main_BoxHighlight';

	SelectionChangedSound = SoundCue'HatInTime_Hud.SoundCues.CursorMove';
	SelectSound = SoundCue'HatInTime_Hud.SoundCues.MenuNext'
	ExitSound = SoundCue'HatInTime_Hud.SoundCues.MenuSkip'
	RemoveSound = SoundCue'HatinTime_SFX_UI2.SoundCues.Wrong'
	WorkshopSound = SoundCue'HatInTime_Hud.SoundCues.MenuNext'

	FadeIn=0.0;
	FadeOut=1.0;
	NumItemsPerRow=5;

	RequiresMouse = true;
	MouseClear = true;
	RealTime = true;
	SharedInCoop = true;
	NoSharedInput = true;

	SelectedInTab = -1;
	SelectedIndex = -1;
	ScrollOffset = 0;

	ScrollbarColorBack = (R=100,G=100,B=100);//100,200,255
	ScrollbarColorButtons = (R=240,G=240,B=240);//80,180,230
	ScrollbarColorHover = (R=200,G=200,B=200);//65,165,215
	ScrollbarColorPressed = (R=150,G=150,B=150);//0,100,200

	LevelMode=0

	PreviewButtonImage = Texture2D'HatinTime_HUD_Modding.Textures.SharpButton'
	PreviewButtonImage_Silhouette = Material'HatinTime_HUD_Modding.Materials.SharpButton_Silhouette'
	PreviewButtonsIcon(LevelPreview_Play) = Texture2D'HatinTime_HUD_Modding.Textures.Icon_Play';
	PreviewButtonsIcon(LevelPreview_DownloadMod) = Texture2D'HatinTime_HUD_Modding.Textures.Icon_Play';
	PreviewButtonsIcon(LevelPreview_Enable) = Texture2D'Yoshi_LevelComp_Content2.Textures.LevelPreview_ContinueIcon';
	PreviewButtonsIcon(LevelPreview_Config) = Texture2D'Yoshi_LevelComp_Content2.Textures.LevelPreview_CrownIcon';
	InCompPreview = false;

	DeathathonCompletionists.Add("NiceStickman");
	DeathathonCompletionists.Add("SuperInkLink");
	//DeathathonCompletionists.Add("???");
	//DeathathonCompletionists.Add("???");
	//DeathathonCompletionists.Add("???");
	//DeathathonCompletionists.Add("???");
}
