class CollectableObject extends GameObject { 
  private Collectable requiredCollectable;
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
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable,Collectable requiredCollectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    this.isDraggable = isDraggable;
    this.collectable = collectable;
    this.requiredCollectable = requiredCollectable;
    if(inventoryManager.containsCollectable(this.requiredCollectable)){
      if(replaceWith != null) {
        this.replaceWith = replaceWith;
        this.willReplaceByAnotherGameObject = true;
       } else {
        this.willReplaceByAnotherGameObject = false;
      }
    }
    
  }
  
  @Override
  public void draw() {
    super.draw();
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      cursor(cursors.get("mainCursor"));
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if(willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);  
      }
    }
  }
}
