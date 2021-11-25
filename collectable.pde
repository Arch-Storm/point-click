class Collectable {
  private String name;
  private String gameObjectImageFile;
  private String inventoryImageFile;
  private int x;
  private int y;
  private int owidth;
  private int oheight;
  private boolean canDrag;
  //Could be expanded to add an amount, for example
  
  public Collectable(String name, String gameObjectImageFile) {
    this.name = name;
    this.gameObjectImageFile = gameObjectImageFile;
    this.inventoryImageFile = gameObjectImageFile;
  }
    
  public Collectable(String name, String gameObjectImageFile, String inventoryImageFile) {
    this.name = name;
    this.gameObjectImageFile = gameObjectImageFile;
    this.inventoryImageFile = inventoryImageFile;
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
    this.x = (int)(width*0.99) - width / 20;
    this.y = (int)(height * 0.2) + i * height / 10;
    this.owidth = width / 20;
    this.oheight = width / 20;
  }

  public void draw() {
    PImage img = loadImage(gameObjectImageFile);
    image(img, x, y, owidth, oheight);
  }

  public void drawInventory() {
    PImage img = loadImage(inventoryImageFile);
    image(img, x, y, owidth, oheight);
  }

  public void mouseClicked(int i) {
    if (mouseX >= x && mouseX <= x + owidth &&
        mouseY >= y && mouseY <= y + oheight) {
      if (!zoomed) {
        this.x = 240*xs;
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
      int deltaX = mouseX - pmouseX;
      int deltaY = mouseY - pmouseY;
      x += deltaX;
      y += deltaY;
    }
  }

  public void mouseReleased() {
    if (canDrag) sceneManager.getCurrentScene().isMouseHovering(this);
    canDrag = false;
  }
}
