int framerate = 60;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

public int xs;
public int ys;

//init puzzle solved variables
public boolean debugSolvedPuzzles = false;
public boolean storageRoomUnlocked = false;

void settings()
{
  //fullScreen();
  size(1600, 900);
}

//scuffed but otherwise processing won't be able to use the collectables at all
Collectable knife = new Collectable("knife", "knife.png");
Collectable storageKey = new Collectable("storageKeyItem", "key.png");

public void setup()
{
  frameRate(framerate);

  xs = width / 320; // dynamic units
  ys = height / 180;
  
  //main menu 
  Scene menu = new Scene("menu", "menu.png");
  ButtonObject startButton = new ButtonObject("startButton", 3*xs, 135*ys, 32*xs, 22*ys, "Start", "hallway01");
  ButtonObject optionsButton = new ButtonObject("optionsButton", 3*xs, 150*ys, 32*xs, 22*ys, "Options", "options");
  ButtonObject exitButton = new ButtonObject("exitButton", 3*xs, 165*ys, 32*xs, 22*ys, "Exit", "exit");
  menu.addGameObject(startButton);
  menu.addGameObject(optionsButton);
  menu.addGameObject(exitButton);

  //options
  Scene options = new Scene("options", "menu.png");
  ButtonObject backButton = new ButtonObject("backButton", 3*xs, 165*ys, 32*xs, 22*ys, "Back", "menu");
  options.addGameObject(backButton);
  

/*------Scenes & room navigation-------*/

//storageRoom
  Scene storageRoom = new Scene("storageRoom", "storageRoom.png" );

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoom_hallway02", 156*xs, 160*ys, 16*xs, 16*xs, "arrowUp.png", true);
  storageRoom.addGameObject(storageTohallway02);

  //TODO add knife to storage room
  CollectableObject knifeObject = new CollectableObject("storage_room", 80*xs, 36*ys, 16*xs, 16*xs, true, knife);
  storageRoom.addGameObject(knifeObject);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "barracks.png" );

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracks_hallway01", 140*xs, 100*ys, 16*xs, 16*xs, "arrowUp.png", true);
  barracksRoom.addGameObject(barrackstohallway01);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "controlRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoom_hallway01", 10*xs, 90*ys, 16*xs, 16*xs, "arrowUp.png", "hallway01");
  controlRoom.addGameObject(controltohallway01);


//hallway01
  Scene hallway01 = new Scene("hallway01", "hallway01.png" );

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01_hallway02", 156*xs, 150*ys, 16*xs, 16*xs, "arrowDown.png", "hallway02");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01_barracksRoom", 90*xs, 90*ys, 16*xs, 16*xs, "arrowLeft.png", "barracksRoom");
  hallway01.addGameObject(h1tobarracksRoom);

  //hallway01_exit_keypad
    Scene keypadPuzzle = new Scene("keypadPuzzle", "hallway01_closeup.png");

    //hallway01 to keypadPuzzle
    MoveToSceneObject h1keypadPuzzle = new MoveToSceneObject("hallway01_keypadPuzzle", 156*xs, 70*ys, 16*xs, 16*xs, "zoom.png", "keypadPuzzle");
    h1keypadPuzzle.setHoverImage("zoomIn.png");
    hallway01.addGameObject(h1keypadPuzzle);

    //back to hallway01
    MoveToSceneObject keypadPuzzleToH1 = new MoveToSceneObject("keypadPuzzle_hallway01", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", "hallway01");
    keypadPuzzle.addGameObject(keypadPuzzleToH1);

    //keypad puzzle
    String correctKeypadCode = "111";
    KeypadPuzzleObject keypadPuzzleObject = new KeypadPuzzleObject("hallway03_keypadPuzzleObject", 103*xs, 10*ys, 120*xs, 168*ys, correctKeypadCode, "lock_wrong.png");
    keypadPuzzle.addGameObject(keypadPuzzleObject);

  //to Controlroom (needs check)
  if(debugSolvedPuzzles){
    MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01_controlRoom", 220*xs, 90*ys, 16*xs, 16*xs, "arrowRight.png", "controlRoom");
    hallway01.addGameObject(h1tocontrolRoom);
  }
  else{
    //TODO finger scanner puzzle
  }
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "hallway02.png");

  //to hallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02_hallway01", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", "hallway01");
  hallway02.addGameObject(h2ToHallway01);

  //toStorageRoom
  if (!storageRoomUnlocked ||debugSolvedPuzzles) {
    StorageDoorLock h2ToStorageRoom = new StorageDoorLock("hallway02_StorageRoom", 215*xs, 90*ys, 16*xs, 16*xs, "zoom.png", "storageRoom",storageKey);
    h2ToStorageRoom.setHoverImage("zoomIn.png");
    hallway02.addGameObject(h2ToStorageRoom);
    //TODO add door locked sound/ dialogue that door is locked.
  }
  else{ 
  }

//Ending scene
  Scene ending = new Scene("ending", "TEMP_ending.png");
  
/*----closeups-----*/

  //hallway02locker_keycodes
    Scene lockerPuzzle = new Scene("lockerPuzzle", "hallway02.png");

    //back to hallway02
    MoveToSceneObject lockerpuzzletohallway02 = new MoveToSceneObject("lockerPuzzle_hallway02", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", true);
    lockerPuzzle.addGameObject(lockerpuzzletohallway02);

    //locker puzzle code 
    String correctLockerCode = "123";
    LockerPuzzleObject lockerPuzzleObject = new LockerPuzzleObject("hallway02_lockerPuzzleObject", 156*xs, 130*ys, 160*xs, 90*ys, correctLockerCode);
    lockerPuzzle.addGameObject(lockerPuzzleObject);

    //to locker puzzle
    MoveToSceneObject h2LockerPuzzle = new MoveToSceneObject("hallway02_lockerPuzzle", 105*xs, 95*ys, 16*xs, 16*xs, "zoom.png", "lockerPuzzle");
    h2LockerPuzzle.setHoverImage("zoomIn.png");

    //to open locker
    MoveToSceneObject h2OpenLocker = new MoveToSceneObject("hallway02_openLocker", 105*xs, 95*ys, 16*xs, 16*xs, "zoom.png", "openLocker");
    h2OpenLocker.setHoverImage("zoomIn.png");
    hallway02.addHiddenObject(h2OpenLocker);

    //Locker
    hallway02.addGameObject(h2LockerPuzzle);

  //hallway02open_locker
    Scene openLocker = new Scene("openLocker", "hallway02_lockerOpen.png");

    //back to hallway02
    MoveToSceneObject openlockertohallway02 = new MoveToSceneObject("openLocker_hallway02", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", "hallway02");
    openLocker.addGameObject(openlockertohallway02);

    //key to storage room
    CollectableObject storagekeyObject = new CollectableObject("storageKeyItem", 102*xs, 90*ys, 16*xs, 16*xs, true, storageKey);
    openLocker.addGameObject(storagekeyObject);



  //hallway02Door_fingerscanner
    Scene scannerPuzzle = new Scene("scannerPuzzle","TEMP_puzzlescanner.png");
    if(!debugSolvedPuzzles){
      MoveToSceneObject h1scannerPuzzle = new MoveToSceneObject("hallway01_scannerPuzzle", 215*xs, 90*ys, 16*xs, 16*xs, "zoom.png", "scannerPuzzle");
      hallway01.addGameObject(h1scannerPuzzle);
    }
    //back to hallway01
    MoveToSceneObject scannerPuzzleToHallway01 = new MoveToSceneObject("scanner_hallway01", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", true);
    scannerPuzzle.addGameObject(scannerPuzzleToHallway01);

  //controlRoom_Documents
    Scene documentPuzzle = new Scene("documentPuzzle","TEMP_documentPuzzle.png");

    MoveToSceneObject cRTodocumentPuzzle = new MoveToSceneObject("controlRoom_documentPuzzle", 240*xs, 140*ys, 16*xs, 16*xs, "zoom.png", "documentPuzzle");
    controlRoom.addGameObject(cRTodocumentPuzzle);

    //back to control room (BACK)
    MoveToSceneObject dPuzzleToControlRoom = new MoveToSceneObject("documentPuzzle_controlroom", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", true);
    documentPuzzle.addGameObject(dPuzzleToControlRoom);

    //TODO Code for document puzzle here

  //controlRoom_Computer
    Scene computerScreen = new Scene("computerScreen","TEMP_computerScreen.png");

    MoveToSceneObject cRToComputerScreen = new MoveToSceneObject("controlRoom_computerScreen", 135*xs, 50*ys, 16*xs, 16*xs, "zoom.png", "computerScreen");
    controlRoom.addGameObject(cRToComputerScreen);

    //back to control room
    MoveToSceneObject computerScreenToControlRoom = new MoveToSceneObject("computerScreen_controlroom", 156*xs, 160*ys, 16*xs, 16*xs, "arrowDown.png", true);
    computerScreen.addGameObject(computerScreenToControlRoom);
    //TODO button to unlock exit 
}

void draw()
{
  sceneManager.getCurrentScene().draw(width, height);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  inventoryManager.draw();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}
