class Collectable {
  private String name;
  private String gameObjectImageFile;
  private String inventoryImageFile;
  private PImage img;
  private PImage invImg;
  private int x;
  private int dragX;
  private int y;
  private int dragY;
  private int owidth;
  private int oheight;
  private boolean canDrag;
  private boolean beingDragged = false;
  //Could be expanded to add an amount, for example
  
  public Collectable(String name, String gameObjectImageFile) {
    this.name = name;
    this.gameObjectImageFile = gameObjectImageFile;
    this.inventoryImageFile = gameObjectImageFile;
    img = loadImage(gameObjectImageFile);
    invImg = loadImage(gameObjectImageFile);
  }
    
  public Collectable(String name, String gameObjectImageFile, String inventoryImageFile) {
    this.name = name;
    this.gameObjectImageFile = gameObjectImageFile;
    this.inventoryImageFile = inventoryImageFile;
    img = loadImage(gameObjectImageFile);
    invImg = loadImage(inventoryImageFile);
  }
  
  public String getName() { 
    return name; 
  }
  
  public String getGameObjectImageFile() { 
    return gameObjectImageFile; 
  } 
  
  @Override 
  public boolean equals(Object obj) { 
    if (obj == this) { return true; } 
    if (obj == null || obj.getClass() != this.getClass()) { return false; } 
    Collectable otherCollectable = (Collectable) obj; 
    return otherCollectable.getName().equals(this.name);
  } 

  @Override 
  public int hashCode() { 
    final int prime = 13;
    return prime * this.name.hashCode();
  }

  public void setPos(int i) {
    this.x = 302*xs;
    this.dragX = this.x;
    this.y = 50*ys + i * 18*ys;
    this.dragY = this.y;
    this.owidth = 16*xs;
    this.oheight = 16*ys;
  }

  public void draw() {
    image(img, x, y, owidth, oheight);
  }

  public void drawInventory() {
    fill(0, 170);
    noStroke();
    rect(x, y, owidth, oheight, 3*xs);
    fill(255, 255);
    if (!beingDragged) image(invImg, x, y, owidth, oheight);
    else image(invImg, dragX, dragY, owidth, oheight);
  }

  public void mouseClicked(int i) {
    if (mouseX >= x && mouseX <= x + owidth &&
        mouseY >= y && mouseY <= y + oheight) {
      if (!zoomed) {
        this.x = 220*xs;
        this.y = 50*ys;
        this.owidth = 80*xs;
        this.oheight = 80*ys;
        zoomed ^= true;
      } else {
        setPos(i);
        zoomed ^= true;
      }
    }
  }

  public void mousePressed() {
    if (mouseX >= x && mouseX <= x + owidth &&
        mouseY >= y && mouseY <= y + oheight) {
        canDrag = true;
    }
  }

  public void mouseDragged() {
    if (canDrag) {
      beingDragged = true;
      int deltaX = mouseX - pmouseX;
      int deltaY = mouseY - pmouseY;
      dragX += deltaX;
      dragY += deltaY;
    }
  }

  public void mouseReleased() {
    if (canDrag) sceneManager.getCurrentScene().isMouseHovering(this);
    canDrag = false;
    beingDragged = false;
  }
}
