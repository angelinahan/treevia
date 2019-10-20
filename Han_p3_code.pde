/* //<>//
Project 3
 Angelina Han
 June 6 2019
 */

//Variables
ArrayList<Question> questions;
ArrayList<Answer> answers;
int state; //game state
int activeQuestion; //which question id is active
int titleH;
int score;
String guess;
PImage bgImage;
boolean showHint;
int highScore;
int timeRecord;
int time;
int prevTime;
boolean firstTime;
JSONObject data;

public void setup() {
  size(800, 800);
  titleH = height/6;
  firstTime = true;
  bgImage = loadImage("trees.jpeg");
  bgImage.resize(width, height);
  loadData();
  initVar();
}

public void draw() {
  background(40, 90, 80);
  switch(state) {
  case 0:
    startScreen();
    break;
  case 1:
    game();
    break;
  case 2:
    feedbackScreen();
    break;
  case 3:
    endScreen();
    break;
  }
}

//initializes variables for the start of the game
void initVar() {
  this.state = 0; //game state
  this.activeQuestion = 0; //which question id is active
  this.score = 0;
  this.guess = "";
  this.showHint = false;
  this.time = 0;
  this.prevTime = millis();
  this.highScore = data.getInt("highScore");
  this.timeRecord = data.getInt("timeRecord");
}

//Create array lists of objects and load external data
void loadData() {
  data = loadJSONObject("treeQuiz.json");

  questions = new ArrayList();
  answers = new ArrayList();

  JSONArray qnas = data.getJSONArray("qnas");

  for (int i = 0; i < qnas.size(); i++) {
    JSONObject qna = qnas.getJSONObject(i);
    String qText = qna.getString("qText");
    int id = qna.getInt("id");
    String ans = qna.getString("ans");
    String hint = qna.getString("hint");

    PImage img = loadImage(qna.getString("img"));
    img.resize(width/3, height/3);

    Question q = new Question(qText, width/2, height/2, id, img);
    Answer a = new Answer(ans, hint, width/2, height/2, img);

    questions.add(q);
    answers.add(a);
  }
}

void mouseClicked() {
  if (overStart && state == 0) {
    initVar();
    state = 1; //move to the game state
  } else if (overSubmit && state == 1) {
    answers.get(activeQuestion).checkAnswer();
    state = 2;
    overSubmit = false;
  } else if (overNext && state == 2) {
    if (activeQuestion < questions.size() - 1) {
      activeQuestion++;
      state = 1; //back to game
    } else {
      state = 3;
    }
  } else if (overRestart && state == 3) {
    saveHighScores();
    state = 0;
  }
}

void keyTyped() {
  if (key != BACKSPACE) {
    guess = guess+key;
  } else if (guess.length() > 0) {
    guess = guess.substring(0, guess.length()-1);
  }
}

void mouseMoved() {
  if (mouseX > width/3 && mouseX < 2*width/3 && mouseY > height/4 && mouseY < 7*height/12) {
    this.showHint = true;
  } else {
    this.showHint = false;
  }
}
