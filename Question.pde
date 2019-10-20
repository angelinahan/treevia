public class  Question extends Text {
  int questionNumber;
  
  //constructor
  Question(String q, int x, int y, int number, PImage img) {
    super(q, x, y, img);
    this.questionNumber = number;
  }
}
