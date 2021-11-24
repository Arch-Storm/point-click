int framerate = 60;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

public int xs;
public int ys;

//init puzzle solved variables
public boolean debugSolvedPuzzles = false;

public String mainFontFile = "TEMP_FiraSans.ttf";

public String[] cursorFiles = {"mainCursor", "interactableCursor", "upCursor", "downCursor", "rightCursor", "leftCursor"};
public HashMap<String, PImage> cursors = new HashMap<String, PImage>();

void settings() {
  //fullScreen(P2D);
  size(1600, 900, P2D);

  smooth(8);
}

void setup() {
  frameRate(framerate);

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
  
  //main menu 
  Scene menu = new Scene("menu", "menu.png");
  ButtonObject startButton = new ButtonObject("startButton", 3*xs, 135*ys, 32*xs, 22*ys, "Start", "hallway02", "interactableCursor");
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
  Scene storageRoom = new Scene("storageRoom", "storageRoom.jpg" );

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoomHallway02", 152*xs, 160*ys, 16*xs, 16*xs, "arrowUp.png", true, "upCursor");
  storageRoom.addGameObject(storageTohallway02);

  //TODO add knife to storage room
  Collectable knife = new Collectable("knife", "boxcutter.png");
  CollectableObject knifeObject = new CollectableObject("storageRoom", 80*xs, 36*ys, 16*xs, 16*xs, true, knife, "interactableCursor");
  storageRoom.addGameObject(knifeObject);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "barracks.jpg" );

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracksHallway01", 140*xs, 100*ys, 16*xs, 16*xs, "arrowUp.png", true, "upCursor");
  barracksRoom.addGameObject(barrackstohallway01);

  //arm
  Collectable arm = new Collectable("arm", "Hand1.png");
  CollectableObject armObject = new CollectableObject("barracksRoom", 85*xs, 135*ys, 48*xs, 48*xs, true, arm, "interactableCursor");
  barracksRoom.addGameObject(armObject);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "controlRoom.jpg");

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoomHallway01", 10*xs, 90*ys, 16*xs, 16*xs, "arrowUp.png", true, "upCursor");
  controlRoom.addGameObject(controltohallway01);


//hallway01
  Scene hallway01 = new Scene("hallway01", "hallway01.jpg" );

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01Hallway02", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01BarracksRoom", 72*xs, 44*ys, 48*xs, 80*ys, "barracksRoom", "leftCursor");
  hallway01.addGameObject(h1tobarracksRoom);

  //hallway01ExitKeypad
    Scene keypadPuzzle = new Scene("keypadPuzzle", "hallway01Closeup.jpg");

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

  //to Controlroom (needs check)
  if (debugSolvedPuzzles) {
    MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01ControlRoom", 220*xs, 90*ys, 16*xs, 16*xs, "arrowRight.png", "controlRoom", "rightCursor");
    hallway01.addGameObject(h1tocontrolRoom);
  } else {
    //TODO finger scanner puzzle
  }
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "hallway02.jpg");

  //to hallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02Hallway01", 136*xs, 46*ys, 48*xs, 52*xs, "hallway01", "upCursor");
  hallway02.addGameObject(h2ToHallway01);

  //toStorageRoom
  if (debugSolvedPuzzles) {
    MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02StorageRoom", 215*xs, 90*ys, 16*xs, 16*xs, "arrowRight.png", "storageRoom", "rightCursor");
    hallway02.addGameObject(h2ToStorageRoom);
  }
  else{
    //TODO storage key "puzzle"  (need key to open door) otherwise door will be closed.
  }
//hallway03 (exit)
  Scene hallway03 = new Scene("hallway03", "TEMP_ending.png");

  //to hallway 02
  MoveToSceneObject h3ToHallway02 = new MoveToSceneObject("hallway03Hallway02", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
  hallway03.addGameObject(h3ToHallway02);

//Ending scene
  Scene ending = new Scene("ending", "TEMP_ending.png");
  
/*----closeups-----*/

  //hallway02lockerKeycodes
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

  //hallway02openLocker
    Scene openLocker = new Scene("openLocker", "TEMP_openLocker.png");

    //back to hallway02
    MoveToSceneObject openlockertohallway02 = new MoveToSceneObject("openLockerHallway02", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    openLocker.addGameObject(openlockertohallway02);

    //key to storage room
    Collectable storageKey = new Collectable("storageKey", "key.png");
    CollectableObject storagekeyObject = new CollectableObject("openlocker", 80*xs, 36*ys, 16*xs, 16*xs, true, storageKey, "interactableCursor");
    openLocker.addGameObject(storagekeyObject);



  //hallway02DoorFingerscanner
    Scene scannerPuzzle = new Scene("scannerPuzzle","TEMP_puzzlescanner.png");
    if(!debugSolvedPuzzles){
      MoveToSceneObject h1scannerPuzzle = new MoveToSceneObject("hallway01ScannerPuzzle", 204*xs, 44*ys, 48*xs, 80*ys, "scannerPuzzle", "rightCursor");
      hallway01.addGameObject(h1scannerPuzzle);
    }
    //back to hallway01
    MoveToSceneObject scannerPuzzleToHallway01 = new MoveToSceneObject("scannerHallway01", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    scannerPuzzle.addGameObject(scannerPuzzleToHallway01);

  //controlRoomDocuments
    Scene documentPuzzle = new Scene("documentPuzzle","TEMP_documentPuzzle.png");

    MoveToSceneObject cRTodocumentPuzzle = new MoveToSceneObject("controlRoomDocumentPuzzle", 240*xs, 150*ys, 16*xs, 16*xs, "zoom.png", "documentPuzzle", "rightCursor");
    controlRoom.addGameObject(cRTodocumentPuzzle);

    //back to control room (BACK)
    MoveToSceneObject dPuzzleToControlRoom = new MoveToSceneObject("documentPuzzleControlroom", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
    documentPuzzle.addGameObject(dPuzzleToControlRoom);

    //TODO Code for document puzzle here

  //controlRoomComputer
    Scene computerScreen = new Scene("computerScreen","TEMP_computerScreen.png");

    MoveToSceneObject cRToComputerScreen = new MoveToSceneObject("controlRoomComputerScreen", 135*xs, 50*ys, 16*xs, 16*xs, "zoom.png", "computerScreen", "interactableCursor");
    controlRoom.addGameObject(cRToComputerScreen);

    //back to control room
    MoveToSceneObject computerScreenToControlRoom = new MoveToSceneObject("computerScreenControlroom", 64*xs, 150*ys, 192*xs, 42*ys, true, "downCursor");
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
  inventoryManager.mouseClicked();
}
