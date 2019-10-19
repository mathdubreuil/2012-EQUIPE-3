import processing.sound.*;

Partie partie = null;
SystemeDynamique systemeDynamique = null;
ParticleSystem particleSystem = null;
int countParticles = 250;
PImage fond;
SoundFile mangerPomme;
SoundFile mangerRocheMur;
PImage imageMask;
PImage imageTransformer;
PImage imageSource;
int activeFilterMode = 0;

void setup() {
  size(1000, 800);
  fond = loadImage("grass_BG_BG.png");
  fond.resize(1000, 800);
  mangerRocheMur = new SoundFile(this, "explosion_very_small_pop.mp3");
  mangerPomme = new SoundFile(this, "zapsplat_human_eat_bite_potato_raw_single_002_39698.mp3");
  imageSource = loadImage("journe2.jpg");
  imageSource.resize(1000, 800);
  imageMask = loadImage("Serpent_tête_mask.png");
  imageMask.resize(1000, 800);
  imageTransformer = loadImage("journe2.jpg");
  imageTransformer.resize(1000, 800);
}

void draw() {
  if(partie != null && particleSystem != null && !partie.partiefini){
    background(fond);
    particleSystem.update();
    partie.dessinerJeux();
  }
  if(systemeDynamique != null){
    systemeDynamique.dessinerSystemeDynamique();
  }
  switch (activeFilterMode)
    {
      case 1:
        filter(ERODE);
        break;
      case 2:
        filter(GRAY);
        break;
      case 3:
        filter(DILATE);
        break;
    }
}

void keyPressed() {
  if(key == '1'){
    systemeDynamique = null;
    activeFilterMode = -1;
    particleSystem = new ParticleSystem(countParticles);
    partie = new Partie();
  }
  if(key == '2'){
    background(fond);
    particleSystem = null;
    partie = null;
    activeFilterMode = -1;
    systemeDynamique = new SystemeDynamique();
  }
  if(key == '3'){
    tint(0, 255, 0, 200);
    background(imageSource);
    particleSystem = null;
    partie = null;
    systemeDynamique = null;
    imageTransformer.mask(imageMask);
    activeFilterMode = 0;  
    image(imageTransformer, 0, 0);
  }
  if(key == '4'){
    tint(0, 255, 0, 200);
    background(imageSource);
    particleSystem = null;
    partie = null;
    systemeDynamique = null;
    imageTransformer.mask(imageMask);
    activeFilterMode = 0;  
    image(imageTransformer, 0, 0);
  }
  if(partie != null && partie.enJeux()){
    if (keyCode == UP && partie.derniereToucheAppuyer != 40) {
      partie.derniereToucheAppuyer = keyCode;
      partie.toucheAppuyer(0, -1);
    } else if (keyCode == DOWN && partie.derniereToucheAppuyer != 38) {
      partie.derniereToucheAppuyer = keyCode;
      partie.toucheAppuyer(0, 1);
    } else if (keyCode == RIGHT && partie.derniereToucheAppuyer != 37) {
      partie.derniereToucheAppuyer = keyCode;
      partie.toucheAppuyer(1, 0);
    } else if (keyCode == LEFT && partie.derniereToucheAppuyer != 39) {
      partie.derniereToucheAppuyer = keyCode;
      partie.toucheAppuyer(-1, 0);
    }
  }  
  if(keyCode == 'E'){
    activeFilterMode = 1;
  }
  if(keyCode == 'G'){
    activeFilterMode = 2;
  }
  if(keyCode == 'D'){
    activeFilterMode = 3;
  }
}
