int framerate = 60;
boolean debugSolvedPuzzles = false;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  fullScreen();
}

void setup()
{

  //sets screensize & framerate
  float xMid = width / 2;
  float yMid = height / 2;
  frameRate(framerate);
  
  //main menu
  Scene menu = new Scene("menu", "menu.jpg");
  ButtonObject startButton = new ButtonObject("startButton", 50, (int)(yMid * 1.6), 200, 64, "Start", "hallway01");
  ButtonObject optionsButton = new ButtonObject("optionsButton", 50, (int)(yMid * 1.6 + 85), 200, 64, "Options", "options");
  ButtonObject exitButton = new ButtonObject("exitButton", 50, (int)(yMid * 1.6 + 170), 200, 64, "Exit", "exit");
  menu.addGameObject(startButton);
  menu.addGameObject(optionsButton);
  menu.addGameObject(exitButton);
  
  //options
  Scene options = new Scene("options", "menu.jpg");
  ButtonObject backButton = new ButtonObject("backButton", 50, (int)(yMid * 1.6 + 170), 200, 64, "Back", "menu");
  options.addGameObject(backButton);
  
  //init puzzle solved variables
  boolean fingerScannerIsSolved = false;
  boolean storageLockIsSolved = false;
  boolean lockerLockIsSolved = false;


//Scenes & room navigation
//storageRoom
  Scene storageRoom = new Scene("storageRoom", "TEMP_storageRoom.png" );

  //to hallway02 (back)
  MoveToSceneObject storageTohallway02 = new MoveToSceneObject("storageRoom_hallway02", int(xMid), int(yMid) + 300, 100, 100, "arrowDown.png", true);
  storageRoom.addGameObject(storageTohallway02);


//barracksRoom
  Scene barracksRoom = new Scene("barracksRoom", "TEMP_barracksRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject barrackstohallway01 = new MoveToSceneObject("barracks_hallway01", int(xMid), int(yMid) + 300, 100, 100, "arrowDown.png", true);
  barracksRoom.addGameObject(barrackstohallway01);

//controlroom
  Scene controlRoom = new Scene("controlRoom", "TEMP_controlRoom.png" );

  //to hallway01 (back)
  MoveToSceneObject controltohallway01 = new MoveToSceneObject("controlRoom_hallway01", int(xMid), int(yMid) + 300, 100, 100, "arrowDown.png", true);
  controlRoom.addGameObject(controltohallway01);


//hallway01
  Scene hallway01 = new Scene("hallway01", "TEMP_hallway01.png" );

  //to hallway02
  MoveToSceneObject h1ToHallway02 = new MoveToSceneObject("hallway01_hallway02", int(xMid), 0, 100, 100, "arrowUp.png", "hallway02");
  hallway01.addGameObject(h1ToHallway02);

  //to barracksRoom
  MoveToSceneObject h1tobarracksRoom = new MoveToSceneObject("hallway01_barracksRoom", int(xMid) - 300, int(yMid), 100, 100, "arrowLeft.png", "barracksRoom");
    hallway01.addGameObject(h1tobarracksRoom);

  //to Controlroom (needs check)
  if(fingerScannerIsSolved || debugSolvedPuzzles){
    MoveToSceneObject h1tocontrolRoom = new MoveToSceneObject("hallway01_controlRoom", int(xMid) + 300, int(yMid), 100, 100, "arrowRight.png", "controlRoom");
    hallway01.addGameObject(h1tocontrolRoom);
  }
  else{
    // finger scanner puzzle
  }
  

//hallway02 
  Scene hallway02 = new Scene("hallway02", "TEMP_hallway02.png");

  //toHallway01
  MoveToSceneObject h2ToHallway01 = new MoveToSceneObject("hallway02_hallway01", int(xMid), int(yMid) + 300, 100, 100, "arrowDown.png", "hallway01");
  hallway02.addGameObject(h2ToHallway01);

  //toStorageRoom
  if(storageLockIsSolved || debugSolvedPuzzles){
    MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02_StorageRoom", int(xMid) + 300, int(yMid), 100, 100, "arrowRight.png", "storageRoom");
    hallway02.addGameObject(h2ToStorageRoom);
  }
  else{
    // storage key puzzle 
  }
  
//closeups
  //hallway02locker_keycodes
    Scene lockerPuzzle = new Scene("lockerPuzzle", "TEMP_puzzleLocker.png");

    //to hallway01 (back)
    MoveToSceneObject lockerpuzzletohallway01 = new MoveToSceneObject("controlRoom_hallway01", int(xMid), int(yMid) + 300, 100, 100, "arrowDown.png", true);
    lockerPuzzle.addGameObject(lockerpuzzletohallway01);

    //locker puzzle code here

    //if player has solved locker puzzle
    if(!lockerLockIsSolved || !debugSolvedPuzzles){
      MoveToSceneObject h2LockerPuzzle = new MoveToSceneObject("hallway02_lockerPuzzle", int(xMid) - 300, int(yMid), 100, 100, "zoom.png", "lockerPuzzle");
      hallway02.addGameObject(h2LockerPuzzle);
      h2LockerPuzzle.setHoverImage("zoomIn.png");
    }
  //hallway02Door_FingerScanner
  //storageRoom_knife
  //barracksRoom_Bed
  //controlRoom_Documents
  //controlRoom_Computer
  
  
  /*   DEPRICATED (i slapped the sense into scenemanager)
  
  //stuff to help scenemanager not have an aneurysm 
  sceneManager.addScene(menu);
  sceneManager.addScene(options);
  sceneManager.addScene(storageRoom);
  sceneManager.addScene(barracksRoom);
  sceneManager.addScene(controlRoom);
  sceneManager.addScene(hallway01);
  sceneManager.addScene(hallway02);
  
  sceneManager.addScene(lockerPuzzle);
  */
}

void draw()
{
  sceneManager.getCurrentScene().draw(width, height);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}
