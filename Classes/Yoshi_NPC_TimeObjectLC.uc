class Yoshi_NPC_TimeObjectLC extends Hat_NPC
	placeable;

simulated function bool CanBeInteractedWith(Actor hOther)
{
	return true;
}

simulated function bool OnInteractedWith(Actor a)
{
	
	if (ConversationTreeInstance != None)
		ConversationTreeInstance.Destroy();
	ConversationTreeInstance = None;
	
	if (!Super.OnInteractedWith(a)) return false;
	
	if(ConversationTreeInstance != None) {
		Hat_PlayerController(Pawn(a).Controller).TalkManager.PushEventDelegate(self.OnTalkMessageEvent);
	}
    return true;
}

delegate OnTalkMessageEvent(Controller c, string event)
{
	TakeAction(c, event);
}

function TakeAction(controller c, string event) {
   local float GameTime;
   local float ActTime;
   local String Text;
   local String Text2;
   //Print("Selected Event: " $ event);
   switch(event) {

      //Play Compilations
      case "OpenRegularComps": 
         ActivateLevelCompilationsHUD(c, "Regular");
         break;
      case "OpenModComps":
         ActivateLevelCompilationsHUD(c, "Mod");
         break;
      case "OpenCustomComps":
         ActivateLevelCompilationsHUD(c, "Custom");
         break;

      //Extra Features
      case "OpenMakeCustomComp":
         Text = GetPlayerStringByVariable("NumberOfCompilationLevels");
         Text2 = GetPlayerStringByVariable("NameOfCompilation");
         //Print("The Inputted Text was: " $ Text);
         ActivateCustomCompilationHUD(c, int(Text), Text2);
         break;
      case "OpenRemoveCustomComps":
         ActivateLevelCompilationsHUD(c, "CustomRemove");
         break;
      case "ResetCompStats":
         class'Yoshi_LevelCompilation'.static.ResetCompilationsCleared();
         break;

      //Unpause the Timer
      case "UnpauseTimer": 
         if (`SaveManager.SaveData == None) return;
         GameTime = class'Hat_GlobalTimer'.static.GetGameTime();
         ActTime = class'Hat_GlobalTimer'.static.GetActTime();
         class'Hat_GlobalTimer'.static.Restart();
         class'Hat_GlobalTimer'.static.Init(GameTime, ActTime, `SaveManager.GetNumberOfTimePieces());
         break;

      //Resets all Continue Data
      case "ResetCurrentComp":
         class'Yoshi_LevelCompilation'.static.ResetContinueData();
         break;

   }
}

function String GetPlayerStringByVariable(String VariableName) {
   local String s;
   s = "[" $ VariableName $ "]";
   `GameManager.ReplaceByConversationString(s);
   return s;
}

function ActivateLevelCompilationsHUD(controller c, string HUDType) {
	local HUD MyHUD;
	
	MyHUD = PlayerController(c).MyHUD;
	Hat_HUD(MyHUD).OpenHUD(class'Yoshi_HUDMenu_LevelComps', HUDType);
}

function ActivateCustomCompilationHUD(controller c, int NumberOfLevels, string CustomCompName) {
   local HUD MyHUD;
   if(NumberOfLevels <= 0) {
      return;
   }
	
	MyHUD = PlayerController(c).MyHUD;
   //Subtract 1 from NumberOfLevels because we begin with 0.
	Hat_HUD(MyHUD).OpenHUD(class'Yoshi_HUDMenu_CompLevelSelect', 0 $ "+" $ (NumberOfLevels - 1) $ "+" $ CustomCompName);

}

static function Print(coerce string msg)
{
	class'Yoshi_LevelCompilations_GameMod'.static.Print(msg);
}

simulated event PostBeginPlay() {
   PlayIdleAnimation();
   Super.PostBeginPlay();
}

defaultproperties
{
   Begin Object Name=SkeletalMeshComponent0
      SkeletalMesh=SkeletalMesh'HatInTime_Items.models.timeobject'
      PhysicsAsset=PhysicsAsset'HatInTime_Items.Physics.timeobject_Physics'
      AnimSets(0)=AnimSet'HatInTime_Items.AnimSets.timeobject_Anims'
	  Translation=(Z=-18)
   End Object

   bBlockActors = false;
   bCollideActors = false;

   FocusPointerZOffset = -100;

   TalkingAnimation = "timeobject_enabled";
   IdleAnimation = "timeobject_spin";

   ConversationTree = Hat_ConversationTree'Yoshi_LevelComp_Content.ConversationTrees.SelectLevelCompilation'
}