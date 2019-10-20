boolean overStart = false;
boolean overSubmit = false;
boolean overNext = false;
boolean overRestart = false;

void startScreen() {
  //Display title
  textAlign(CENTER);
  image(bgImage, 0, 0);
  textSize(48);
  fill(100, 135, 80, 170);
  rect(0, titleH * 2, width, 100); 
  fill(255);
  text("Welcome to Treevia!", width/2, titleH * 2.5);
  textSize(36);
  text("Type the correct answer and hit submit. Hover over the image for a hint", width/2-240, titleH * 3, 480, 160);

  //Start button
  noStroke();
  fill(120, 155, 170);
  overStart = button(width/2, titleH * 5, 150, 75, "START");

  //Score and Q# displayed
  scoreAndQN();
}

void game() {
  //Active question and answer objects
  Question q = questions.get(activeQuestion);
  Answer a = answers.get(activeQuestion);

  //Display img
  if (showHint) {
    a.drawHint();
  } else {
    q.displayImage(width/3, height/3);
  }

  //Display text
  q.displayText();

  //Display typed answer
  textSize(24);
  text("your answer: " +guess, width/2-240, 3.5 * height / 5, 480, 160);

  //Display the submit button
  fill(0, 0, 120);
  overSubmit = button(width/2, titleH * 5, 150, 75, "Submit");

  //Score and Q# displayed
  scoreAndQN();
}

void feedbackScreen() {
  Answer a = answers.get(activeQuestion);

  //Display feedback
  //Check text box size for wrapping
  a.displayFeedback();

  a.displayImage(width/3, height/3);

  fill(120, 120, 0);
  overNext = button(width/2, titleH * 5, 200, 75, "Next Question");

  //Score and Q# displayed
  scoreAndQN();
}

void scoreAndQN() {
  int actualQN = activeQuestion+1;
  time = (millis() - prevTime) / 1000;
  textSize(28);
  fill(255);
  if (state!=0) {
    text("Question "+actualQN, 100, 40);
    text("Score: "+score, width-100, 40);
    text("Time passed: " +time, width - 150, 80);
  }
}

boolean button(int x, int y, int w, int h, String s) {
  rect(x-w/2, y-h/2, w, h);
  fill(255);
  textSize(28);
  text(s, x, y+10);

  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 &&
    mouseY < y+h/2) {
    //mouse is over the start button
    return true;
  } else {
    return false;
  }
}

void endScreen() {
  background(bgImage);
  text("Score: "+score, width-100, 40);
  text("Time passed: " +time, width - 150, 80);
  textSize(36);
  if (score > highScore) {
    text("New High Score! Previous high score: " +highScore, width/2, height/2);
    if (time < timeRecord) {
      text("New Record Time! Previous record: " +timeRecord, width/2, height/2 + 100);
    }
  } else {
    text("Game Over!", width/2, height/2);
  }
  fill(0, 125, 140);
  overRestart = button(width/2, titleH * 5, 150, 75, "RESTART");
}

void saveHighScores() {
  if (score > highScore || firstTime) {
    data.setInt("highScore", score);
    if (time < timeRecord || firstTime) {
      data.setInt("timeRecord", time);
    }
  }
  saveJSONObject(data, "data/treeQuiz.json");
  firstTime = false;
}
