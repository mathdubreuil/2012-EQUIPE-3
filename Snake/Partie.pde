import java.util.Timer;
public class Partie {
  int pointage;
  Timer temps;
  Temps conteurTemps;
  Serpent serpent;
  int scl = 40;
  PVector pomme;
  ArrayList<PVector> roches = new ArrayList<PVector>();
  boolean[][] grilleJeux;
  boolean pause = false;
  boolean partiefini = false;
  int derniereToucheAppuyer = 39;
  PImage imagePomme = loadImage("Pomme.png");
  PImage imageRoche = loadImage("Roche.png");
  int cols = (width-200)/scl;
  int rows = height/scl;
  
  public Partie() {
    nouvellePartie();
  }

  public void nouvellePartie() {
    frameRate(10);
    partiefini = false;
    pointage = 0;
    initialiserGrilleJeux();
    serpent = new Serpent(); 
    imagePomme.resize(scl, scl);
    imageRoche.resize(scl, scl);
    nouvellePomme();
    System.out.println("Nouvelle partie");
    temps = new Timer("conteurTemps");
    conteurTemps = new Temps();
    temps.schedule(conteurTemps, 0, 1000);
  }

  public void finPartie() {
    this.temps.cancel();
    this.temps.purge();
    roches.clear();
    partiefini = true;
    System.out.println("Partie fini!!");
  }
  
  void nouvellePomme() {
    boolean emplacementLibre = false;
    float xPomme = 0;
    float yPomme = 0;
    while(!emplacementLibre){
      xPomme = floor(random(cols));
      yPomme = floor(random(rows));
      if(grilleJeux[(int)(xPomme/scl)][(int)(yPomme/scl)] == false){
        emplacementLibre = true;
      }  
    }
    pomme = new PVector(xPomme, yPomme);
    pomme.mult(scl);
  }
  void nouvelleRoche() {
    if((serpent.total % 2) == 0 && serpent.total != 0){
      boolean emplacementLibre = false;
      float xRoche = 0;
      float yRoche = 0;
      while(!emplacementLibre){
        xRoche = floor(random(cols));
        yRoche = floor(random(rows));
        if(grilleJeux[(int)(xRoche/scl)][(int)(yRoche/scl)] == false){
          emplacementLibre = true;
        }  
      }
      roches.add( new PVector(xRoche, yRoche));
      roches.get(roches.size() - 1).mult(scl);
    }
  }

  public void dessinerJeux() {
    if (serpent.mangerPomme(pomme)) {
      nouvellePomme();
      nouvelleRoche();
    }
    if (serpent.mangerRoche(roches)) {
      finPartie();
    }
    if (serpent.estmort()){
      finPartie();
    }
    serpent.miseAjour();
    initialiserGrilleJeux();
    if((int)(serpent.getX()/scl) == -1){
      grilleJeux[0][(int)(serpent.getY()/scl)] = true;
    }
    else if((int)(serpent.getY()/scl) == -1){
      grilleJeux[(int)(serpent.getX()/scl)][0] = true;
    }
    else if((int)(serpent.getY()/scl) == -1 && (int)(serpent.getY()/scl) == -1){
      grilleJeux[0][0] = true;
    }
    else{
      grilleJeux[(int)(serpent.getX()/scl)][(int)(serpent.getY()/scl)] = true;
    } 
    for (PVector corp : serpent.getCorps()) {
      grilleJeux[(int)(corp.x/scl)][(int)(corp.y/scl)] = true;
    }
    grilleJeux[(int)(pomme.x/scl)][(int)(pomme.y/scl)] = true;   
    for (PVector roche : roches) {
      grilleJeux[(int)(roche.x/scl)][(int)(roche.y/scl)] = true;
    }
    
    serpent.afficher();
    
    image(imagePomme, pomme.x, pomme.y);
    for (PVector roche : roches) {
      image(imageRoche, roche.x, roche.y);
    }
    fill(0);
    rect(width-200, 0, 200, height);
    fill(255);
    textSize(16);
    textAlign(LEFT);
    text("Temps : " + conteurTemps.getTemps(), width-150, 100);
    text("Pointage : " + serpent.total, width-150, 400);
  }
  
  public void toucheAppuyer(int x, int y) {
    if (keyCode == UP) {
      serpent.direction(0, -1);
    } else if (keyCode == DOWN) {
      serpent.direction(0, 1);
    } else if (keyCode == RIGHT) {
      serpent.direction(1, 0);
    } else if (keyCode == LEFT) {
      serpent.direction(-1, 0);
    }
  }
  
  public boolean enJeux(){
    if(!pause){
      return true;
    }else{
      return false;
    }
  }
  
  public void initialiserGrilleJeux(){
    grilleJeux = new boolean[cols+1][rows+1];
    for (int i = 0;i < grilleJeux.length; i++) {
       for (int j = 0;j < grilleJeux[i].length;j++) {
          grilleJeux[i][j] = false;
       }
    }
  }
  
}
