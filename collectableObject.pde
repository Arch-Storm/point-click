class CollectableObject extends GameObject { 
  private Collectable requiredCollectable;
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  private boolean isDraggable;
  private String collectionSound;
  private String text1;
  private String text2;
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable, String collectionSound, String hoverCursor, String text1, String text2) {
    this(identifier, x, y, owidth, oheight, isDraggable, collectable, null, collectionSound, hoverCursor, text1, text2);
  }
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable, GameObject replaceWith, String collectionSound, String hoverCursor, String text1, String text2) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile(), hoverCursor);
    this.isDraggable = isDraggable;
    this.collectable = collectable;
    this.collectionSound = collectionSound;
    this.text1 = text1;
    this.text2 = text2;
    if(replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, boolean isDraggable, Collectable collectable,Collectable requiredCollectable, GameObject replaceWith, String text1, String text2) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    this.isDraggable = isDraggable;
    this.collectable = collectable;
    this.requiredCollectable = requiredCollectable;
    this.text1 = text1;
    this.text2 = text2;
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
      if (!textDisplayed) displayText.displayText(text1, text2);
      audioManager.playOnce(collectionSound);
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if(willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);  
      }
    }
  }
}
