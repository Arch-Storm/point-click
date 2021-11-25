class InteractableObject extends GameObject { 

  private String acceptedItem;
  
  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String acceptedItem, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, hoverCursor);
    this.acceptedItem = acceptedItem;
  }

  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String imageFile, String acceptedItem, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, imageFile, hoverCursor);
    this.acceptedItem = acceptedItem;
  }
  
  @Override
  public void draw() {
    super.draw();
  }

  @Override
  public boolean isMouseHovering() {
      if (mouseX >= x && mouseX <= x + owidth &&
          mouseY >= y && mouseY <= y + oheight) {
        return true;
      } else {
        return false;
      }
  }

  @Override
  public void isItemAccepted(Collectable heldItem) {
    if (acceptedItem == heldItem.name) {
      Scene currentScene = sceneManager.getCurrentScene();
      inventoryManager.removeCollectable(heldItem);
      if (acceptedItem == "storageKeyObject") {
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
      } else if (acceptedItem == "knife") {
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
      } else if (acceptedItem == "finger") {
        sceneManager.goToPreviousScene();
        sceneManager.getCurrentScene().addGameObject(sceneManager.getCurrentScene().hiddenObjects.get(0));
        try {
          sceneManager.goToScene("controlRoom");
        } catch(Exception e) { 
          println(e.getMessage());
        }
      }
      currentScene.removeGameObject(this);
    }
  }
}
