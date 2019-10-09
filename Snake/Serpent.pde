import java.util.ArrayList;
import java.util.List;

public class Serpent{
  float x;
  float y;
  float xspeed;
  float yspeed;
  int total;
  ArrayList<PVector> corps = new ArrayList<PVector>();
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
      return true;
    } else {
      return false;
    }
  }
  
  public boolean mangerRoche(ArrayList<PVector> roches){
    for (PVector roche : roches) {
      if (dist(x, y, roche.x, roche.y) < 1) {
        corps.clear();
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
        return true;
      }
    }
    if(dist(x, y, 0-scl, y) < 1){
      corps.clear();
      return true;
    }
    if(dist(x, y, x,0-scl) < 1){
      corps.clear();
      return true;
    }
    if(dist(x, y, width-200,y) < 1){
      corps.clear();
      return true;
    }
    if(dist(x, y, x,height) < 1){
      corps.clear();
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

    x = constrain(x, 0-scl, width-200);
    y = constrain(y, 0-scl, height);
  }
  
  public void afficher() {
    fill(0,255,0);
    for (PVector v : corps) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
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
}
