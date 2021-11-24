class StorageDoorLock extends GameObject {
MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02_StorageRoom", 200*xs, 30*ys, 48*xs, 80*xs, "storageRoom", "rightCursor");

/*
    BUG: if the curser is not moved between scenes the oldest StorageDoorLock is used.
*/
  
  private String nextSceneIdentifier;
  private boolean moveBack;
  private Collectable collectable;


  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, boolean moveBack, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", moveBack, hoverCursor);
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.moveBack = moveBack;
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, String hoverCursor, Collectable collectable) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, hoverCursor, collectable);
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, String hoverCursor, Collectable collectable) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
    this.collectable = collectable;
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      if(moveBack) {
        sceneManager.goToPreviousScene();
      } else {
        if(inventoryManager.containsCollectable(this.collectable)){
          storageRoomUnlocked = true;
          inventoryManager.removeCollectable(this.collectable);
          sceneManager.scenes.get("hallway02").removeGameObject(this); // remove storagedoorlock
          sceneManager.scenes.get("hallway02").addGameObject(h2ToStorageRoom); // add StorageDoorLock from hallway02 to openlocker 
          try {
          sceneManager.goToScene(nextSceneIdentifier);
          } catch(Exception e) { 
          println(e.getMessage());
        }
        }
      }
    }
  }
}
