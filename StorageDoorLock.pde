class StorageDoorLock extends GameObject {
MoveToSceneObject h2ToStorageRoom = new MoveToSceneObject("hallway02_StorageRoom", 215*xs, 90*ys, 16*xs, 16*xs, "arrowRight.png", "storageRoom");

/*
    BUG: if the curser is not moved between scenes the oldest StorageDoorLock is used.
*/
  
  private String nextSceneIdentifier;
  private boolean moveBack;
  private Collectable collectable;
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, boolean moveBack) {
    this(identifier, x, y, owidth, oheight, "", moveBack);
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.moveBack = moveBack;
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, Collectable collectable) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, collectable);
  }
  
  public StorageDoorLock(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, Collectable collectable) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
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
          sceneManager.scenes.get("hallway02").addGameObject(h2ToStorageRoom); // add movetosceneobject from hallway02 to openlocker 
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
