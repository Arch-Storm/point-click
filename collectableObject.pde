class CollectableObject extends GameObject { 
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  private boolean isDraggable;
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, isDraggable, collectable, null, hoverCursor);
  }
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable, GameObject replaceWith, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile(), hoverCursor);
    this.isDraggable = isDraggable;
    this.collectable = collectable;
    if(replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }
  
  @Override
  public void draw() {
    super.draw();
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if(willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);  
      }
    }
  }
}
