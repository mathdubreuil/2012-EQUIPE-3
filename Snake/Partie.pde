import java.util.Timer;
public class Partie {
  int pointage;
  Timer temps;
  Temps conteurTemps;
  Serpent serpent;
  ElementJeux[][] grilleJeux;

  public Partie() {
    nouvellePartie();
  }

  public void nouvellePartie() {
    System.out.println("Nouvelle partie");
    pointage = 0;
    temps = new Timer("conteurTemps");
    conteurTemps = new Temps();
    temps.schedule(conteurTemps, 0, 1000);
    grilleJeux = new ElementJeux[30][30];
    serpent = new Serpent();
    grilleJeux[15][15] = (ElementJeux) serpent.tete;
    grilleJeux[3][3] = new Pomme();
    grilleJeux[10][10] = new Roche();
  }

  public void finPartie() {
    this.temps.cancel();
    this.temps.purge();
    System.out.println("Partie fini!!");
  }

  public void dessinerJeux() {
    // À changer, juste pour test
    for (int i = 0; i < grilleJeux.length; i++) {
      for (int j = 0; j < grilleJeux.length; j++) {
        if (grilleJeux[i][j] != null) System.out.print(grilleJeux[i][j]);
        else System.out.print(0);
      }
      System.out.println("");
    }
  }
}
