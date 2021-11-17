int wwidth = 800;
int wheight = 800;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  Collectable key = new Collectable("key", "key.png");
  MoveToSceneObject object7 = new MoveToSceneObject("goToScene04_scene01", 206, 461, 50, 50, "arrowUp.png", "scene04");
  
  Scene menu = new Scene("menu", "menu.jpg");
  ButtonObject startButton = new ButtonObject("startButton", 50, 500, 200, 64, "Start", "scene01");
  ButtonObject optionsButton = new ButtonObject("optionsButton", 50, 585, 200, 64, "Options", "options");
  ButtonObject exitButton = new ButtonObject("exitButton", 50, 670, 200, 64, "Exit", "exit");
  menu.addGameObject(startButton);
  menu.addGameObject(optionsButton);
  menu.addGameObject(exitButton);

  Scene options = new Scene("options", "menu.jpg");
  ButtonObject backButton = new ButtonObject("backButton", 50, 670, 200, 64, "Back", "menu");
  options.addGameObject(backButton);

  Scene scene01 = new Scene("scene01", "back01.png");
  RequireObject loupe01 = new RequireObject("requiresApple_scene01", 206, 461, 50, 50, "zoom.png", "You need an Apple before getting here!", key, object7);
  loupe01.setHoverImage("zoomIn.png");
  scene01.addGameObject(loupe01);
  TextObject loupe02 = new TextObject("smallText_scene01", 541, 445, 50, 50, "zoom.png", "This object has a text!");
  loupe02.setHoverImage("zoomIn.png");
  scene01.addGameObject(loupe02);
  TextObject loupe03 = new TextObject("largeText_scene01", 46, 687, 50, 50, "zoom.png", "This object has a way longer text. It shows that the windows can be of varied size according to the text.");
  loupe03.setHoverImage("zoomIn.png");
  scene01.addGameObject(loupe03);
  MoveToSceneObject object2 = new MoveToSceneObject("goToScene02_scene01", 708, 445, 50, 50, "arrowRight.png", "scene02");
  scene01.addGameObject(object2);
  MoveToSceneObject restaurantSceneMoveTo = new MoveToSceneObject("goToScene06_scene01", 388, 440, 50, 50, "arrowUp.png", "scene05");
  scene01.addGameObject(restaurantSceneMoveTo);
  
  Scene scene02 = new Scene("scene02", "back02.png");
  MoveToSceneObject object3 = new MoveToSceneObject("goBack_scene02", 350, 700, 50, 50, "arrowDown.png", true);
  scene02.addGameObject(object3);
  MoveToSceneObject object4 = new MoveToSceneObject("goToScene03_scene02", 441, 494, 50, 50, "arrowUp.png", "scene03");
  scene02.addGameObject(object4);
  
  Scene scene03 = new Scene("scene03", "back04.png");
  MoveToSceneObject object5 = new MoveToSceneObject("goBack_scene03", 203, 673, 50, 50, "arrowDown.png", true);
  scene03.addGameObject(object5);
  CollectableObject object6 = new CollectableObject("apple_scene03", 325, 366, 123, 101, key);
  scene03.addGameObject(object6);
  
  Scene scene04 = new Scene("scene04", "back03.png");
  TextObject endGame = new TextObject("smallText_scene04", 430, 590, 50, 50, "medal1.png", "Congratulations. You finished the game!");
  scene04.addGameObject(endGame);
  
  Scene scene05 = new Scene("scene05", "back05.png");
  MoveToSceneObject object8 = new MoveToSceneObject("goBack_scene01", 203, 753, 50, 50, "arrowDown.png", true);
  scene05.addGameObject(object8);
  TextObject loupe04 = new TextObject("smallText_scene05", 120, 275, 50, 50, "zoom.png", "Have you checked the apples in that odd house to the right?");
  loupe04.setHoverImage("zoomIn.png");
  scene05.addGameObject(loupe04);
  TextObject loupe05 = new TextObject("smallText_2_scene05", 480, 285, 50, 50, "zoom.png", "Hello! How are you doing?");
  loupe05.setHoverImage("zoomIn.png");
  scene05.addGameObject(loupe05);
  
  sceneManager.addScene(menu);
  sceneManager.addScene(options);
  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
}

void draw()
{
  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}
