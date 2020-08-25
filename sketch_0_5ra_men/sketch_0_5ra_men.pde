boolean title = true;
int gameNo;
//timer

int best_timer = MAX_INT;
boolean finish_timer;
boolean isInsideStop_timer;
boolean isInsideTitle_timer;

//sort
int time_sort = 0;
int point_sort = 0;
boolean bottom = false;
boolean click = false;
boolean finish_sort;
boolean inside_sort;

void title_display() {
  background(255);
  fill(255);
  rect(300, 500, 400, 150);
  fill(0);
  textSize(70);
  textAlign(CENTER);
  text("4つのゲームが", width/2, 150);
  text("ランダムで出るよ!", width/2, 350);
  text("スタート", width/2, 600);
}

class Timer {
  private int time = 6000;

  void display_timer() {
    background(255);
    int x = width/2-100, x2 = width/2+100, y = height/2+130, y2 = height/2+230;

    if (time > 5500) {
      fill(0, 0, 255);
      textSize(150);
      textAlign(CENTER);
      if (time%100 == 0) {
        text(time/100+":00", width/2, height/2);
      } else if (time%100 < 10) {
        text(time/100+":0"+time%100, width/2, height/2);
      } else {
        text(time/100+":"+time%100, width/2, height/2);
      }
    } else {
      fill(0, 0, 255);
      textSize(150);
      textAlign(CENTER);
      text("??:??", width/2, height/2);
    }

    display_stopbutton();
  }

  private void display_stopbutton() {
    fill(200);
    rect(width/2-100, height/2+130, 200, 100);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("STOP", width/2, height/2+200);

    isInsideStop_timer = mouseX>width/2-100 && mouseX<width/2+100 
      && mouseY>height/2+130 && mouseY<height/2+230;
  }

  private boolean isbest() {
    if (time <= best_timer) {
      best_timer = time;
      return true;
    }
    return false;
  }

  void display_score() {
    background(255);

    if (isbest()) {
      fill(0);
      textSize(70);
      textAlign(CENTER);
      text("New Best!!", 300, 150);
    }

    fill(0, 0, 255);
    textSize(150);
    textAlign(CENTER);
    if (time%100 == 0) {
      text(time/100+":00", width/2, height/2);
    } else if (time%100 < 10) {
      text(time/100+":0"+time%100, width/2, height/2);
    } else {
      text(time/100+":"+time%100, width/2, height/2);
    }

    fill(0);
    textSize(70);
    textAlign(CENTER);
    if (time%100 == 0) {
      text("Best : "+best_timer/100+":00", width/2, height/2+130);
    } else if (time%100 < 10) {
      text("Best : "+best_timer/100+":0"+best_timer%100, width/2, height/2+130);
    } else {
      text("Best  :  "+best_timer/100+":"+best_timer%100, width/2, height/2+130);
    }

    display_titlebotton();
  }

  private void display_titlebotton() {
    fill(200);
    rect(width/2-180, height/2+180, 360, 100);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("title page", width/2, height/2+250);

    isInsideTitle_timer = mouseX>width/2-180 && mouseX<width/2+180 
      && mouseY>height/2+180 && mouseY<height/2+280;
  }

  void timekeep() {
    time -= 1;

    if (time < -3000) {
      finish_timer = true;
    }
  }
}

//sort
class Sort {

  private void result_display() {
    background(255);
    fill(0);
    textSize(150);
    textAlign(CENTER);
    text("point" + point_sort, width/2, height/2+130);

    back_title();
  }

  private void back_title() {
    fill(200);
    rect(width/2-180, height/2+180, 360, 100);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("title page", width/2, height/2+250);
    inside_sort = mouseX>width/2-180 && mouseX<width/2+180 
      && mouseY>height/2+180 && mouseY<height/2+280;
  }

  private void finish_Sort() {
    if (time_sort >= 9000) {
      finish_sort = true;
    }
  }

  void createButton() {
    fill(255, 0, 0);
    rect(250, 550, 150, 150);
    fill(0, 255, 0);
    rect(600, 550, 150, 150);
    fill(255);
    text("L", 350, 620);
    text("R", 620, 620);
  }

  void createArea() {
    fill(255, 0, 0);
    rect(0, 200, 200, 200);
    fill(0, 255, 0);
    rect(800, 200, 200, 200);
  }

  void drawText(int point) {
    fill(0);
    textSize(30);
    text("points" + point_sort, 80, 30);
  }
}

class Target {
  private int x;
  private int y;
  private int size = 30;
  private color targetcolor;
  private color button;

  Target(int x0, int y0) {
    x = x0;
    y = y0;
    if (int(random(0, 2)) == 0) {
      targetcolor = color(255, 0, 0);
    } else {
      targetcolor = color(0, 255, 0);
    }
  }
  
  private void display_sort() {
    if (bottom == false && click == false) {
      ellipse(x, y+(size/2), size, size);
    }
  }

  private boolean judgeColor(color targetcolor) {
    if (button == targetcolor) {
      point_sort++;
      textSize(30);
      text("nice!", 460, 650);
    } else {
      point_sort--;
      textSize(30);
      text("bad", 460, 650);
    }
    return true;
  }

  private void createTarget() {
    fill(targetcolor);
    display_sort();
    if (mousePressed) {
      if ((mouseX >= 250 && mouseX <= 400) && (mouseY >= 550 && mouseY <= height)) {
        button = color(255, 0, 0);
      } else if ((mouseX >= 600 && mouseX <= 750) && (mouseY >= 550 && mouseY <= height)) {
        button = color(0, 255, 0);
      }
      click = judgeColor(targetcolor);
    }
  }

  private void moveTarget() {
    if (time_sort < 3000) {
      y += 2;
    } else if (time_sort < 6000) {
      y += 4;
    } else {
      y += 7;
    }

    if (y + size >= height) {
      bottom = true;
    }
  }
}

Timer t;
Sort s;
Target st;

void setup() {
  size(1000, 700);
  frameRate(100);
  bottom = true;
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  t = new Timer();
  s = new Sort();
}

void draw() {
  background(255);
  if (title) {
    title_display();
  } else {
    switch(gameNo) {
    case 0:
      if (!finish_timer) {
        t.display_timer();
        t.timekeep();
      } else {
        t.display_score();
      }
      break;
    case 1:
    if(!finish_sort) {
        if (bottom == true || click == true) {
        bottom = false;
        click = false;
        st= new Target(500, 0);
      }
      time_sort += 1;
      s.createArea();
      s.createButton();
      s.drawText(point_sort);
      st.createTarget();
      st.moveTarget();
      s.finish_Sort();
      } else {
        s.result_display();
      }
      break;
    case 2:
      println("syori2");
      break;
    case 3:
      println("syori3");
      break;
    }
  }
}

void mouseClicked() {
  if (title) {
    if (mouseX > 300 && mouseX < 700 && mouseY > 500 && mouseY < 650) {
      gameNo = 1;//int(random(4));
      title = false;
    }
  } else if (!finish_timer) {
    if (isInsideStop_timer) {
      finish_timer = true;
    }
  } else if (isInsideTitle_timer) {
    t = new Timer();
    title = true;
  } 
  if (inside_sort) {
    s = new Sort();
    title = true;
  }
}
