class MoveToSceneObject extends GameObject {


/*
    BUG: if the curser is not moved between scenes the oldest moveToSceneObject is used.
*/
  
  private String nextSceneIdentifier;
  private boolean moveBack;
  private String moveSound;
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", moveBack, hoverCursor);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.moveBack = moveBack;
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, hoverCursor);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, hoverCursor);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      cursor(cursors.get("mainCursor"));
      if(moveBack) {
        sceneManager.goToPreviousScene();
      } else {
        try {
          sceneManager.goToScene(nextSceneIdentifier);
        } catch(Exception e) { 
          println(e.getMessage());
        }
      }
    }
  }
}
