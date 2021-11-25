class DisplayText {
    private float counter = 0.0f;
    private float readTime = 1.5f;
    private String displayedText1;
    private String displayedText2;
    private PImage img;

    public void load() {
        img = loadImage("textbox.png");
    }

    public void displayText(String text1, String text2) {
        textDisplayed = true;
        displayedText1 = text1;
        displayedText2 = text2;
        counter = readTime;
    }

    public void changeReadSpeed(float time) {
        readTime = time;
    }

    public void drawText() {
        if (counter > 0.0f) {
            counter -= 1.0f/60.0f;
            tint(255, 170);
            image(img, 0, 0, 320*xs, 180*ys);
            tint(255, 255);
            textFont(ticketingFont);
            textAlign(CENTER);
            textSize(8*ys);
            text(displayedText1, 160*xs, 160*ys);
            text(displayedText2, 160*xs, 172*ys);
        } else {
            counter = 0.0f;
            textDisplayed = false;
        }
    }
}