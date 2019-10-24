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
  PImage UI = loadImage("grass_BG_UI.png");
  int cols = (width-40)/scl;
  int rows = (height-40)/scl;
  
  public Partie() {
    nouvellePartie();
  }

  public void nouvellePartie() {
    frameRate(10);
    UI.resize(1000, 840);
    partiefini = false;
    pointage = 0;
    initialiserGrilleJeux();
    serpent = new Serpent(); 
    imagePomme.resize(scl, scl);
    imageRoche.resize(scl, scl);
    nouvellePomme();
    temps = new Timer("conteurTemps");
    conteurTemps = new Temps();
    temps.schedule(conteurTemps, 0, 1000);
  }

  public void finPartie() {
    this.temps.cancel();
    this.temps.purge();
    roches.clear();
    partiefini = true;
  }
  
  void nouvellePomme() {
    boolean emplacementLibre = false;
    float xPomme = 0;
    float yPomme = 0;
    while(!emplacementLibre){
      xPomme = constrain(floor(random(cols)), 1, cols);
      yPomme = constrain(floor(random(rows)), 1, rows);
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
        xRoche = constrain(floor(random(cols)), 1, cols);
        yRoche = constrain(floor(random(rows)), 1, rows);
        if(grilleJeux[(int)(xRoche/scl)][(int)(yRoche/scl)] == false){
          emplacementLibre = true;
          grilleJeux[(int)(xRoche/scl)][(int)(yRoche/scl)] = false;
        }  
      }
      roches.add( new PVector(xRoche, yRoche));
      roches.get(roches.size() - 1).mult(scl);
    }
  }

  public void dessinerJeux() {
    if (serpent.mangerPomme(pomme)) { 
      mangerPomme.play();
      nouvellePomme();
      nouvelleRoche();
    }
    if (serpent.estmort() || serpent.mangerRoche(roches)) {
      mangerRocheMur.play();
      finPartie();  
    } else{
      initialiserGrilleJeux();
      serpent.miseAjour();
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
      image(UI,0,-40);
      fill(255);
      textSize(16);
      textAlign(LEFT);
      text("Temps : " + conteurTemps.getTemps(), 150, 20);
      text("Pointage : " + serpent.total, width-300, 20);
    }    
  }
  
  public void toucheAppuyer() {
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
