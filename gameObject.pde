class GameObject {
  protected int x;
  protected int y;
  protected int owidth;
  protected int oheight;
  private String identifier;
  private boolean isDraggable;
  private boolean hasImage;
  private boolean hasHoverImage;
  private PImage gameObjectImage;
  private PImage gameObjectImageHover;
  protected boolean mouseIsHovering;
  private String hoverCursor;
  
  public GameObject(String identifier, int x, int y, int owidth, int oheight, String hoverCursor) {
    this(identifier, x, y, owidth, oheight, "", hoverCursor);
  }
  
  public GameObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String hoverCursor) {
    this.identifier = identifier;
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    this.oheight = oheight;
    this.hasImage = !gameObjectImageFile.equals(""); 
    if(this.hasImage) {
       this.gameObjectImage = loadImage(gameObjectImageFile);
    }
    this.hoverCursor = hoverCursor;
    hasHoverImage = false;
    mouseIsHovering = false;
  }
  
  public void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }
  
  public void draw() {
    if(hasImage) {
      if(mouseIsHovering && hasHoverImage) {
        image(gameObjectImageHover, x, y, owidth, oheight);
      } else {
        image(gameObjectImage, x, y, owidth, oheight);
      }
    }
  }
  
  public void mouseMoved() {
    mouseIsHovering = false;
    if (mouseX >= x + 16 && mouseX <= x + owidth + 16 &&
        mouseY >= y + 16 && mouseY <= y + oheight + 16) {
        mouseIsHovering = true;
    }
  }
  
  public void mouseClicked() { }
  
  public String getIdentifier() {
    return this.identifier;
  }
  
  @Override 
  public boolean equals(Object obj) { 
    if (obj == this) { return true; } 
    if (obj == null || obj.getClass() != this.getClass()) { return false; } 
    GameObject otherGameObject = (GameObject) obj; 
    return otherGameObject.getIdentifier().equals(this.identifier);
  } 

  @Override 
  public int hashCode() { 
    final int prime = 11;
    return prime * this.identifier.hashCode();
  }
}
