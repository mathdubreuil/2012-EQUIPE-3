import java.util.TimerTask;

public class Temps extends TimerTask {
  public int conteur = 0;

  public void run() {
    System.out.println("temps : " + conteur++);
  }
  public int getTemps(){
    return this.conteur;
  }
}
