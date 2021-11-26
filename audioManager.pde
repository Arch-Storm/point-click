import java.util.HashMap;
import processing.sound.*;

class AudioManager {
    private HashMap<String, SoundFile> sounds = new HashMap<String, SoundFile>();
    private PApplet sketch;
    private String[] soundNames = {"ambience", "cuttingFinger", "grabDocs", "grabKey", "grabKnife", "metalHits", "openDoor",
                                   "openLocker", "screech", "singleHitEcho", "singleHitMetal", "countdown",
                                   "closeLocker", "denied", "changeNumber", "accepted", "grabFinger"};

    private String[] ambienceSounds = {"metalHits", "screech", "singleHitEcho", "singleHitMetal"};
    private float counter = 1.0f;
    private boolean ambienceStarted;
    private float volume = 0.01f;

    public AudioManager(PApplet p) {
        this.sketch = p;
    }
    
    public void loadSounds() {
        for (String name : soundNames) {
            SoundFile sound = new SoundFile(sketch, name + ".mp3");
            sounds.put(name, sound);
        }
    }

    public void playLooped(String sound) {
        if (sound != "") sounds.get(sound).loop();
    }
    
    public void playOnce(String sound) {
        if (sound != "") sounds.get(sound).play();
    }

    public void startAmbience() {
        ambienceStarted = true;
        sounds.get("ambience").amp(volume);
        sounds.get("ambience").loop();
    }

    public void randomAmbience() {
        if (ambienceStarted) {
            // slowly raise volume (5 seconds)
            if (volume + 0.2f/60.0f < 1) volume += 0.2f/60.0f;
            else volume = 1.0f;
            sounds.get("ambience").amp(volume);

            // Sets counter to 0 every second
            if (volume == 1.0f) {
                if (counter > 0.0f) counter -= 1.0f/60.0f;
                else {
                    counter = 1.0f;

                    // Play a sound roughly every 8 seconds
                    int i = int(random(9)); // only returns 0-8
                    if (i == 8) {
                        int r = int(random(ambienceSounds.length));
                        sounds.get(ambienceSounds[r]).amp(0.2);
                        sounds.get(ambienceSounds[r]).play();
                    }
                }
            }
        }
    }
}