Partie partie;
PImage fond;

void setup() {
  size(1000, 800);
  fond = loadImage("snake_BG.jpg");
  fond.resize(1000, 800);
  partie = new Partie();
   
}

void draw() {
  background(fond);
  if(!partie.partiefini){
    partie.dessinerJeux();
  }
}

void keyPressed() {
  if(partie.enJeux()){
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
  if(partie.partiefini){
    if (keyCode == UP) {
      partie.nouvellePartie();
    } else if (keyCode == DOWN) {
      partie.nouvellePartie();
    } else if (keyCode == RIGHT) {
      partie.nouvellePartie();
    } else if (keyCode == LEFT) {
      partie.nouvellePartie();
    }
  }
}
