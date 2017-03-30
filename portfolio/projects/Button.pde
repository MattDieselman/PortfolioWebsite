public class Button {

  //Attributes
  PVector position;
  char axis;
  char increment;
  boolean pressed = false;
  int incrementAmount;

  //Constructor  
  public Button(int x, int y, char axis_, char increment_) {
    position=new PVector(x, y);
    axis=axis_;
    increment=increment_;
    if (increment=='-') {
      incrementAmount= -50;
    } else if (increment=='+') {
      incrementAmount=50;
    } else incrementAmount=0;
  }

  //Update method, calls draw and checks if button is pressed.
  public boolean update() {
    drawButtons();
    if (axis=='1'||axis=='2') {
      if(checkPressed(180));return true;
    } else {
      if(checkPressed(80));return true;
    }
  }

  void shoot() {
    if (currentBoard>1) {
      hit=false;
      for (PVector p : p1.shipPositions) {
        if (p.x==selection.x&&p.y==selection.y&&p.z==selection.z) {
          p2HitMarkers.add(new PVector(selection.x, selection.y, selection.z));
          hit=true; 
          p1.shipPositions.remove(p);
          break;
        }
      }
      if (!hit) {
        p2MissMarkers.add(new PVector(selection.x, selection.y, selection.z));
      }
      menu=true;
      board.drawMenu(hit);
    }              
    if (currentBoard<2) {
      hit=false;
      for (PVector p : p2.shipPositions) {
        if (p.x==selection.x&&p.y==selection.y&&p.z==selection.z) {
          p1HitMarkers.add(new PVector(selection.x, selection.y, selection.z));
          hit=true; 
          p2.shipPositions.remove(p);
          break;
        }
      }
      if (!hit) {
        p1MissMarkers.add(new PVector(selection.x, selection.y, selection.z));
      }                
      menu=true;
      board.drawMenu(hit);
    }
  }

  //Draw button method. Will draw the buttons.
  public void drawButtons() {
    textSize(22);
    //textFont(font);
    stroke(0);
    if (pressed) {
      fill(100);
    } else {
      fill(200);
    }
    rectMode(CORNER);
    if (axis!='1'&&axis!='2') {
      rect(position.x, position.y, 80, 80);
    } else {
      rect(position.x, position.y, 180, 180);
    }

    //rectMode(CENTER);
    textAlign(CENTER, CENTER);

    fill(0);
    if (axis=='x'||axis=='y'||axis=='z') {
      text((axis+" Axis"), position.x+40, position.y+55);
      text((increment), position.x+40, position.y+25);
    } else {
      switch(axis) {
      case 's':
        text("SHOOT", position.x+40, position.y+35);
        break;
      case 'n':
        text("Switch\nBoard", position.x+40, position.y+35);
        break;
      case '1':
        if (7-(p1.shipPositions.size())>0) {
          text("Player 1\nPlace Ship\nRemaining: "+(7-(p1.shipPositions.size())), position.x+90, position.y+85);
        } else {
          text("Press for\nPlayer 2", position.x+90, position.y+85);
        }
        break;
      case '2':
        if (7-(p2.shipPositions.size())>0) {
          text("Player 2\nPlace Ship\nRemaining: "+(7-(p2.shipPositions.size())), position.x+90, position.y+85);
        } else {
          text("Press to\nBegin Play", position.x+90, position.y+85);
        }
        break;
      }
    }
  }

  //Method that checks whether the user has pressed a button. Whill change the color of the button when hovered over.
  boolean checkPressed(int size) {
    if (mouseX>position.x&&mouseY>position.y&&mouseX<(position.x)+size&&mouseY<(position.y)+size) {
      pressed=true;
      if (mousePressed&&mouseButton==LEFT) {
        pressed=false;
        mousePressed=false;
        doAction();
      }
    } else {
      pressed = false;
    }
  }
}