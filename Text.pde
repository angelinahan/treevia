public class Text {
  String text;
  int xPos;
  int yPos;
  PImage img;
  
  //constructor
  Text(String text, int x, int y, PImage img) {
    this.text = text;
    this.xPos = x;
    this.yPos = y;
    this.img = img;
  }
  
  //Functions
  void displayImage(int x, int y){
    image(img, x, y);
  }
  
  //display
  void displayText(){
    //All formatting for text here
    fill(255);
    textSize(36);
    text(this.text, width/6, titleH, width/1.5, height/2);
  }
}
