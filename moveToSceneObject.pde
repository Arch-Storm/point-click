class MoveToSceneObject extends GameObject {


/*
    BUG: if the curser is not moved between scenes the oldest moveToSceneObject is used.
*/
  
  private String nextSceneIdentifier;
  private boolean moveBack;
  private String moveSound;
  private Collectable requiredCollectable = null;
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", moveBack, hoverCursor);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.moveBack = moveBack;
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, hoverCursor, null);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, String hoverCursor, Collectable requiredCollectable) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, hoverCursor, requiredCollectable);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, String hoverCursor, Collectable requiredCollectable) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
    this.requiredCollectable = requiredCollectable;
  }

  public boolean contains(Collectable c) {
    if (c == null) return true;
    return inventoryManager.containsCollectable(c);
  }
  
  @Override
  public void mouseClicked() {
    if (mouseIsHovering) {
      if (contains(requiredCollectable)) {
        cursor(cursors.get("mainCursor"));
        if (moveBack) {
          sceneManager.goToPreviousScene();
        } else {
          try {
            sceneManager.goToScene(nextSceneIdentifier);
          } catch(Exception e) { 
            println(e.getMessage());
          }
        }
      } else {
        displayText.displayText("I still need the documents!", "Can't finish the job without them.");
      }
    }
  }
}
