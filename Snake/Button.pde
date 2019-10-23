class Button {
  int x;
  int y;
  String label;
  
  Button(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  
  void draw(){
    fill(#7f6d5a);
    
    if (over()) {
      fill(#69a210);
    } 
    
    rect(x, y, textWidth(label), 40);
    fill(0);
    text(label, x, y + 30);
  }
  
  boolean over(){
    if (mouseX >= x && mouseY >= y && mouseX <= x + textWidth(label) && mouseY <= y + 30) {
      return true;
    } else {
        return false;
    }
  }
}
 
