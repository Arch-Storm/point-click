class ButtonObject extends GameObject {
    private String text;
    private float textWidth;
    private float textHeight;
    private String nextSceneIdentifier;
    private boolean moveBack;

    public ButtonObject(String identifier, int x, int y, int owidth, 
                        int oheight, String text, String nextSceneIdentifier ) {
        super(identifier, x, y, owidth, oheight);
        this.text = text;
        this.nextSceneIdentifier = nextSceneIdentifier;
        this.moveBack = false;
        calculateTextArea(); //Automatically calculates the area necessary to display the entire text.
    }

    @Override
    public void draw() {
        super.draw();
        fill(255, 255, 255, 64);
        rect(this.x, this.y, 200, textHeight, 8);
        fill(255);
        textSize(48);
        text(text, this.x + 15, this.y, textWidth, textHeight); 
    }

    @Override
    public void mouseClicked() {
        if(mouseIsHovering) {
        if(moveBack) {
            sceneManager.goToPreviousScene();
        } else {
            if (nextSceneIdentifier == "exit") {
                exit();
            } else {
                try {
                sceneManager.goToScene(nextSceneIdentifier);
                } catch(Exception e) { 
                println(e.getMessage());
                }
            }
        }
        }
    }

    public void calculateTextArea() {
    textWidth = textWidth(text);
    println(textWidth);
    float remaining = textWidth - 300;
    textWidth = (textWidth > 300) ? 300 : textWidth * 4;
    textHeight = 64;
    while(remaining > 300)
    {
      textHeight += 30;
      remaining -= 300;
    }
  }
}