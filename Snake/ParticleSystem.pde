import java.util.Iterator;

class ParticleSystem
{
  int index;

  int count;

  int activeParticleCount;

  float timeStart;
  float timeLastFrame;
  float timeElapsed;

  float timeScale = 1.0f;

  float probabilitySpawn;

  ArrayList<ParticleRain> system;

  ArrayList<ParticleRain> particleActive;
  ArrayList<ParticleRain> particleReady;

  Iterator<ParticleRain> iterator;

  Vector space;
  Vector origin;

  ParticleRain particle;

  ParticleSystem(int size)
  {
    count = size;
    init();
  }

  void init()
  {
    system = new ArrayList<ParticleRain>();

    particleActive = new ArrayList<ParticleRain>();
    particleReady = new ArrayList<ParticleRain>();

    origin = new Vector(width / 2.0f, height / 2.0f, 0.0f);
    space = new Vector();

    for (index = 0; index < count; ++index)
    {
     
      particle = new ParticleRain();
      probabilitySpawn = ParticleRain.probabilitySpawn;  
      
      particle.ps = this;
      particle.position.copy(origin);

      system.add(particle);
      particleReady.add(particle);
    }

    timeStart = millis();
    timeLastFrame = timeStart;
  }

  void update()
  {
    timeElapsed = (millis() - timeLastFrame) / 1000.0f;
    timeLastFrame = millis();

    emiter();

    activeParticleCount = particleActive.size();

    if (activeParticleCount > 0)
    {
      for (index = 0; index < particleActive.size(); ++index)
      {
        particle = particleActive.get(index);

        if (!particle.isExpired)
          particle.update();
        else
          recycle(particle);
      }

      iterator = particleActive.iterator();

      while (iterator.hasNext())
      {
        particle = iterator.next();

        if (!particle.isExpired)
          particle.render();
      }
    }
  }

  void add(float positionX, float positionY)
  {
    if (particleReady.size() > 0)
    {
      particle = particleReady.get(0);

      particle.init();

      particle.position.x = positionX;
      particle.position.y = positionY;

      particleReady.remove(0);
      particleActive.add(particle);
    }
    else
      print("particles system overload");
  }

  void emiter()
  {
    if (random(0.0f, 1.0f) < probabilitySpawn)
    {
      if (particleReady.size() > 0)
      {
        particle = particleReady.get(0);

        particle.init();

        particleReady.remove(0);
        particleActive.add(particle);
      }
      else
        print("sytem overload");
    }
  }

  void recycle(ParticleRain p)
  {
    particleActive.remove(p);
    particleReady.add(p);
  }

  void print(String tag)
  {
    println("particle system " + tag + " (" + particleActive.size() + " " + particleReady.size() + " " + count + ")");
  }
}
