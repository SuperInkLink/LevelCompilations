//EpicYoshiMaster
//Credits to Jasmine (Jazzrabbit) whom this code is largely based on.

class Yoshi_HUDMenu_CompLevelSelect extends Hat_HUDMenu
    dependson(Yoshi_LevelCompilation);

//Render
//OnClick OnMouseDown
//OnOpenHUD OnCloseHUD

var Surface BackgroundGradient;
var Surface SectionBackgroundGradient;
var float BackgroundAlpha;

var Texture2D HighlightBox;

var float FadeOut;
var float FadeIn;
var int NumItemsPerRow;

var int SelectedInTab;
var int PrevMouseSelection;
var int SelectedIndex;

var transient float MenuFadeIn;

var float ScrollOffset;
var float ScrollTarget;

var transient ParticleSystem BackgroundParticle;
var transient ParticleSystemComponent BackgroundParticleComponent;

var int LScrollbarState;
var bool LScrollbarPress;
var float LScrollbarOutput;
var float LScrollbarDrag;

var int PScrollbarState;
var bool PScrollbarPress;
var float PScrollbarOutput;
var float PScrollbarDrag;

var color ScrollbarColorBack;
var color ScrollbarColorButtons;
var color ScrollbarColorHover;
var color ScrollbarColorPressed;

var SoundCue SelectionChangedSound;
var SoundCue SelectSound;
var SoundCue ExitSound;

var bool MouseClear;

var int TotalLevels;
var string CompilationName;
var int LevelNumber;
var array<CompilationLevel> AllCompilationLevels;
var Yoshi_LevelCompilation YLC;

function OnOpenHUD(HUD H, optional string command)
{
	local PlayerController pc;
    local array<string> arr;
    Super.OnOpenHUD(H, command);
	
	if (command == "close")
		DoClose(H);
	else
	{
        arr = SplitString(command, "+");
        if(arr.length == 3) {
            LevelNumber = int(arr[0]);
            TotalLevels = int(arr[1]);
			CompilationName = arr[2];
        }
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
	
    if(AllCompilationLevels.Length == 0) {
        LevelsList();
    }

	MouseClear = true;

	RenderLevelCompTileList(H, scale);
	if (MouseClear && !Hat_HUD(H).IsGamepad() && MouseActivated)
		WipeAllSelections();

    return true;
}

static function Print(coerce string s)
{
	class'Yoshi_LevelCompilations_GameMod'.static.Print(s);
}

//Like leaving the mod menu, don't save your last location
function WipeAllSelections()
{
	SelectedIndex = -1;
	SelectedInTab = -1;
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
	local int i, TotalSelections;
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
	
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("Custom Compilation: Level " $ (LevelNumber + 1));
	class'Hat_HUDElementItemUnlock'.static.DrawFancyUnlockText(H.Canvas, self, "Custom Compilation: Level "  $ (LevelNumber + 1), Scale*220, Scale*120, Scale*1.5, TextAlign_BottomLeft);

	TotalSelections = AllCompilationLevels.Length;
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
	
	for (i = 0; i < AllCompilationLevels.Length; i++)
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
		//TotalSelections++;
	}
	H.Canvas.PopMaskRegion();

	// selected
	if (SelectedInTab != -1 && ScrollOffset == ScrollTarget)
	{
		if (selectY < Scale*800 && selectY > 0)
			RenderLevelCompTile(H, SelectedIndex, selectX, selectY, Scale, true, SelectedInTab);
	}
}

//Called by RenderLevelCompTileList
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

//Renders each individual Level Comp Tile
function RenderLevelCompTile(HUD H, int index, float posX, float posY, float Scale, optional bool selected = false, optional int IndexInTab = INDEX_NONE, optional bool CanBeSelected = true)
{
	local int i;
	local Array<String> Title;
	local Surface SectionIcon;
	local Color originalC;
	local string SectionName;

	selected = IndexInTab != -1 && SelectedInTab == IndexInTab;

	if (CanBeSelected && CheckMouseHover(H, posX, posY, Scale*160, Scale*160) && CheckMouseHover(H, Scale*800, Scale*450, Scale*1200, Scale*710))
	{
		if (!selected)
		{
			selected = true;
			SelectedInTab = IndexInTab;
			PrevMouseSelection = IndexInTab;
			PlayOwnerSound(H, SelectionChangedSound);
		}
	}

    if(AllCompilationLevels[index].isRift > 0) {
        if(AllCompilationLevels[index].isRift == 1) {
            SectionIcon = Texture2D'Yoshi_LevelComp_Content.Textures.AllBlueRifts';
        }
        else {
            SectionIcon = Texture2D'Yoshi_LevelComp_Content.Textures.AllPurpleRifts';
        }
    }
    else {
        SectionIcon = AllCompilationLevels[index].Icon;
    }
	
	SectionName = AllCompilationLevels[index].ActName;
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

//???
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
    local Yoshi_CustomCompilationStorage CustomCompilation;

	if (release)
	{
		LScrollbarPress = false;
		PScrollbarPress = false;
		return false;
	}

	if (!Hat_HUD(H).IsGamepad() && MouseActivated && LScrollbarState > -1)
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
			ScrollTarget = FMin(ScrollTarget + 1, (FFloor((AllCompilationLevels.Length-1)/NumItemsPerRow)-2));
			LScrollbarPress = true;
			return true;
		}
	}

	if (SelectedInTab != -1)
	{	
        CustomCompilation = new class'Yoshi_CustomCompilationStorage';
        class'Engine'.static.BasicLoadObject(CustomCompilation, "LevelCompilations/CustomCompilations.levelcomp", false, 1);

        if(LevelNumber == 0) {
            CustomCompilation.CustomComps.Add(1);
			CustomCompilation.CustomComps[CustomCompilation.CustomComps.Length - 1].Name = CompilationName;
			CustomCompilation.CustomComps[CustomCompilation.CustomComps.Length - 1].Icon = AllCompilationLevels[SelectedInTab].Icon;
        }

        CustomCompilation.CustomComps[CustomCompilation.CustomComps.Length - 1].Levels.AddItem(AllCompilationLevels[SelectedInTab]);

        if(!class'Engine'.static.BasicSaveObject(CustomCompilation, "LevelCompilations/CustomCompilations.levelcomp", false, 1))
        {
		    Print("Failed to save Custom Compilation!");
        }

        if(TotalLevels > LevelNumber) {
            LevelNumber++;
        }
        else {
            foreach GetWorldInfo().AllActors(class'PlayerController', pc)
			    SetCinematicMode(pc, false);
            CloseHUD(H);
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

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;
	if (SelectedInTab + 5 < AllCompilationLevels.Length)
		SelectedInTab += 5;
	else return false;

	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);

	return true;
}

function bool OnPressUp(HUD H, bool menu, bool release)
{
	if (release) return false;

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

	if (SelectedInTab == -1) SelectedInTab = PrevMouseSelection;

	if (SelectedInTab%NumItemsPerRow < 4 && SelectedInTab + 1 < AllCompilationLevels.Length)
		SelectedInTab++;
	else return false;

	SetMouseHidden(H,true);
	PlayOwnerSound(H, SelectionChangedSound);
	return true;
}

function LevelsList() {
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Lab());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Gallery());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Tour());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.WTMT());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BB());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SCFOS());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DWTM());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.GV());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.HUMT());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.CTR());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Sewers());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Bazaar());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiaOfCooks());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DBS());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MOTOE());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.PP());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TR());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Parade());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.FakeAwardCeremony());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.AwardCeremony());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.OwlExpress());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Moon());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DBSRift());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.CO());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SW());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TOD());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Manor());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MDS());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.YCHE());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Pipe());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Village());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SleepySubcon());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.AlpineFreeRoam());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.LavaCake());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Birdhouse());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Windmill());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TwilightBell());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Illness());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.CurlyTailTrail());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TwilightBellRift());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.AlpineSkylineRift());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Finale());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BonVoyage());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.ShipShape());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.RocktheBoat());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Balcony());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeepSea());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.FreeRoam());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MainStation());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.YellowOverpass());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.GreenClean());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BluefinTunnels());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.PinkPaw());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.YellowOverpassManhole());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.GreenCleanManhole());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.PinkPawManhole());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.RushHour());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.RumbiFactory());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BeatTheHeat());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SYBFOS());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Collectathon());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.VaultCodesInTheWind());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SSFOS());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiasJumps());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.EncoreEncore());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MafiaOfCooksRC());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SecurityBreach());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Hootenanny());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TenSeconds());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.KillingTwoBirds());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeadBirdStudioRC());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.RhythmJumpStudio());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.Impossible());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BreachingTheContract());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.SleepySubconRC());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TwilightTravels());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.BirdSanctuary());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.WoundUpWindmill());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TheIllnessHasSpeedrun());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.AlpineSkylineRC());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.TheMountainRift());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.MustacheGauntlet());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.NoMoreBadGuys());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.CruisinForABruisin());
    AllCompilationLevels.AddItem(class'Yoshi_LevelsSheet'.static.DeepSeaRC());
}

defaultproperties
{
	BackgroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Green';
	SectionBackgroundGradient = MaterialInstanceConstant'HatinTime_HUD_Modding.Materials.ModMenuBackground_Green';
	BackgroundAlpha = 0.5;

	BackgroundParticle = ParticleSystem'HatinTime_HUD_Modding.Particles.ModMenuBackgroundParticles';

	HighlightBox = Texture2D'HatinTime_HUD_Settings.Main.Main_BoxHighlight';

	SelectionChangedSound = SoundCue'HatInTime_Hud.SoundCues.CursorMove';
	SelectSound = SoundCue'HatInTime_Hud.SoundCues.MenuNext'
	ExitSound = SoundCue'HatInTime_Hud.SoundCues.MenuSkip'

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
}
