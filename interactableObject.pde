class InteractableObject extends GameObject { 

  private String acceptedItem;
  private PImage replaceImage;
  
  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String acceptedItem, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, hoverCursor);
    this.acceptedItem = acceptedItem;
    if (acceptedItem == "finger") {
      replaceImage = loadImage("keypadOn.png");
    }
  }

  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String imageFile, String acceptedItem, String hoverCursor) {
    super(identifier, x, y, owidth, oheight, imageFile, hoverCursor);
    this.acceptedItem = acceptedItem;
    if (acceptedItem == "finger") {
      replaceImage = loadImage("keypadOn.png");
    }
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
        audioManager.playOnce("openDoor");
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
        currentScene.removeGameObject(this);
      } else if (acceptedItem == "knife") {
        audioManager.playOnce("cuttingFinger");
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
        currentScene.removeGameObject(this);
      } else if (acceptedItem == "finger") {
        changeImage(replaceImage);
        Scene previousScene = sceneManager.scenes.get("hallway01");
        previousScene.removeByIndex(3);
        previousScene.addGameObject(previousScene.hiddenObjects.get(0));
      }
    }
  }
}
