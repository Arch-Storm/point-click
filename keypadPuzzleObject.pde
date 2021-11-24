class KeypadPuzzleObject extends GameObject {
    private String correctKeypadCode;
    private String currentCode = "";
    private PImage img;
    private KeypadButton[] keypadButtons = new KeypadButton[11];

    public KeypadPuzzleObject(String identifier, int x, int y, int owidth, 
                        int oheight, String correctKeypadCode, String imagePath, String hoverCursor) {
        super(identifier, x, y, owidth, oheight, hoverCursor);
        this.correctKeypadCode = correctKeypadCode;
        this.img = loadImage(imagePath);

        for (int i = 0; i < this.keypadButtons.length; i++) {
            if (i < 9) {
                int column = ((i+1) % 3 == 0) ? 3 : (i+1) % 3;
                int row = ceil((i+1) / 3.0f);
                this.keypadButtons[i] = new KeypadButton(i+1, column*12*xs+112*xs, 48*xs-row*12*xs+86*ys, 10*xs, 10*xs);
            } //nums 1-9
            else if (i == 9) this.keypadButtons[i] = new KeypadButton(true, false, 124*xs, 133*ys, 22*xs, 10*xs); //enter
            else this.keypadButtons[i] = new KeypadButton(false, true, 148*xs, 133*ys, 10*xs, 10*xs); //delete
        }
    }

    @Override
    public void draw() {
        image(img, x, y, owidth, oheight);
    }

    @Override
    public void mouseClicked() {
        for (KeypadButton keypadButton : keypadButtons) {
            keypadButton.mouseClicked(this, currentCode);
        }
    }

    public void addNum(int num) {
        currentCode += num;
    }

    public void checkCode() {
        if (currentCode.matches(correctKeypadCode)) {
            sceneManager.goToPreviousScene(); // remove current scene from stack
            try {
                sceneManager.goToScene("ending");
            } catch(Exception e) { 
                println(e.getMessage());
            }
        } else {
            currentCode = "";
        }
    }

    public void removeLastNum() {
        int l = currentCode.length();
        if (l > 0) currentCode = currentCode.substring(0, l - 1);
    }
}

class KeypadButton extends GameObject{
    private boolean isEnter;
    private boolean isDelete;
    private int num;

    public KeypadButton(boolean isEnter, boolean isDelete, int x, int y, int owidth, int oheight) {
        super("", x, y, owidth, oheight, "interactableCursor");
        this.isEnter = isEnter;
        this.isDelete = isDelete;
    }

    public KeypadButton(int num, int x, int y, int owidth, int oheight) {
        super("", x, y, owidth, oheight, "interactableCursor");
        this.isEnter = false;
        this.isDelete = false;
        this.num = num;
    }

    public void mouseClicked(KeypadPuzzleObject puzzle, String currentCode) {
        if (mouseX >= x && mouseX <= x + owidth &&
            mouseY >= y && mouseY <= y + oheight) {
            if(!isEnter && !isDelete && currentCode.length() < 3) {
                puzzle.addNum(num);
            } else if (isEnter) {
                puzzle.checkCode();
            } else if (isDelete) {
                puzzle.removeLastNum();
            }
        }
    }
}