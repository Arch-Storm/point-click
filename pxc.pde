int framerate = 60;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

public int xs;
public int ys;

void settings()
{
  fullScreen();
  //size(1920, 1080);
}

void setup()
{
  frameRate(framerate);

  xs = width / 320; // dynamic units
  ys = height / 180;

  //init puzzle solved variables
  boolean debugSolvedPuzzles = true;
  boolean scannerIsSolved = debugSolvedPuzzles;
  boolean storageLockIsSolved = debugSolvedPuzzles;
  boolean lockerLockIsSolved = debugSolvedPuzzles;
  
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
  Scene storageRoom = new Scene("storageRoom", "TEMP_storageRoom.png" );

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoom_hallway02", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
  storageRoom.addGameObject(storageTohallway02);

  //TODO add knife to storage room
  Collectable knife = new Collectable("knife", "TEMP_knife.png");
  CollectableObject knifeObject = new CollectableObject("storage_room", 80*xs, 36*ys, 16*xs, 16*xs, true, knife);
  storageRoom.addGameObject(knifeObject);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "TEMP_barracksRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracks_hallway01", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
  barracksRoom.addGameObject(barrackstohallway01);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "TEMP_controlRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoom_hallway01", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", "hallway01");
  controlRoom.addGameObject(controltohallway01);


//hallway01
  Scene hallway01 = new Scene("hallway01", "TEMP_hallway01.png" );

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01_hallway02", 160*xs, 90*ys, 8*xs, 8*xs, "arrowUp.png", "hallway02");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01_barracksRoom", 130*xs, 90*ys, 8*xs, 8*xs, "arrowLeft.png", "barracksRoom");
  hallway01.addGameObject(h1tobarracksRoom);

  //to Controlroom (needs check)
  if(scannerIsSolved || debugSolvedPuzzles){
    MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01_controlRoom", 190*xs, 90*ys, 8*xs, 8*xs, "arrowRight.png", "controlRoom");
    hallway01.addGameObject(h1tocontrolRoom);
  }
  else{
    //TODO finger scanner puzzle
  }
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "TEMP_hallway02.png");

  //to hallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02_hallway01", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", "hallway01");
  hallway02.addGameObject(h2ToHallway01);

  //to hallway03
  MoveToSceneObject h2ToHallway03 = new MoveToSceneObject("hallway02_hallway03", 160*xs, 70*ys, 8*xs, 8*xs, "arrowUp.png", "hallway03");
  hallway02.addGameObject(h2ToHallway03);

  //toStorageRoom
  if(storageLockIsSolved || debugSolvedPuzzles){
    MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02_StorageRoom", 215*xs, 90*ys, 8*xs, 8*xs, "arrowRight.png", "storageRoom");
    hallway02.addGameObject(h2ToStorageRoom);
  }
  else{
    //TODO storage key "puzzle"  (need key to open door) otherwise door will be closed.
  }
//hallway03 (exit)
  Scene hallway03 = new Scene("hallway03", "TEMP_hallway03.png");

  //to hallway 02
  MoveToSceneObject h3ToHallway02 = new MoveToSceneObject("hallway03_hallway02", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", "hallway02");
  hallway03.addGameObject(h3ToHallway02);
  
/*----closeups-----*/

  //hallway02locker_keycodes
    Scene lockerPuzzle = new Scene("lockerPuzzle", "TEMP_puzzleLocker.png");

    //back to hallway02
    MoveToSceneObject lockerpuzzletohallway02 = new MoveToSceneObject("controlRoom_hallway02", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
    lockerPuzzle.addGameObject(lockerpuzzletohallway02);

    //TODO locker puzzle code 

    //if player has NOT solved locker puzzle
    if(!lockerLockIsSolved || !debugSolvedPuzzles){
      MoveToSceneObject h2LockerPuzzle = new MoveToSceneObject("hallway02_lockerPuzzle", 130*xs, 90*ys, 8*xs, 8*xs, "zoom.png", "lockerPuzzle");
      hallway02.addGameObject(h2LockerPuzzle);
      h2LockerPuzzle.setHoverImage("zoomIn.png");
    }
  //hallway02Door_fingerscanner
    Scene scannerPuzzle = new Scene("scannerPuzzle","TEMP_puzzlescanner.png");
    if(!scannerIsSolved){
      MoveToSceneObject h1scannerPuzzle = new MoveToSceneObject("hallway01_scannerPuzzle", 190*xs, 90*ys, 8*xs, 8*xs, "zoom.png", "scannerPuzzle");
      hallway01.addGameObject(h1scannerPuzzle);
    }
    //back to hallway01
    MoveToSceneObject scannerPuzzleToHallway01 = new MoveToSceneObject("scanner_hallway01", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
    scannerPuzzle.addGameObject(scannerPuzzleToHallway01);

  //controlRoom_Documents
    Scene documentPuzzle = new Scene("documentPuzzle","TEMP_documentPuzzle.png");

    MoveToSceneObject cRTodocumentPuzzle = new MoveToSceneObject("controlRoom_documentPuzzle", 190*xs, 90*ys, 8*xs, 8*xs, "zoom.png", "documentPuzzle");
    controlRoom.addGameObject(cRTodocumentPuzzle);

    //back to control room (BACK)
    MoveToSceneObject dPuzzleToControlRoom = new MoveToSceneObject("documentPuzzle_controlroom", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
    documentPuzzle.addGameObject(dPuzzleToControlRoom);

    //TODO Code for document puzzle here

  //controlRoom_Computer
    Scene computerScreen = new Scene("computerScreen","TEMP_computerScreen.png");

    MoveToSceneObject cRToComputerScreen = new MoveToSceneObject("controlRoom_computerScreen", 130*xs, 90*ys, 8*xs, 8*xs, "zoom.png", "computerScreen");
    controlRoom.addGameObject(cRToComputerScreen);

    //back to control room
    MoveToSceneObject computerScreenToControlRoom = new MoveToSceneObject("computerScreen_controlroom", 160*xs, 160*ys, 8*xs, 8*xs, "arrowDown.png", true);
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
