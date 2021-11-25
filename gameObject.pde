class GameObject {
  protected int x;
  protected int y;
  protected int owidth;
  protected int oheight;
  private String identifier;
  private boolean isDraggable;
  private boolean hasImage;
  private boolean hasHoverImage;
  private boolean isBeingDragged;
  public PImage gameObjectImage;
  private PImage gameObjectImageHover;
  protected boolean mouseIsHovering;
  private String hoverCursor;
  private boolean isComputer = false;
  private int computerStartOpacity = 315;
  
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
    if (this.hasImage) {
       this.gameObjectImage = loadImage(gameObjectImageFile);
    }
    if (gameObjectImageFile == "computerStarting.png") isComputer = true;
    this.hoverCursor = hoverCursor;
    hasHoverImage = false;
    mouseIsHovering = false;
  }
  
  public void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }
  
  public void draw() {
    if(!isComputer) {
      if(hasImage) {
        if(mouseIsHovering && hasHoverImage) {
          image(gameObjectImageHover, x, y, owidth, oheight);
        } else {
          image(gameObjectImage, x, y, owidth, oheight);
        }
      }
    } else {
      if (computerStartOpacity > 0) {
        computerStartOpacity--;
        tint(255, computerStartOpacity + int(random(-15, 25)));
        image(gameObjectImage, x, y, owidth, oheight);
        tint(255, 255);
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

  public boolean isMouseHovering() {
    return false;
  }

  public void isItemAccepted(Collectable draggedItem) { }

  public void changeImage(PImage replaceImage) {
    this.gameObjectImage = replaceImage;
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
