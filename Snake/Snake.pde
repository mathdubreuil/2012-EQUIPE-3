void setup() {
  Partie partie = new Partie();
  partie.dessinerJeux();
  
  while(partie.conteurTemps.getTemps() <= 5){}
  partie.finPartie();
}

void draw() {
  
}
