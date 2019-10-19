public class Transformation{
  PImage imageSource, imageMask, imageTransformer;
  int activeFilterMode = 0;
  public Transformation(PImage imageSource, PImage imageMask){
    this.imageSource = imageSource;
    this.imageMask = imageMask;
    this.imageTransformer = imageSource;
     nouvelleTranformation();
  }
  
  public void nouvelleTranformation(){
    frameRate(60);
  }
  
  public void dessinerTransformation(){
    
  }
  
  void keyPressed(){
      
  }
}
