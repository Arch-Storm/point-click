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
    x = (int)(width*0.99)-width/20;
    y = (int)(height * 0.2);
  }

  public void mousePressed() {
    if (mouseX >= x && mouseX <= x + width / 20 &&
        mouseY >= y && mouseY <= y + (int)height * 0.9) {
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
