import java.util.ArrayList;
import java.util.List;

public class Serpent implements ElementJeux{
  List<MembreSerpent> membreSerpent;
  MembreSerpent tete;
  MembreSerpent corps;
  MembreSerpent queue;

  public Serpent() {
    nouveauSerpent();
  }

  public void nouveauSerpent() {
    membreSerpent = new ArrayList<MembreSerpent>();
    tete = new Tete();
    corps = new Corps();
    queue = new Queue();
    membreSerpent.add(tete);
    membreSerpent.add(corps);
    membreSerpent.add(queue);
  }

  public void ajoutCorpsSerpent() {
    membreSerpent.add(new Corps());
  }

  public void dessinerElement(int x, int y, String orientation) {
    // À faire
  }

  public void deplacement(){
    // À faire
  }

  public void collisions(){
    // À faire
  }

  public void tirerLangue(){
    // À faire
  }
}
