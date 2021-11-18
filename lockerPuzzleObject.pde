// NON FUNCTIONAL MORE OR LESS

class LockerPuzzleObject extends GameObject {
    private String correctLockerCode;
    private String currentCode = "000";
    private PImage checkMark = loadImage("TEMP_check.png");
    private LockerPuzzleArrow[] lockerPuzzleArrows = new LockerPuzzleArrow[6];

    public LockerPuzzleObject(String identifier, int x, int y, int owidth, 
                        int oheight, String correctLockerCode) {
        super(identifier, x, y, owidth, oheight);
        this.correctLockerCode = correctLockerCode;

        this.lockerPuzzleArrows[0] = new LockerPuzzleArrow(true, 0, 115*xs, 60*ys, 40*xs, 40*xs);
        this.lockerPuzzleArrows[1] = new LockerPuzzleArrow(true, 1, 160*xs, 60*ys, 40*xs, 40*xs);
        this.lockerPuzzleArrows[2] = new LockerPuzzleArrow(true, 2, 205*xs, 60*ys, 40*xs, 40*xs);
        this.lockerPuzzleArrows[3] = new LockerPuzzleArrow(false, 0, 115*xs, 140*ys, 40*xs, 40*xs);
        this.lockerPuzzleArrows[4] = new LockerPuzzleArrow(false, 1, 160*xs, 140*ys, 40*xs, 40*xs);
        this.lockerPuzzleArrows[5] = new LockerPuzzleArrow(false, 2, 205*xs, 140*ys, 40*xs, 40*xs);
    }

    @Override
    public void draw() {
        textSize(90*ys);
        textAlign(CENTER);
        text(currentCode, x, y);

        imageMode(CENTER);
        for (LockerPuzzleArrow arrow : lockerPuzzleArrows) arrow.draw();
        imageMode(CORNER);
        image(checkMark, x + 80*xs, y - 50*ys, 40*xs, 40*xs);
    }

    @Override
    public void mouseClicked() {
        if (mouseIsHovering) {
            for (LockerPuzzleArrow arrow : lockerPuzzleArrows) {
                currentCode = arrow.mouseClicked(currentCode);
            }
            if (mouseX >= x + 80*xs && mouseX <= x + 120*xs &&
                mouseY >= y - 50*ys && mouseY <= y - 50*ys + 40*xs) {
                lockerLockIsSolved = checkCode();
            }
        }
    }

    public boolean checkCode() {
        return (currentCode.matches(correctLockerCode)) ? true : false;
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

    public String mouseClicked(String currentCode) {
        if (mouseX >= x && mouseX <= x + owidth &&
            mouseY >= y && mouseY <= y + oheight) {
            char[] chars = new char[3];

            currentCode.getChars(0, 3, chars, 0); // String to array of chars
            int i = chars[index] - '0'; // Converts char to int (somehow)
            if (isHigher) i++;
            else i--;
            chars[index] = (char)(i + '0'); // Back to char

            return new String(chars);
        }

        return currentCode;
    }
}