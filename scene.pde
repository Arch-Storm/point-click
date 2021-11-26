class Scene {
  private String sceneName;
  private PImage backgroundImage;
  public ArrayList<GameObject> gameObjects;
  public ArrayList<GameObject> hiddenObjects;
  
  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;

  private String currentCursor = "";

  private String text1;
  private String text2;
  private boolean textSeen;

  private boolean shouldBlend = false;
  private boolean isBlended = false;
  private int blendingOpacity = -90;

  private float textCounter = 5.0f;


  public Scene(String sceneName, String backgroundImageFile) {
    this(sceneName, backgroundImageFile, "", "");
  }
  
  public Scene(String sceneName, String backgroundImageFile, String text1, String text2) {
    this.sceneName = sceneName;
    if (sceneName == "ending" || sceneName == "hallway02") shouldBlend = true;
    this.backgroundImage = loadImage(backgroundImageFile);
    gameObjects = new ArrayList<GameObject>();
    hiddenObjects = new ArrayList<GameObject>();
    markedForDeathGameObjects = new ArrayList<GameObject>();
    recentlyAddedGameObjects = new ArrayList<GameObject>();
    if (text1 == "" && text2 == "") textSeen = true;
    else {
      this.text1 = text1;
      this.text2 = text2;
    }
    //added this so that it automatically adds a new scene to the scenemanager
    sceneManager.addScene(this);
  }
  
  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }

  public void addHiddenObject(GameObject object) {
    hiddenObjects.add(object);
  }
  
  public void removeGameObject(GameObject object) {
    markedForDeathGameObjects.add(object);
  }

  public void removeByIndex(int index) {
    gameObjects.remove(index);
  }
  
  public void updateScene() {
    if(markedForDeathGameObjects.size() > 0) {
      for(GameObject object : markedForDeathGameObjects) {
        gameObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();
    }
    if(recentlyAddedGameObjects.size() > 0) {
      for(GameObject object : recentlyAddedGameObjects) {
        gameObjects.add(object);
      }
      recentlyAddedGameObjects  = new ArrayList<GameObject>();
    }
  }
  
  public void draw(int wwidth, int wheight) {
    if (!textSeen && !textDisplayed && sceneName == "hallway02") {
      if (textCounter > 0.0f) textCounter -= 1.0f/60.0f;
      else {
        displayText.displayText(text1, text2);
        textSeen = true;
      }
    } else if (!textSeen && !textDisplayed) {
      displayText.displayText(text1, text2);
      textSeen = true;
    }
    if (shouldBlend) {
      if (blendingOpacity < 255 && !isBlended) {
        blendingOpacity += 2;
        fill(0, blendingOpacity);
        rect(0, 0, width, height);
        fill(255, 255);
      } else if (blendingOpacity >= 255 && !isBlended) {
        isBlended = true;
        blendingOpacity = 0;
        fill(0, 255);
        rect(0, 0, width, height);
        fill(255, 255);
      } else if (blendingOpacity < 255 && isBlended) {
        blendingOpacity += 2;
        fill(0, 255);
        rect(0, 0, width, height);
        fill(255, 255);
        tint(255, blendingOpacity);
        image(backgroundImage, 0, 0, wwidth, wheight);
        tint(0, 255);
      } else if (blendingOpacity >= 255 && isBlended) {
        shouldBlend = false;
      }
    } else {
      tint(255, 255);
      image(backgroundImage, 0, 0, wwidth, wheight);
      for(GameObject object : gameObjects) {
        object.draw();
      }
    }
  }
  
  public void mouseMoved() {
    currentCursor = "mainCursor";
    for(GameObject object : gameObjects) {
      object.mouseMoved();
      if (object.mouseIsHovering) {
        currentCursor = object.hoverCursor;
      }
    }
    try{
        cursor(cursors.get(currentCursor));
    }
    catch(Exception e){
      currentCursor = "mainCursor";
      cursor(cursors.get(currentCursor));
      println(e);
    }
    
  }
  
  public void mouseClicked() {
    for(GameObject object : gameObjects) {
      object.mouseClicked();
    }
  }
  
  public String getSceneName() {
    return this.sceneName;
  }

  public void isMouseHovering(Collectable heldItem) {
    GameObject hoveredObject = null;
    for(GameObject object : gameObjects) {
      hoveredObject = (object.isMouseHovering()) ? object : hoveredObject;
    }
    if (hoveredObject != null) {
      hoveredObject.isItemAccepted(heldItem);
    }
  }
}
