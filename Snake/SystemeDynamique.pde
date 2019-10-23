public class SystemeDynamique {
  // paramètres
  int count = 200;
  
  float boidRadius = 1.0f;
  
  float boidMaxspeed = 7.0f;
  float boidMaxforce = 0.01f;
  
  float boidThresholdSeparation = 50.0f;
  float boidThresholdCohesion = 50.0f;
  float boidThresholdAligment = 50.0f;
  
  float boidWeightSeparation = 0.90f;
  float boidWeightCohesion = 1.40f;
  float boidWeightAligment = 0.10f;
  
  // variables
  Crowd crowd;
  Boid boid;
  
  public SystemeDynamique() {
    nouveauSystemeDynamique();
  }
  
  public void nouveauSystemeDynamique() {
    frameRate(60);
    noStroke();
    rectMode(CORNER);
    
    // instanciation du groupe de boids
    crowd = new Crowd();
  
    // initialisation du groupe de boids
    for (int i = 0; i < count; ++i)
    {
      // instanciation d'un nouveau boid
      boid = new Boid(width / 2.0f, height / 2.0f);
  
      // configuration du nouveau boid
      configuration(boid);
  
      // ajouter le nouveau boid au groupe de boids
      crowd.add(boid);
    }
  }
  
  // fonction de configuration d'un nouveau boid selon les paramètres du programme
  void configuration(Boid b)
  {
    // propriétés
    b.radius = boidRadius;
    b.maxspeed = boidMaxspeed;
    b.maxforce = boidMaxforce;
  
    // valeurs des seuils des différents comportements
    b.thresholdCohesion = boidThresholdCohesion;
    b.thresholdAligment = boidThresholdAligment;
    b.thresholdSeparation = boidThresholdSeparation;
  
    // valeurs de pondération des différents comportements
    b.weightSeparation = boidWeightSeparation;
    b.weightCohesion = boidWeightCohesion;
    b.weightAligment = boidWeightAligment;
  }
  
  public void dessinerSystemeDynamique() {
    fade(1);
    
    // mise à jour du système de boids
    crowd.update();
  
    // rendu du système de boids
    crowd.render();
  }
  void fade(float decay)
  {
    fill(0,0,0, decay);
    rect(0, 0, width, height);
  }
}
