class InventoryManager {
  private ArrayList<Collectable> collectables;
  private ArrayList<Collectable> markedForDeathCollectables;
  private int x;
  private int y;
  
  public InventoryManager() {
     collectables = new ArrayList<Collectable>();
     markedForDeathCollectables = new ArrayList<Collectable>();
  }
  
  public void addCollectable(Collectable collectable) {
    collectables.add(collectable);
    collectable.setPos(collectables.indexOf(collectable));
  }
  
  public void removeCollectable(Collectable collectable) {
    markedForDeathCollectables.add(collectable);
  }
  
  public boolean containsCollectable(Collectable collectable) {
    return collectables.contains(collectable);
  }
  
  public void clearMarkedForDeathCollectables() {
    if(markedForDeathCollectables.size() > 0) {
      for(Collectable collectable : markedForDeathCollectables) {
        collectables.remove(collectable);
      }
      markedForDeathCollectables  = new ArrayList<Collectable>();
    }
  }

  public void setValues() {
    x = 303*xs;
    y = 36*ys;
  }
  
  public void mouseClicked() {
    for (Collectable collectable : collectables) {
      collectable.mouseClicked(collectables.indexOf(collectable));
    }
  }

  public void mousePressed() {
    if (mouseX >= x && mouseX <= x + 16*xs &&
        mouseY >= y && mouseY <= y + 162*ys) {
      for (Collectable collectable : collectables) {
        collectable.mousePressed();
      }
    }
  }

  public void mouseDragged() {
    for (Collectable collectable : collectables) {
      collectable.mouseDragged();
    }
  }

  public void mouseReleased() {
    for (Collectable collectable : collectables) {
      collectable.mouseReleased();
      collectable.setPos(collectables.indexOf(collectable));
    }
  }

  public void draw() {
    if (collectables.size() > 0) {
      for (int i = 0; i < collectables.size(); i++) {
        collectables.get(i).drawInventory();
      }
    }
  }
}
