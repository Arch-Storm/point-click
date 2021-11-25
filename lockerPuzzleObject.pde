class LockerPuzzleObject extends GameObject {
    private String correctLockerCode;
    private String currentCode = "000";
    private PImage checkMark = loadImage("TEMP_check.png");
    private LockerPuzzleArrow[] lockerPuzzleArrows = new LockerPuzzleArrow[6];

    public LockerPuzzleObject(String identifier, int x, int y, int owidth, 
                        int oheight, String imgFile, String correctLockerCode, String hoverCursor) {
        super(identifier, x, y, owidth, oheight, imgFile, hoverCursor);
        this.correctLockerCode = correctLockerCode;

        this.lockerPuzzleArrows[0] = new LockerPuzzleArrow(true, 0, 127*xs, 74*ys, 20*xs, 20*xs);
        this.lockerPuzzleArrows[1] = new LockerPuzzleArrow(true, 1, 150*xs, 74*ys, 20*xs, 20*xs);
        this.lockerPuzzleArrows[2] = new LockerPuzzleArrow(true, 2, 173*xs, 74*ys, 20*xs, 20*xs);
        this.lockerPuzzleArrows[3] = new LockerPuzzleArrow(false, 0, 127*xs, 110*ys, 20*xs, 20*xs);
        this.lockerPuzzleArrows[4] = new LockerPuzzleArrow(false, 1, 150*xs, 110*ys, 20*xs, 20*xs);
        this.lockerPuzzleArrows[5] = new LockerPuzzleArrow(false, 2, 173*xs, 110*ys, 20*xs, 20*xs);
    }

    @Override
    public void draw() {
        super.draw();

        textSize(oheight / 3);
        textAlign(CENTER);
        text(currentCode, x + owidth / 2, y + (int)(oheight * 0.8f));

        for (LockerPuzzleArrow arrow : lockerPuzzleArrows) arrow.draw();
    }

    @Override
    public void mouseMoved() {
    mouseIsHovering = false;
    if (mouseX >= x - owidth / 2 && mouseX <= x + owidth / 2 &&
        mouseY >= y - oheight && mouseY <= y + oheight / 2) {
            mouseIsHovering = true;
        }
    }

    @Override
    public void mouseClicked() {
        for (LockerPuzzleArrow arrow : lockerPuzzleArrows) {
            currentCode = arrow.mouseClicked(currentCode, x, y, owidth, oheight);
        }
        if (mouseX >= x + owidth / 2 - 20*xs && mouseX <= x + owidth / 2 + 20*xs &&
            mouseY >= y && mouseY <= y + 60*ys &&
            currentCode.matches(correctLockerCode)) {
            audioManager.playOnce("openLocker");
            sceneManager.goToPreviousScene(); // "remove" the locker scene from the stack
            sceneManager.goToPreviousScene(); // "remove" the old hallway02 scene from the stack
            try {
                sceneManager.goToScene("openLocker");
            } catch(Exception e) { 
                println(e.getMessage());
            }
        }
    }
}

class LockerPuzzleArrow {
    private boolean isHigher;
    private int index;
    private PImage img;
    private int x;
    private int y;
    private int owidth;
    private int oheight;

    public LockerPuzzleArrow(boolean isHigher, int index, int x, int y, int owidth, int oheight) {
        this.x = x;
        this.y = y;
        this.owidth = owidth;
        this.oheight = oheight;
        this.isHigher = isHigher;
        this.index = index;
        this.img = loadImage(isHigher ? "TEMP_higher.png" : "TEMP_lower.png");
    }

    public void draw() {
        image(img, x, y, owidth, oheight);
    }

    public String mouseClicked(String currentCode, int pX, int pY, int pOwidth, int pOheight) {
        if (mouseX >= x && mouseX <= x + owidth &&
            mouseY >= y && mouseY <= y + oheight) {
            char[] chars = new char[3];

            currentCode.getChars(0, 3, chars, 0); // String to array of chars
            int i = chars[index] - '0'; // Converts char to int (somehow)
            if (isHigher) {
                if (i != 9) i++;
                else i = 0;
            } else {
                if (i != 0) i--;
                else i = 9;
            } 
            chars[index] = (char)(i + '0'); // Back to char

            return new String(chars);
        }

        return currentCode;
    }
}