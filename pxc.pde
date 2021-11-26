final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();
final AudioManager audioManager = new AudioManager(this);

public int xs;
public int ys;
int framerate = 60;

public String ticketingFontFile = "Ticketing.ttf";
public String britannicFontFile = "Britannic.ttf";
public PFont britannicFont;
public PFont ticketingFont;

public String[] cursorFiles = {"mainCursor", "interactableCursor", "upCursor", "downCursor", "rightCursor", "leftCursor"};
public HashMap<String, PImage> cursors = new HashMap<String, PImage>();

public boolean zoomed = false;

final DisplayText displayText = new DisplayText();
public boolean textDisplayed = false;

void settings() {
  fullScreen(P2D);
  //size(1920, 1080, P2D);

  smooth(8);
}

public void setup()
{
// Weird workarounds to make the Fonts display correctly after moving to P2D
  textMode(SHAPE);
  britannicFont = createFont(britannicFontFile, 12, true);
  ticketingFont = createFont(ticketingFontFile, 12, true);
  textFont(britannicFont);

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
  Scene storageRoom = new Scene("storageRoom", "storageRoom.png", "Let's hope it was worth", "finding the key...");

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoom_hallway02", 240*xs, 40*ys, 180*xs, 180*xs, true, "rightCursor");
  storageRoom.addGameObject(storageTohallway02);

  //knife 
  Collectable knife = new Collectable("knife", "boxcutter.png","boxcutter.png");
  CollectableObject knifeObject = new CollectableObject("knifeObject", 52*xs, 74*ys, 16*xs, 10*xs, true, knife, "grabKnife", "interactableCursor", "This could come in handy", "in the future...");
  storageRoom.addGameObject(knifeObject);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "barracks.png", "God, it smells awful in here!", "Did people really sleep in here?");

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracks_hallway01", 110*xs, 40*ys, 65*xs, 80*xs, true, "upCursor");
  barracksRoom.addGameObject(barrackstohallway01);
  
  //sticky note
  Collectable note = new Collectable("note", "note.png");
  CollectableObject noteObject = new CollectableObject("noteObject", 237*xs,45*xs,32*xs,32*xs, true, note,"", "interactableCursor", "A code?", "I should be able to use this somewhere.");
  barracksRoom.addGameObject(noteObject);

  //arm
  InteractableObject arm = new InteractableObject("arm", 85*xs, 135*ys, 48*xs, 40*xs, "Hand1.png", "knife", "mainCursor", "Why would I touch this?!", "I'm not going near this!");
  barracksRoom.addGameObject(arm);

  //cut arm
  Collectable finger = new Collectable("finger", "Hand2.png", "finger.png");
  GameObject armNoFinger = new GameObject("armNoFinger", 85*xs, 135*ys, 48*xs, 40*xs, "Hand3.png", "mainCursor");
  CollectableObject fingerObject = new CollectableObject("fingerObject", 85*xs, 135*ys, 48*xs, 40*xs, true, finger, armNoFinger, "grabFinger", "interactableCursor", "I don't want to take this", "but i guess I'll have to...");
  barracksRoom.addHiddenObject(fingerObject);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "controlRoom.png", "Jesus, whats this... a body?!", "Must have been rotting here for years.");

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoomHallway01", 0, 8*ys, 70*xs, 96*ys, true, "upCursor");
  controlRoom.addGameObject(controltohallway01);

  //to computer
  MoveToSceneObject cRToComputerScreen = new MoveToSceneObject("controlRoomComputerScreen", 205*xs, 55*ys, 40*xs, 30*ys, "computerScreen", "interactableCursor");
  controlRoom.addGameObject(cRToComputerScreen);

  //docs
  Collectable docs = new Collectable("docs", "docs.png", "docs.png");
  CollectableObject docsObject = new CollectableObject("docsObject", 263*xs, 113*ys, 30*xs, 15*ys, true, docs, "grabDocs", "interactableCursor", "Ok, these are the real deal.", "The intel was correct then...");
  controlRoom.addGameObject(docsObject);

  //body
  Collectable keyCard = new Collectable("keyCard", "", "keyCard.png");
  CollectableObject keyCardObject = new CollectableObject("keyCardObject", 0, 140*ys, 40*xs, 40*ys, true, keyCard, "grabKnife", "interactableCursor", "A Keycard!", "This has to be useful!");
  controlRoom.addGameObject(keyCardObject);

//hallway01
  Scene hallway01 = new Scene("hallway01", "hallway01.png", "What have I gotten myself into...", "This is ridiculous.");

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01Hallway02", 6*xs, 160*ys, 16*xs, 16*xs, "downCursor-4x.png", true, "interactableCursor");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01BarracksRoom", 72*xs, 44*ys, 48*xs, 80*ys, "barracksRoom", "leftCursor");
  hallway01.addGameObject(h1tobarracksRoom);

  //hallway01_exit_keypad
    Scene keypadPuzzle = new Scene("keypadPuzzle", "keypadBackground.png", "Guess I'll have to find a code", "to get out of here.");

    //hallway01 to keypadPuzzle
    MoveToSceneObject h1keypadPuzzle = new MoveToSceneObject("hallway01KeypadPuzzle", 148*xs, 52*ys, 32*xs, 44*ys, "keypadPuzzle", "upCursor");
    hallway01.addGameObject(h1keypadPuzzle);

    //keypad puzzle
    String correctKeypadCode = "374";
    KeypadPuzzleObject keypadPuzzleObject = new KeypadPuzzleObject("keypadPuzzleObject", 103*xs, 10*ys, 120*xs, 168*ys, correctKeypadCode, "lock.png", "lockCorrect.png", "lockWrong.png", "mainCursor");
    keypadPuzzle.addGameObject(keypadPuzzleObject);

    //back to hallway01
    MoveToSceneObject keypadPuzzleToH1 = new MoveToSceneObject("keypadPuzzleHallway01", 6*xs, 160*ys, 16*xs, 16*xs, "downCursor-4x.png", true, "interactableCursor");
    keypadPuzzle.addGameObject(keypadPuzzleToH1);

  //to Controlroom
  MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01ControlRoom", 200*xs, 30*ys, 48*xs, 80*xs, "controlRoom", "rightCursor");
  hallway01.addHiddenObject(h1tocontrolRoom);

  //to ending
  MoveToSceneObject h1toEnding = new MoveToSceneObject("h1toEnding", 148*xs, 52*ys, 32*xs, 44*ys, "ending", "upCursor", docs);
  hallway01.addHiddenObject(h1toEnding);
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "hallway02.png", "Let's get this over with quick.", "Don't wanna stay in here for long.");

  //to hallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02Hallway01", 136*xs, 46*ys, 48*xs, 52*xs, "hallway01", "upCursor");
  hallway02.addGameObject(h2ToHallway01);

  //doorlock
  InteractableObject doorLock = new InteractableObject("doorLock", 200*xs, 30*ys, 48*xs, 80*xs, "", "storageKeyObject", "interactableCursor", "The door is locked...", "Maybe I can find a key somewhere.");
  hallway02.addGameObject(doorLock);

//Ending scene
  Scene ending = new Scene("ending", "endscreen.png");
  
/*----closeups-----*/

  //hallway02locker_keycodes
    Scene lockerPuzzle = new Scene("lockerPuzzle", "lockerBackground.png");

    //locker puzzle code 
    String correctLockerCode = "053";
    LockerPuzzleObject lockerPuzzleObject = new LockerPuzzleObject("hallway02LockerPuzzleObject", 100*xs, 20*ys, 120*xs, 120*ys, "locker.png", correctLockerCode, "mainCursor");
    lockerPuzzle.addGameObject(lockerPuzzleObject);

    //back to hallway02
    MoveToSceneObject lockerpuzzletohallway02 = new MoveToSceneObject("lockerPuzzleHallway02", 6*xs, 160*ys, 16*xs, 16*xs, "downCursor-4x.png", true, "interactableCursor");
    lockerPuzzle.addGameObject(lockerpuzzletohallway02);

    //only to change the cursor
    GameObject cursorChanger = new GameObject("cursorChanger", 115*xs, 20*ys, 90*xs, 44*ys, "interactableCursor");
    lockerPuzzle.addGameObject(cursorChanger);

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
    Collectable storageKey = new Collectable("storageKeyObject", "keyInLocker.png","key.png");
    CollectableObject storagekeyObject = new CollectableObject("StorageKeyObject", 96*xs + 1, 96*ys, 16*xs, 6*xs, true, storageKey, "grabKey", "interactableCursor", "Perfect!", "I can get one of the doors open with this.");
    openLocker.addGameObject(storagekeyObject);

    //toStorageRoom
    MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02StorageRoom", 200*xs, 30*ys, 48*xs, 80*xs, "storageRoom", "rightCursor");
    openLocker.addHiddenObject(h2ToStorageRoom);

    //doorlock
    InteractableObject doorLock2 = new InteractableObject("doorLock2", 200*xs, 30*ys, 48*xs, 80*xs, "storageKeyObject", "interactableCursor", "The door is locked...", "Maybe I can find a key somewhere.");
    openLocker.addGameObject(doorLock2);

  //hallway02DoorFingerscanner
    Scene scannerPuzzle = new Scene("scannerPuzzle","fingerscannerBackground.png");
    MoveToSceneObject h1scannerPuzzle = new MoveToSceneObject("hallway01ScannerPuzzle", 204*xs, 44*ys, 48*xs, 80*ys, "scannerPuzzle", "rightCursor");
    hallway01.addGameObject(h1scannerPuzzle);
    //back to hallway01
    MoveToSceneObject scannerPuzzleToHallway01 = new MoveToSceneObject("scannerHallway01", 6*xs, 160*ys, 16*xs, 16*xs, "downCursor-4x.png", true, "interactableCursor");
    scannerPuzzle.addGameObject(scannerPuzzleToHallway01);

    //fingerprint scanner puzzle
    InteractableObject scanner = new InteractableObject("scanner", 103*xs, 10*ys, 120*xs, 168*ys, "keypadOff.png", "finger", "mainCursor", "", "");
    scannerPuzzle.addGameObject(scanner);

  //controlRoomComputer
    Scene computerScreen = new Scene("computerScreen","computerOff.png");

    //cardscanner
    InteractableObject cardScanner = new InteractableObject("cardScanner", 110*xs, 145*ys, 100*xs, 45*ys, "keyCard", "mainCursor", "", "");
    computerScreen.addGameObject(cardScanner);

    //back to control room
    MoveToSceneObject computerScreenToControlRoom = new MoveToSceneObject("computerScreenControlroom", 6*xs, 160*ys, 16*xs, 16*xs, "downCursor-4x.png", true, "interactableCursor");
    computerScreen.addGameObject(computerScreenToControlRoom);

    //computer start and computer on
    GameObject computerOn = new GameObject("computerOn", 0, 0, 320*xs, 180*ys, "computerOn.png", "mainCursor");
    GameObject computerStarting = new GameObject("computerStarting", 0, 0, 320*xs, 180*ys, "computerStarting.png", "mainCursor");
    computerScreen.addHiddenObject(computerOn);
    computerScreen.addHiddenObject(computerStarting);

//Last setup functions

    displayText.load();

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

  if (textDisplayed) displayText.drawText();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  if (!zoomed) sceneManager.getCurrentScene().mouseClicked();
  inventoryManager.mouseClicked();
}

void mousePressed() {
  if (!zoomed) inventoryManager.mousePressed();
}

void mouseDragged() {
  if (!zoomed) inventoryManager.mouseDragged();
}

void mouseReleased() {
  if (!zoomed) inventoryManager.mouseReleased();
}