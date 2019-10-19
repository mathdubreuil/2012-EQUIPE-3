class ParticleRain {
  final static float probabilitySpawn = 0.90f;
  color colorDiffuse;
  color colorFinal;
  ParticleSystem ps;
  Vector position;
  boolean isExpired;
  float lifetime;
  float timer;
  float timeStart;
  float timeFrame;
  float timeElapsed;
  float timeActive;

  ParticleRain() {
    position = new Vector();

    isExpired = true;
    colorDiffuse = #0000ff;
    colorFinal   = #000044;

    lifetime = 3.0f;
  }
  
  void setPosition(float x, float y, float z)
  {
    position.x = x;
    position.y = y;
    position.z = z;
  }

  void randomize(float x, float y, float z)
  {
    position.x = constrain(floor(random(width)), 80, width-40);
    position.y = constrain(floor(random(height)), 80, height-40);
    position.z = random(0.0f, 1.0f) * z - z / 2.0f;
  }
  
  

  void init()
  {
    isExpired = false;
    timer = 0;
    timeStart = millis();
    timeFrame = timeStart;
    timeActive = 0;
    
    ps.space.x = width;
    ps.space.y = height;

    position.x = ps.origin.x + random(0.0f, 1.0f) * ps.space.x - ps.space.x / 2.0f;
    position.y = ps.origin.y + random(0.0f, 1.0f) * ps.space.y - ps.space.y / 2.0f;
  }

  void update()
  {
    timeElapsed = (millis() - timeFrame) / 1000.0f;
    timer += timeElapsed;

    if (timer > lifetime)
      isExpired = true;

    timeFrame = millis();
    timeActive = timeFrame - timeStart;

    position.x += (random(0.0f, 2.0f) * 512.0f - 256.0f) * timeElapsed;
    position.y += (random(0.0f, 5.0f) * 512.0f - 256.0f) * timeElapsed;
  }

  void render()
  {
    fill(
    lerpColor(colorDiffuse, colorFinal, timeActive / (lifetime * 75.0f)));
    ellipse(position.x, position.y, 5, 5);
  }
}
