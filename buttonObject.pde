class ButtonObject extends GameObject {
    private String text;
    private float textWidth;
    private float textHeight;
    private String nextSceneIdentifier;
    private boolean moveBack;

    public ButtonObject(String identifier, int x, int y, int owidth, 
                        int oheight, String text, String nextSceneIdentifier, String hoverCursor ) {
        super(identifier, x, y, owidth, oheight, hoverCursor);
        this.text = text;
        this.nextSceneIdentifier = nextSceneIdentifier;
        this.moveBack = false;
        calculateTextArea(); // Automatically calculates the area necessary to display the entire text.
    }

    @Override
    public void draw() {
        super.draw();
        fill(0, 0, 0, 255);
        rect(this.x, this.y, 32*xs, (int)(textHeight*0.9), 1*xs);
        fill(255);
        textSize(8*xs);
        text(text, this.x + 15, this.y, textWidth, textHeight); 
    }

    @Override
    public void mouseClicked() {
        if(mouseIsHovering) {
            cursor(cursors.get("mainCursor"));
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
    float remaining = textWidth - 300;
    textWidth = (textWidth > 300) ? 300 : textWidth * 0.75*xs;
    textHeight = (int)(width/40*1.5);
    while(remaining > 300)
    {
      textHeight += 30;
      remaining -= 300;
    }
    oheight = (int)(textHeight*0.9);
  }
}