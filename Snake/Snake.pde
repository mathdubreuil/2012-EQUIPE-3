import processing.sound.*;
import processing.video.*;

final int stateGame = 0;
final int stateMenu = 1;
final int stateHelp = 2;
final int statePause = 3;
final int stateEndGame = 4;

int state = stateMenu;
float angle = 0; 

Partie partie = null;
SystemeDynamique systemeDynamique = null;
ParticleSystem particleSystem = null;
int countParticles = 250;
int currentScore = 0;
SoundFile mangerPomme;
SoundFile mangerRocheMur;
SoundFile clickButton;
SoundFile menuMusic;

Movie video;

PImage fond;
PImage imageMask;
PImage imageTransformer;
PImage imageSource;
PImage snakeBody;
PImage snakeHead;
PImage rock;
PImage apple;

Button newGame;
Button help;
Button quitGame;
Button backMenu;

Button newGamePause;
Button resumeGamePause;
Button menuPause;

Button newGameEndGame;
Button menuEndGame;

boolean movie = false;
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
  
  snakeBody = loadImage("Serpent_corps.png");
  snakeBody.resize(868, 420);
  snakeHead = loadImage("Serpent_tête.png");
  snakeHead.resize(362, 313);
  rock = loadImage("Roche.png");
  rock.resize(209, 163);
  apple = loadImage("Pomme.png");
  apple.resize(185, 219);
  
  clickButton = new SoundFile(this, "click.mp3");
  
  menuMusic = new SoundFile(this, "menu_music.mp3");
  menuMusic.loop();
}

void draw() {
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
  default:
    break;
  }  
}

void drawForEnd() {
  
  fill(#6c5f48, 30);
  rect(width/2 - 200, height/2 - 150, 400, 300, 7);
  textSize(60);
  fill(0);

  String endGameTitle = " JEU TERMINÉ ";
  text(endGameTitle, width/2 - textWidth(endGameTitle)/2, height/2 - 80);
  textSize(28);
  
  String newGameText =  "   Nouvelle partie   ";
  newGameEndGame = new Button((int)(width/2 - textWidth(newGameText)/2), height/2 - 40 , newGameText);
  newGameEndGame.draw();
  
  String menuText =  "   Menu principale   ";
  menuEndGame = new Button((int)(width/2 - textWidth(menuText)/2), height/2 + 20, menuText);
  menuEndGame.draw();
}


void drawForPause() {
  
  fill(#6c5f48, 30);
  rect(width/2 - 200, height/2 - 175, 400, 350, 7);
  textSize(60);
  fill(0);

  String pauseTitle = " PAUSE ";
  text(pauseTitle, width/2 - textWidth(pauseTitle)/2, height/2 - 100);
  textSize(28);

  String resumeGameText =  "   Reprendre la partie   ";
  resumeGamePause = new Button((int)(width/2 - textWidth(resumeGameText)/2), height/2 - 60, resumeGameText);
  resumeGamePause.draw();
  
  String newGameText =  "   Nouvelle partie   ";
  newGamePause = new Button((int)(width/2 - textWidth(newGameText)/2), height/2 + 10, newGameText);
  newGamePause.draw();
  
  String menuText =  "   Menu principale   ";
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
  
  if (systemeDynamique != null) {
    systemeDynamique.dessinerSystemeDynamique();
  }
  
  if (movie == true) {
    image(video, 0, 0, 1000, 800);
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

void drawForHelp() {
  background(0);
  image(fond, 0, 0);
  strokeWeight(1);

  String backText =  "  Retour  ";
  backMenu = new Button(50, 50, backText);
  backMenu.draw();
  
  textSize(80);

  String title = "COMMENT JOUER ?";
  text(title, width/2 - textWidth(title)/2, 200);
  strokeWeight(5);
  line(120, 250 , width - 120, 250);
  
  textSize(22);
  String intro = "Déplacer le serpent pour manger les pommes! Éviter les obstables et les murs!";
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
  image(fond, 0, 0);
  textSize(150);
  fill(0);

  String title = "SNAKE";
  text(title, width/2 - textWidth(title)/2, 200);
  
  textSize(28);
  strokeWeight(1);

  String newGameText =  "   Nouvelle Partie   ";
  newGame = new Button((int)(width/2 - textWidth(newGameText)/2), 240, newGameText);
  newGame.draw();
  
  String helpText =  "   Comment Jouer   ";
  help = new Button((int)(width/2 - textWidth(helpText)/2), 300, helpText);
  help.draw();
  
  String quitText = "   Quittez   ";
  quitGame = new Button((int)(width/2 - textWidth(quitText)/2), 360, quitText);
  quitGame.draw();

  image(apple, 50, height - 770);
  image(apple, width - 50 - apple.width, height - 770);

  image(snakeBody, 200, 400);

  if (angle >= 0) {
    angle -= 0.005;
  } else if (angle < 0) {
    angle += 0.005;
  }
  delay(100);
  rotate(angle);
  image(snakeHead, 200 - snakeHead.width/2, 440 - snakeHead.height/2);

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
  particleSystem = new ParticleSystem(countParticles);
  partie = new Partie();
}

void keyPressed() {
  if (state == stateGame) {
    switch(key){
      case '1':
        startGame();
        break;
      case '2':
        tint(255, 255, 255, 255);
        background(fond);
        particleSystem = null;
        partie = null;
        movie = false;
        activeFilterMode = 0;
        systemeDynamique = new SystemeDynamique();
        break;  
      case '3':
        particleSystem = null;
        partie = null;
        systemeDynamique = null;
        movie = false;
        tint(0, 255, 0, 200);
        background(imageSource);
        imageTransformer.mask(imageMask);
        activeFilterMode = 0;  
        image(imageTransformer, 0, 0);
        break;  
      case '4':
        frameRate(60);
        tint(255, 255, 255, 255);
        particleSystem = null;
        partie = null;
        systemeDynamique = null;
        activeFilterMode = 0;  
        video.loop();
        movie = true;
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
        if (partie != null) { // TO REMOVE (creates error when you press P if you press on 2 3 4 since the game is null)
          state = statePause;
          partie.pause = true;
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
  case stateGame:
    break;
  case stateMenu:
    if (newGame.over()) {    
      clickButton.play();
      menuMusic.stop();
      state = stateGame;
      startGame();
    } else if (help.over()) {
      clickButton.play();
      state = stateHelp;
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
      clickButton.play();
      state = stateGame; 
      partie.pause = false;
    } else if (newGamePause.over()) {
      clickButton.play();
      menuMusic.stop();
      state = stateGame;
      startGame();
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
  default:
    break;
  } 
}
