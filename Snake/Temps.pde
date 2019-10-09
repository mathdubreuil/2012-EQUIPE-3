import java.util.TimerTask;

public class Temps extends TimerTask {
  public int conteur = 0;

  public void run() {
    conteur++;
  }
  public int getTemps(){
    return this.conteur;
  }
}
