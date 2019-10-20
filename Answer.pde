public class Answer extends Text { //<>//
  String feedbackMsg;
  String hint;

  //constructor
  Answer(String ans, String hint, int x, int y, PImage img) {
    super(ans, x, y, img);
    this.hint = hint;
    feedbackMsg = "default";
  }

  void drawHint() {
    fill(100, 35, 45);
    rect(width/3, height/3, width/3, height/3);
    fill(255);
    text(this.hint, width/3, titleH * 2.5, width/3, height/3);
  }

  void checkAnswer() {
    if (text.equals(guess.toLowerCase())) {
      this.feedbackMsg = "Correct!";
      score+=100;
    } else {
      this.feedbackMsg = "Wrong!\nThe correct answer is " + text;
    }

    guess = "";
    state = 2;
  }

  void displayFeedback() {
    fill(255);
    textSize(36);
    text(this.feedbackMsg, width/2, titleH);
  }
}
