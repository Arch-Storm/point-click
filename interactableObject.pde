class InteractableObject extends GameObject { 

  private String acceptedItem;
  private PImage replaceImage;
  private boolean textSeen;
  private String text1;
  private String text2;
  
  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String acceptedItem, String hoverCursor, String text1, String text2) {
    super(identifier, x, y, owidth, oheight, hoverCursor);
    this.acceptedItem = acceptedItem;
    if (acceptedItem == "finger") {
      replaceImage = loadImage("keypadOn.png");
    }
    if (text1 == "" && text2 == "") textSeen = true;
    else {
      this.text1 = text1;
      this.text2 = text2;
    }
  }

  public InteractableObject(String identifier, int x, int y, int owidth, 
                           int oheight, String imageFile, String acceptedItem, String hoverCursor, String text1, String text2) {
    super(identifier, x, y, owidth, oheight, imageFile, hoverCursor);
    this.acceptedItem = acceptedItem;
    if (acceptedItem == "finger") {
      replaceImage = loadImage("keypadOn.png");
    }
    if (text1 == "" && text2 == "") textSeen = true;
    else {
      this.text1 = text1;
      this.text2 = text2;
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
  public void mouseClicked() {
    if (mouseX >= x && mouseX <= x + owidth &&
        mouseY >= y && mouseY <= y + oheight) {
      if (!textSeen && !textDisplayed) {
        displayText.displayText(text1, text2);
        textSeen = true;
      }
    }
  }

  @Override
  public void isItemAccepted(Collectable heldItem) {
    if (acceptedItem == heldItem.name) {
      Scene currentScene = sceneManager.getCurrentScene();
      inventoryManager.removeCollectable(heldItem);
      if (acceptedItem == "storageKeyObject") {
        audioManager.playOnce("openDoor");
        displayText.displayText("Great!", "The key worked.");
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
        currentScene.removeGameObject(this);
      } else if (acceptedItem == "knife") {
        audioManager.playOnce("cuttingFinger");
        displayText.displayText("Can't believe I'm actually doing", "this for my job. Eughhh");
        currentScene.addGameObject(currentScene.hiddenObjects.get(0));
        currentScene.removeGameObject(this);
      } else if (acceptedItem == "finger") {
        changeImage(replaceImage);
        displayText.displayText("Thank god...", "I actually got it open like this.");
        Scene previousScene = sceneManager.scenes.get("hallway01");
        audioManager.playOnce("accepted");
        previousScene.removeByIndex(3);
        previousScene.addGameObject(previousScene.hiddenObjects.get(0));
      } else if (acceptedItem == "keyCard") {
        displayText.displayText("Is it actually starting up?!", "Yes! How is this still functional?!");
        currentScene.gameObjects.add(1, currentScene.hiddenObjects.get(0));
        currentScene.gameObjects.add(2, currentScene.hiddenObjects.get(1));
        currentScene.removeGameObject(this);
      }
    }
  }
}
