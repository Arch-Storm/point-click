int framerate = 60;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();
final AudioManager audioManager = new AudioManager(this);

public int xs;
public int ys;

//init puzzle solved variables
public boolean debugSolvedPuzzles = false;
public boolean storageRoomUnlocked = false;

public String mainFontFile = "TEMP_FiraSans.ttf";

public String[] cursorFiles = {"mainCursor", "interactableCursor", "upCursor", "downCursor", "rightCursor", "leftCursor"};
public HashMap<String, PImage> cursors = new HashMap<String, PImage>();

//scuffed but otherwise processing won't be able to use the collectables at all
//public Collectable knife = new Collectable("knife", "knife.png", "knife.png");
public Collectable storageKey = new Collectable("storageKeyObject", "key.png","key.png");

void settings() {
  //fullScreen(P2D);
  size(1600, 900, P2D);

  smooth(8);
}

public void setup()
{
  // Weird workarounds to make the Fonts display correctly after moving to P2D
  textMode(SHAPE);
  PFont mainFont = createFont(mainFontFile, 12, true);
  textFont(mainFont);

  // dynamic units
  xs = width / 320;
  ys = height / 180;

  // load cursors
  for (String file : cursorFiles) {
    PImage img = loadImage(file + ".png");
    cursors.put(file, img);
  }

  //Start AudioManager
  audioManager.loadSounds();
  
  //main menu 
  Scene menu = new Scene("menu", "menu.png");
  ButtonObject startButton = new ButtonObject("startButton", 3*xs, 135*ys, 32*xs, 22*ys, "Start", "hallway02", "interactableCursor"); //hallway02
  ButtonObject optionsButton = new ButtonObject("optionsButton", 3*xs, 150*ys, 32*xs, 22*ys, "Options", "options", "interactableCursor");
  ButtonObject exitButton = new ButtonObject("exitButton", 3*xs, 165*ys, 32*xs, 22*ys, "Exit", "exit", "interactableCursor");
  menu.addGameObject(startButton);
  menu.addGameObject(optionsButton);
  menu.addGameObject(exitButton);

  //options
  Scene options = new Scene("options", "menu.png");
  ButtonObject backButton = new ButtonObject("backButton", 3*xs, 165*ys, 32*xs, 22*ys, "Back", "menu", "interactableCursor");
  options.addGameObject(backButton);
  

/*------Scenes & room navigation-------*/

//storageRoom
  Scene storageRoom = new Scene("storageRoom", "storageRoom.png" );

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoom_hallway02", 240*xs, 40*ys, 180*xs, 180*xs, true, "rightCursor");
  storageRoom.addGameObject(storageTohallway02);

  //TODO add knife to storage room
  Collectable knife = new Collectable("knife", "boxcutter.png","boxcutter.png");
  CollectableObject knifeObject = new CollectableObject("knifeObject", 65*xs, 65*ys, 16*xs, 16*xs, true, knife, "grabKnife", "interactableCursor");
  storageRoom.addGameObject(knifeObject);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "barracks.png");

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracks_hallway01", 110*xs, 40*ys, 65*xs, 80*xs, true, "upCursor");
  barracksRoom.addGameObject(barrackstohallway01);

  //arm
  InteractableObject arm = new InteractableObject("arm", 85*xs, 135*ys, 48*xs, 48*xs, "Hand1.png", "knife", "mainCursor");
  barracksRoom.addGameObject(arm);

  //cut arm
  Collectable finger = new Collectable("finger", "Hand2.png", "Finger.png");
  GameObject armNoFinger = new GameObject("armNoFinger", 85*xs, 135*ys, 48*xs, 48*xs, "Hand3.png", "mainCursor");
  CollectableObject fingerObject = new CollectableObject("fingerObject", 85*xs, 135*ys, 48*xs, 48*xs, true, finger, armNoFinger, "", "interactableCursor");
  barracksRoom.addHiddenObject(fingerObject);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "controlRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoom_hallway01", 0, 8*ys, 70*xs, 96*xs, "hallway01" , "upCursor");
  controlRoom.addGameObject(controltohallway01);


//hallway01
  Scene hallway01 = new Scene("hallway01", "hallway01.png" );

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01_hallway02", 64*xs, 150*ys, 192*xs, 42*ys,"hallway02", "downCursor");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01BarracksRoom", 72*xs, 44*ys, 48*xs, 80*ys, "barracksRoom", "leftCursor");
  hallway01.addGameObject(h1tobarracksRoom);

  //hallway01_exit_keypad
    Scene keypadPuzzle = new Scene("keypadPuzzle", "hallway01_closeup.png");

    //hallway01 to keypadPuzzle
    MoveToSceneObject h1keypadPuzzle = new MoveToSceneObject("hallway01KeypadPuzzle", 148*xs, 52*ys, 32*xs, 44*ys, "keypadPuzzle", "upCursor");
    hallway01.addGameObject(h1keypadPuzzle);

    //keypad puzzle
    String correctKeypadCode = "111";
    KeypadPuzzleObject keypadPuzzleObject = new KeypadPuzzleObject("hallway03KeypadPuzzleObject", 103*xs, 10*ys, 120*xs, 168*ys, correctKeypadCode, "lockWrong.png", "mainCursor");
    keypadPuzzle.addGameObject(keypadPuzzleObject);

    //back to hallway01
    MoveToSceneObject keypadPuzzleToH1 = new MoveToSceneObject("keypadPuzzleHallway01", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    keypadPuzzle.addGameObject(keypadPuzzleToH1);

  //to Controlroom
  MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01ControlRoom", 200*xs, 30*ys, 48*xs, 80*xs, "controlRoom", "rightCursor");
  hallway01.addHiddenObject(h1tocontrolRoom);
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "hallway02.png");

  //to hallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02Hallway01", 136*xs, 46*ys, 48*xs, 52*xs, "hallway01", "upCursor");
  hallway02.addGameObject(h2ToHallway01);

  //doorlock
  InteractableObject doorLock = new InteractableObject("doorLock", 200*xs, 30*ys, 48*xs, 80*xs, "", "storageKeyObject", "interactableCursor");
  hallway02.addGameObject(doorLock);


//hallway03 (exit)
  Scene hallway03 = new Scene("hallway03", "TEMP_ending.png");

  //to hallway 02
  MoveToSceneObject h3ToHallway02 = new MoveToSceneObject("hallway03Hallway02", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
  hallway03.addGameObject(h3ToHallway02);

//Ending scene
  Scene ending = new Scene("ending", "TEMP_ending.png");
  
/*----closeups-----*/

  //hallway02locker_keycodes
    Scene lockerPuzzle = new Scene("lockerPuzzle", "TEMP_puzzleLocker.png");

    //back to hallway02
    MoveToSceneObject lockerpuzzletohallway02 = new MoveToSceneObject("lockerPuzzleHallway02", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    lockerPuzzle.addGameObject(lockerpuzzletohallway02);

    //locker puzzle code 
    String correctLockerCode = "123";
    LockerPuzzleObject lockerPuzzleObject = new LockerPuzzleObject("hallway02LockerPuzzleObject", 152*xs, 130*ys, 160*xs, 90*ys, correctLockerCode, "mainCursor");
    lockerPuzzle.addGameObject(lockerPuzzleObject);

    //to locker puzzle
    MoveToSceneObject h2LockerPuzzle = new MoveToSceneObject("hallway02LockerPuzzle", 102*xs, 70*ys, 16*xs, 48*ys, "lockerPuzzle", "interactableCursor");

    //to open locker
    MoveToSceneObject h2OpenLocker = new MoveToSceneObject("hallway02OpenLocker", 102*xs, 70*ys, 16*xs, 48*ys, "openLocker", "interactableCursor");
    hallway02.addHiddenObject(h2OpenLocker);

    //Locker
    hallway02.addGameObject(h2LockerPuzzle);

  //hallway02open_locker
    Scene openLocker = new Scene("openLocker", "hallway02_lockerOpen.png");

    //to hallway01
    MoveToSceneObject openlockertohallway01 = new MoveToSceneObject("openLockerHallway01", 136*xs, 46*ys, 48*xs, 52*xs, "hallway01", "upCursor");
    openLocker.addGameObject(openlockertohallway01);

    //key to storage room
    CollectableObject storagekeyObject = new CollectableObject("StorageKeyObject", 102*xs, 90*ys, 16*xs, 16*xs, true, storageKey, "grabKey", "interactableCursor");
    openLocker.addGameObject(storagekeyObject);

    //toStorageRoom
    MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02StorageRoom", 200*xs, 30*ys, 48*xs, 80*xs, "storageRoom", "rightCursor");
    openLocker.addHiddenObject(h2ToStorageRoom);

    //doorlock
    InteractableObject doorLock2 = new InteractableObject("doorLock2", 200*xs, 30*ys, 48*xs, 80*xs, "storageKeyObject", "interactableCursor");
    openLocker.addGameObject(doorLock2);

  //hallway02DoorFingerscanner
    Scene scannerPuzzle = new Scene("scannerPuzzle","hallway01_closeup_fingerscanner.png");
    if(!debugSolvedPuzzles){
      MoveToSceneObject h1scannerPuzzle = new MoveToSceneObject("hallway01_scannerPuzzle", 204*xs, 44*ys, 48*xs, 80*ys, "scannerPuzzle", "interactableCursor");
      hallway01.addGameObject(h1scannerPuzzle);
    }
    //back to hallway01
    MoveToSceneObject scannerPuzzleToHallway01 = new MoveToSceneObject("scannerHallway01", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    scannerPuzzle.addGameObject(scannerPuzzleToHallway01);

    //fingerprint scanner puzzle
    InteractableObject scanner = new InteractableObject("scanner", 103*xs, 10*ys, 120*xs, 168*ys, "keypadOn.png", "finger", "mainCursor");
    scannerPuzzle.addGameObject(scanner);

  //controlRoomDocuments
    Scene documentPuzzle = new Scene("documentPuzzle","TEMP_documentPuzzle.png");

    MoveToSceneObject cRTodocumentPuzzle = new MoveToSceneObject("controlRoom_documentPuzzle", 265*xs, 105*ys, 25*xs, 25*xs, "docs.png", "documentPuzzle", "interactableCursor");
    controlRoom.addGameObject(cRTodocumentPuzzle);

    //back to control room (BACK)
    MoveToSceneObject dPuzzleToControlRoom = new MoveToSceneObject("documentPuzzleControlroom", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    documentPuzzle.addGameObject(dPuzzleToControlRoom);

    //TODO Code for document puzzle here

  //controlRoomComputer
    Scene computerScreen = new Scene("computerScreen","TEMP_computerScreen.png");

    MoveToSceneObject cRToComputerScreen = new MoveToSceneObject("controlRoom_computerScreen", 205*xs, 55*ys, 35*xs, 30*xs, "computerScreen", "interactableCursor");
    controlRoom.addGameObject(cRToComputerScreen);

    //back to control room
    MoveToSceneObject computerScreenToControlRoom = new MoveToSceneObject("computerScreenControlroom", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    computerScreen.addGameObject(computerScreenToControlRoom);
    //TODO button to unlock exit 

    inventoryManager.setValues();

    // Apparently it's better to have the frameRate method last in setup
    frameRate(framerate);
}

void draw()
{
  sceneManager.getCurrentScene().draw(width, height);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  inventoryManager.draw();

  //random Ambience sounds
  audioManager.randomAmbience();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}

void mousePressed() {
  inventoryManager.mousePressed();
}

void mouseDragged() {
  inventoryManager.mouseDragged();
}

void mouseReleased() {
  inventoryManager.mouseReleased();
}