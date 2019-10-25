class Button {
  int x;
  int y;
  String text;
  
  Button(int x, int y, String text){
    this.x = x;
    this.y = y;
    this.text = text;
  }
  
  void draw(){
    fill(#7f6d5a, 0);
    
    if (over()) {
      fill(#69a210, 170);
    } 
    
    rect(x, y, textWidth(text), 40);
    fill(0);
    text(text, x, y + 30);
  }
  
  boolean over(){
    if (mouseX >= x && mouseY >= y && mouseX <= x + textWidth(text) && mouseY <= y + 30) {
      return true;
    } else {
        return false;
    }
  }
}
 
