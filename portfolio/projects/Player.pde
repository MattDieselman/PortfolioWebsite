public class Player { 
  public ArrayList<PVector> shipPositions= new ArrayList<PVector>();

  void addShip() {
    if (shipPositions.size()>0) {
      for (PVector p : shipPositions) {
        if (p.x==selection.x&&p.y==selection.y&&p.z==selection.z) {
          return;
        }
      }
    }
    shipPositions.add(new PVector(selection.x, selection.y, selection.z));
  }
}