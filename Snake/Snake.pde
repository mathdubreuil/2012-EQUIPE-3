import processing.sound.*;
import processing.video.*;

final int stateGame = 0;
final int stateMenu = 1;
final int stateHelp = 2;
final int statePause = 3;
final int stateEndGame = 4;
final int stateSystemeDynamique = 5;
final int stateMask = 6;
final int stateCredit = 7;
final int stateFlute = 8;

float serpenty=880;
float serpentspeed ;
int stateFluteProgramme=0;
int i;

int state = stateMenu;

Partie partie = null;
SystemeDynamique systemeDynamique = null;
ParticleSystem particleSystem = null;
int countParticles = 250;
int currentScore = 0;

SoundFile mangerPomme;
SoundFile mangerRocheMur;
SoundFile clickButton;
SoundFile menuMusic;
SoundFile Z;
SoundFile X;
SoundFile C;
SoundFile V;

Movie video;

PFont typoTitre;
PFont typoTexte;

PImage imgflute;
PImage imgserpent;
PImage imgfond;
PImage fond;
PImage imageMask;
PImage imageTransformer;
PImage imageSource;
PImage snakeBody;
PImage snakeHead;
PImage snakeHeadUp;
PImage snakeHeadDown;
PImage rock;
PImage apple;

Button newGame;
Button buttonSystemeDynamique;
Button buttonMask;
Button help;
Button quitGame;
Button backMenu;
Button buttonFlute;
Button buttonCredit;

Button newGamePause;
Button resumeGamePause;
Button menuPause;

Button newGameEndGame;
Button menuEndGame;

int headStatus = 1; 
int upDown = 1; 
boolean movie = false;
boolean flute = false;
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
  
  video = new Movie(this, "video.mp4");
  
  typoTitre = loadFont("BellMTBold-48.vlw");
  typoTexte = loadFont("HelveticaNeue-Medium-64.vlw");
  
  snakeBody = loadImage("Serpent_corps.png");
  snakeBody.resize(868, 420);
  snakeHead = loadImage("Serpent_tête.png");
  snakeHeadUp = loadImage("Serpent_tête_bas.png");
  snakeHeadDown = loadImage("Serpent_tête_haut.png");
  rock = loadImage("Roche.png");
  rock.resize(209, 163);
  apple = loadImage("Pomme.png");
  apple.resize(185, 219);
  
  clickButton = new SoundFile(this, "click.mp3");
  
  menuMusic = new SoundFile(this, "menu_music.mp3");
  menuMusic.loop();
  
  imgflute = loadImage("flute.png");
  
  imgserpent = loadImage("serpent.png");
  imgserpent.resize(600, 550);
  imgfond= loadImage("fond.png");
  
  Z  = new SoundFile(this, "A.wav");
  X  = new SoundFile(this, "E.wav"); 
  C  = new SoundFile(this, "G.wav"); 
  V  = new SoundFile(this, "B.wav");
}

void draw() {
  imageMode(CORNER);
  if(i == 20){
    i = 0;
  }else{
    i++;
  }
  // different states of the game uses different draw 
  switch(state) {
  case stateGame:
    drawForGame();
    break;
  case stateMenu:
    drawForMenu();
    break; 
  case stateHelp: 
    drawForHelp();
    break;
  case statePause: 
    drawForPause();
    break;
  case stateEndGame: 
    drawForEnd();
    break;
  case stateSystemeDynamique:
    drawForSystemeDynamique();
    break;
  case stateMask:
    drawForMask();
    break;
  case stateCredit:
    drawForCredit();
    break;
  case stateFlute:
    drawForFlute();
  default:
    break;
  }  
}

void drawForEnd() {
  
  fill(#6c5f48, 30);
  rect(width/2 - 200, height/2 - 150, 400, 300, 7);
  
  fill(0);
  
  textFont(typoTitre);
  textSize(50);
  String endGameTitle = " JEU TERMINÉ ";
  text(endGameTitle, width/2 - textWidth(endGameTitle)/2, height/2 - 80);
 
  
   textFont(typoTexte);
    textSize(28);
  String newGameText =  "   Nouvelle partie   ";
  newGameEndGame = new Button((int)(width/2 - textWidth(newGameText)/2), height/2 - 40 , newGameText);
  newGameEndGame.draw();
  
  String menuText =  "   Menu principal   ";
  menuEndGame = new Button((int)(width/2 - textWidth(menuText)/2), height/2 + 20, menuText);
  menuEndGame.draw();
}


void drawForPause() {
  
  fill(#6c5f48, 30);
  rect(width/2 - 200, height/2 - 175, 400, 350, 7);
  
  fill(0);
  
  textFont(typoTitre);
  textSize(60);
  String pauseTitle = " PAUSE ";
  text(pauseTitle, width/2 - textWidth(pauseTitle)/2, height/2 - 100);
  

 textFont(typoTexte);
 textSize(28);
  String resumeGameText =  "   Reprendre la partie   ";
  resumeGamePause = new Button((int)(width/2 - textWidth(resumeGameText)/2), height/2 - 60, resumeGameText);
  resumeGamePause.draw();
  
  String newGameText =  "   Nouvelle partie   ";
  newGamePause = new Button((int)(width/2 - textWidth(newGameText)/2), height/2 + 10, newGameText);
  newGamePause.draw();
  
  String menuText =  "   Menu principal   ";
  menuPause = new Button((int)(width/2 - textWidth(menuText)/2), height/2 + 80, menuText);
  menuPause.draw();
}

void drawForGame() {
  if(partie != null) {
     if (partie.partiefini) {
      state = stateEndGame;
    }
  }
   
  if (partie != null && particleSystem != null && !partie.partiefini) {
    background(fond);
    particleSystem.update();
    partie.dessinerJeux();
  }
  
  switch (activeFilterMode) {
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

void drawForCredit(){
  
  if (movie == true) {
    image(video, 0, 0, 1000, 800);
  }
  strokeWeight(1);
  textSize(28);
  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
}

void drawForFlute(){
  
  
  imageMode(CENTER);
  image(imgfond,500,400);
  
  fill(203, 198, 130);
  textFont(typoTexte);
  textSize(37);
  text("Découvrez ce qui arrive lorsque vous \nappuyez sur l'une des lettres z, x, c et v\nde votre clavier", 50,100);
  image(imgflute, 850, 400);
  image(imgserpent,50,serpenty);

  
  if (stateFluteProgramme == 1) {
    serpenty=serpenty-serpentspeed;
    } 
  
  if (stateFluteProgramme == 2) {
   serpenty=serpenty+0.5;
  }
  strokeWeight(1);
  textSize(28);
  String backText =  "  Retour  ";
  backMenu = new Button(50, 30, backText);
  backMenu.draw();
  switch (activeFilterMode) {
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

void drawForSystemeDynamique() {
  strokeWeight(1);
  textSize(28);
  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
  
  if (systemeDynamique != null) {
    systemeDynamique.dessinerSystemeDynamique();
  }
  
  switch (activeFilterMode) {
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

void drawForMask() {
  strokeWeight(1);
  textSize(28);
  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
  
  
  switch (activeFilterMode) {
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

void drawForHelp() {
  background(0);
  image(fond, 0, 0);
  strokeWeight(1);

  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
  
  
  
  textFont(typoTitre);
  textSize(80);
  String title = "COMMENT JOUER ?";
  text(title, width/2 - textWidth(title)/2, 200);
  strokeWeight(5);
  line(120, 250 , width - 120, 250);
  
  textFont(typoTexte);
  textSize(22);
  String intro = "Déplacez le serpent pour manger les pommes! Évitez les obstables et les murs!";
  text(intro, width/2 - textWidth(intro)/2, 300);

  line(120, 340 , width - 120, 340);
  
  textSize(22);
  String movement = "← ↑ ↓ →  : Déplacer le serpent";
  text(movement, width/2 - textWidth(movement)/2, 380);
  String pause = "p  : Pause la partie en cours";
  text(pause, width/2 - textWidth(pause)/2, 420);
  String effecte = "e  : Ajoute l'effet erode";
  text(effecte, width/2 - textWidth(effecte)/2, 460);
  String effectg = "g  : Ajoute l'effet grey";
  text(effectg, width/2 - textWidth(effectg)/2, 500);
  String effectd = "d  : Ajoute l'effet dilate";
  text(effectd, width/2 - textWidth(effectd)/2, 540);
}

void drawForMenu() {
  tint(255, 255, 255, 255);
  image(fond, 0, 0);
  
  fill(0);
  textFont(typoTitre);
  textSize(100-i);
  String title = "SNAKE";
  text(title, width/2 - textWidth(title)/2, 100);
  
  
  strokeWeight(1);
  textFont(typoTexte);
  textSize(28);
  String newGameText =  "   Nouvelle partie   ";
  newGame = new Button((int)(width/2 - textWidth(newGameText)/2), 110, newGameText);
  newGame.draw();
  
  String helpText =  "   Comment jouer   ";
  help = new Button((int)(width/2 - textWidth(helpText)/2), 310, helpText);
  help.draw();
  
  String systemeDynamiqueText =  "   Système dynamique   ";
  buttonSystemeDynamique = new Button((int)(width/2 - textWidth(systemeDynamiqueText)/2), 160, systemeDynamiqueText);
  buttonSystemeDynamique.draw();
  
  String MaskText =  "   Masque   ";
  buttonMask = new Button((int)(width/2 - textWidth(MaskText)/2), 210, MaskText);
  buttonMask.draw();
  
  String fluteText =  "   Joueur de flûte   ";
  buttonFlute = new Button((int)(width/2 - textWidth(fluteText)/2), 260, fluteText);
  buttonFlute.draw();
  
  String quitText = "   Quitter   ";
  quitGame = new Button((int)(width/2 - textWidth(quitText)/2), 360, quitText);
  quitGame.draw();
  
  String stateCredit =  "   Crédits   ";
  buttonCredit = new Button((int)( textWidth(stateCredit)/2), 600, stateCredit);
  buttonCredit.draw();

  image(apple, 50, height - 770);
  image(apple, width - 50 - apple.width, height - 770);

  image(snakeBody, 200, 400);

  delay(200);
  switch (headStatus) {
    case 1: // down
      image(snakeHeadDown, 200 - snakeHeadDown.width/2, 440 - snakeHeadDown.height/2 - 20);
      headStatus = 2;
      upDown = 2;   
      break;
    case 2:
      image(snakeHead, 200 - snakeHead.width/2, 440 - snakeHead.height/2);

      if(upDown == 1) {
        headStatus = 1; 
      } else {  // last was up
        headStatus = 3; 
      }

      break;
    case 3: 
      image(snakeHeadUp, 200 - snakeHeadUp.width/2, 440 - snakeHeadUp.height/2);
      headStatus = 2;
      upDown = 1;
      break;

  } 
}

void movieEvent(Movie m) {
     m.read();
}

void startGame() {
  tint(255, 255, 255, 255);
  image(fond, 0, 0);
  systemeDynamique = null;
  activeFilterMode = 0;
  movie = false;
  flute = false;
  particleSystem = new ParticleSystem(countParticles);
  partie = new Partie();
}

void startSystemeDynamique() {
  tint(255, 255, 255, 255);
  background(fond);
  particleSystem = null;
  partie = null;
  movie = false;
  flute = false;
  activeFilterMode = 0;
  systemeDynamique = new SystemeDynamique();
}

void startMask() {
  particleSystem = null;
  partie = null;
  systemeDynamique = null;
  movie = false;
  flute = false;
  tint(0, 255, 0, 200);
  background(imageSource);
  imageTransformer.mask(imageMask);
  activeFilterMode = 0;  
  image(imageTransformer, 0, 0);
}

void startFlute() {
  particleSystem = null;
  partie = null;
  systemeDynamique = null;
  movie = false;
  flute = true;
}

void startCredit() {
  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
  
  
  frameRate(60);
  tint(255, 255, 255, 255);
  particleSystem = null;
  partie = null;
  systemeDynamique = null;
  flute = false;
  activeFilterMode = 0;  
  video.loop();
  movie = true;
}
void keyReleased()
{
  if(state == stateFlute){
    if(key == 'z') {
      stateFluteProgramme=2;
      Z.pause();
    } 
    
    if(key == 'x') {
      stateFluteProgramme=2;
      X.pause();
    } 
    
    if(key == 'c') {
      stateFluteProgramme=2;
      C.pause();
    } 
    
    if(key == 'v') {
      stateFluteProgramme=2;
      V.pause();
    } 
  }
}

void keyPressed() {
  if (state == stateGame || state == stateSystemeDynamique || state == stateMask || state == stateCredit || state == stateFlute) {
    switch(key){
      case '1':
        startGame();
        state = stateGame;
        break;
      case '2':
        startSystemeDynamique();
        state = stateSystemeDynamique;
        break;  
      case '3':
        startMask();
        state = stateMask;
        break;  
      case '4':
        startCredit();
        state = stateCredit;
        break;
      case '5':
        startFlute();
        state = stateFlute;
        break;  
      default:
        break;
    }

    if(partie != null && partie.enJeux()){
      if (keyCode == UP && partie.derniereToucheAppuyer != 40) {
        partie.derniereToucheAppuyer = keyCode;
        partie.toucheAppuyer();
      } else if (keyCode == DOWN && partie.derniereToucheAppuyer != 38) {
        partie.derniereToucheAppuyer = keyCode;
        partie.toucheAppuyer();
      } else if (keyCode == RIGHT && partie.derniereToucheAppuyer != 37) {
        partie.derniereToucheAppuyer = keyCode;
        partie.toucheAppuyer();
      } else if (keyCode == LEFT && partie.derniereToucheAppuyer != 39) {
        partie.derniereToucheAppuyer = keyCode;
        partie.toucheAppuyer();
      }
    }
    if(state == stateFlute){
      if (key == 'z'){
        if(!Z.isPlaying())
          Z.play();
        stateFluteProgramme=1;
        serpentspeed=0.2;
       }
       
       if (key == 'x') {
         if(!X.isPlaying())
           X.play();
        stateFluteProgramme=1;
        serpentspeed=0.4;
      }
      
      if (key == 'c') {
        if(!C.isPlaying())
           C.play();
        stateFluteProgramme=1;
        serpentspeed=0.6;
      }
      
      
      if (key == 'v') {
        if(!V.isPlaying())
           V.play();
        stateFluteProgramme=1;
        serpentspeed=1;
      }    
    }
    switch(keyCode) {
      case 'E':
        activeFilterMode = 1;
        break;
      case 'G':
        activeFilterMode = 2;
        break;
      case 'D':
        activeFilterMode = 3;
        break;
      case 'P':
        if(state == stateGame) {
          if (partie != null) {
            state = statePause;
            partie.pause = true;
          } else if (movie == true){
            state = statePause;
            video.pause();
          } else{
            state = statePause;
          }
        }
        break;
      default:
        break;
    }
  }
}


void mousePressed(){
  // check which state to see if the user clicked on any buttons
  
  switch(state) {
  case stateMenu:
    if (newGame.over()) {    
      clickButton.play();
      menuMusic.stop();
      startGame();
      state = stateGame;
    } else if (help.over()) {
      clickButton.play();
      state = stateHelp;
    } else if (buttonSystemeDynamique.over()) {
      clickButton.play();
      menuMusic.stop();
      startSystemeDynamique();
      state = stateSystemeDynamique;
    } else if (buttonMask.over()) {
      clickButton.play();
      menuMusic.stop();
      startMask();
      state = stateMask;
    } else if (buttonFlute.over()) {
      clickButton.play();
      menuMusic.stop();
      startFlute();
      state = stateFlute;
    } else if (buttonCredit.over()) {
      clickButton.play();
      menuMusic.stop();
      startCredit();
      state = stateCredit;
    } else if (quitGame.over()) {
      clickButton.play();
      delay(280);
      exit(); 
    }
    break; 
  case stateHelp: 
     if (backMenu.over()) {
       clickButton.play();
       state = stateMenu;
    } 
    break;
   case statePause: 
    if (resumeGamePause.over()) {
      if (partie != null) {
          clickButton.play();
          menuMusic.stop();
          state = stateGame; 
          partie.pause = false;
        }else if(systemeDynamique != null){
          clickButton.play();
          menuMusic.stop();
          state = stateSystemeDynamique; 
        }else if(movie == true){
          clickButton.play();
          menuMusic.stop();
          video.loop();
          state = stateCredit; 
        } else if (flute == true) {
          clickButton.play();
          menuMusic.stop();
          startFlute();
          state = stateFlute;
        } else{
          clickButton.play();
          menuMusic.stop();
          state = stateMask;
          startMask();
        } 
    } else if (newGamePause.over()) {
      if (partie != null) {
          clickButton.play();
          menuMusic.stop();
          state = stateGame;
          startGame();
        }else if(systemeDynamique != null){
          clickButton.play();
          menuMusic.stop();
          state = stateSystemeDynamique; 
          startSystemeDynamique();
        }else if(movie == true){
          clickButton.play();
          menuMusic.stop();
          startCredit();
          state = stateCredit; 
        } else if (flute == true) {
          clickButton.play();
          menuMusic.stop();
          startFlute();
          state = stateFlute;
        } else{
          clickButton.play();
          menuMusic.stop();
          state = stateMask; 
          startMask();
        }      
    } else if (menuPause.over()) {
      clickButton.play();
      state = stateMenu;
      menuMusic.loop();
    }
    break;
   case stateEndGame: 
    if (newGameEndGame.over()) {
      clickButton.play();
      menuMusic.stop();
      state = stateGame;
      startGame();
    } else if (menuEndGame.over()) {
      clickButton.play();
      state = stateMenu;
      menuMusic.loop();
    }
    break;
    case stateSystemeDynamique:
     if (backMenu.over()) {
       clickButton.play();
       state = stateMenu;
    } 
    break;
    case stateMask:
     if (backMenu.over()) {
       clickButton.play();
       state = stateMenu;
    } 
      break;
    case stateCredit:
     if (backMenu.over()) {
       clickButton.play();
       state = stateMenu;
    } 
      break;
    case stateFlute:
     if (backMenu.over()) {
       clickButton.play();
       state = stateMenu;
    } 
    default:
      
    break;
  } 
}
