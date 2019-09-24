public class Tete implements MembreSerpent, ElementJeux {
  String orientation;

  public Tete() {
    orientation = "N";
  }

  public String getOrientation() {
    return this.orientation;
  }

  public void setOrientation(String orientation) {
    this.orientation = orientation;
  }

  public void dessinerElement(int x, int y, String orientation) {
    // À faire
  }
}
