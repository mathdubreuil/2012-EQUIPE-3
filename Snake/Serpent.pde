import java.util.ArrayList;
import java.util.List;

public class Serpent{
  float x;
  float y;
  float xspeed;
  float yspeed;
  int total;
  ArrayList<PVector> corps = new ArrayList<PVector>();
  ArrayList<String> formes = new ArrayList<String>();
  int scl = 40;

  public Serpent() {
    x = (width-200)/2;
    y = height/2;
    xspeed = 1;
    yspeed = 0;
    total = 0;
  }

  public void direction(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  public boolean mangerPomme(PVector pos){
    if (dist(x, y, pos.x, pos.y) < 1) {
      total++;
      formes.add(getNomForme());
      return true;
    } else {
      return false;
    }
  }
  
  public boolean mangerRoche(ArrayList<PVector> roches){
    for (PVector roche : roches) {
      if (dist(x, y, roche.x, roche.y) < 1) {
        corps.clear();
        formes.clear();
        return true;
      }
    }
    return false;
  }
  
  public boolean estmort() {
    for (int i = 0; i < corps.size(); i++) {
      PVector pos = corps.get(i);
      if (dist(x, y, pos.x, pos.y) < 1) {
        corps.clear();
        formes.clear();
        return true;
      }
    }
    if(dist(x, y, 40-scl, y) < 1){
      corps.clear();
      formes.clear();
      return true;
    }
    if(dist(x, y, x,40-scl) < 1){
      corps.clear();
      formes.clear();
      return true;
    }
    if(dist(x, y, width-40,y) < 1){
      corps.clear();
      formes.clear();
      return true;
    }
    if(dist(x, y, x,height-40) < 1){
      corps.clear();
      formes.clear();
      return true;
    }
    return false;
  }
  
  public void miseAjour() {
    if (total > 0) {
      if (total == corps.size() && !corps.isEmpty()) {
        corps.remove(0);
      }
      corps.add(new PVector(x, y));
    }
    
    x = x + xspeed*scl;
    y = y + yspeed*scl;

    x = constrain(x, 40-scl, width-40);
    y = constrain(y, 40-scl, height-40);
  }
  
  public void afficher() {
    fill(0,255,0);
    ellipse(x+(scl/2), y+(scl/2), scl, scl);
    for (int i = 0; i < corps.size(); i++) {
      //rect(corps.get(i).x, corps.get(i).y, scl, scl);
      genererForme(corps.get(i).x,corps.get(i).y,scl,formes.get(i));
    }
    
  }
  
  public float getX(){
    return this.x;
  }
  
  public float getY(){
    return this.y;
  }
  
  public ArrayList<PVector> getCorps(){
    return this.corps;
  }
  public String getNomForme(){
    
    switch((int)random(5)){
      case 0:
        return "triangle";
      case 1:
        return "rect";
      case 2:
        return "quad";
      case 3:
        return "ellipse";
      case 4:
        return "arc";    
    }
     return ""; 
  }
  
  public void genererForme(float x, float y, int scale, String nomForme){  
    switch(nomForme){
      case "triangle":
        triangle(x+(scale/2), y, x, y+scale, x+scale,y+scale);
        break;
      case "rect":
        rect(x, y, scale, scale);
        break;
      case "quad":
        quad((x+(scale/2))+(scale/4), y, (x+(scale/2))-(scale/4), y, x, y+scale, x+scale, y+scale);
        break;
      case "ellipse":
        ellipse(x+(scale/2), y+(scale/2), scale, scale);
        break;
      case "arc":
        arc(x+(scale/2), y+(scale/2), scale, scale, PI, TWO_PI);
        break;
    }
  }
}
