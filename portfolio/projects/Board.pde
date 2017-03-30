public class Board {

  public void drawMenu(boolean hit) {
    switch(currentBoard) {
    case 0:
    case 1:
      if (hit) {
        text("HIT", width/2, (height/2)-50);
      }      
      if (!hit) {
        text("MISS", width/2, (height/2)-50);
      }

      text("Player 1 Turn Over.", width/2, height/2);      
      text("Time Till Player 2: "+menuTimer, width/2, (height/2)+50);

      menuTimer-=1;
      if (menuTimer<=0) {
        currentBoard=2;
        menu=false;
      }
      break;
    case 2:
    case 3:      
      if (hit) {
        text("HIT", width/2, (height/2)-50);
      }      
      if (!hit) {
        text("MISS", width/2, (height/2)-50);
      }

      text("Player 2 Turn Over.", width/2, (height/2));
      text("Time Till Player 1: "+menuTimer, width/2, (height/2)+50);

      menuTimer-=1;
      if (menuTimer<=0) {
        currentBoard=0;
        menu=false;
      }
      break;
    }
    if (menu==false) {
      menuTimer=300;
    }
  }
  //Method that is used to draw the actual board
  public void drawBoard(int boardNum) {
    if (mousePressed&&mouseButton==RIGHT) {
      roty += ((mouseX-pmouseX)/800.0);
      rotx += ((pmouseY-mouseY)/800.0)/2;
    }
    fill(0);
    text("Showing Board: "+currentBoard, width-100, 25);
    //Translate & Rotate canvas
    pushMatrix();
    translate(width/2, (height/2)+25, 0); 
    scale(zoom);
    rotateX(rotx);
    rotateY(roty);

    //Draw Board lines
    line(-200, 0, 200, 0);
    line(0, 200, 0, -200);
    line(0, 0, -200, 0, 0, 200);
    for (int i=0; i<9; i++) {
      for (int j=-200; j<=200; j+=100) {
        stroke(0, 0, 255, 60);
        line(axis[i], 0, j, axis[i], 200, j); 
        line(axis[i], j, 0, axis[i], j, 200); 
        line(0, axis[i], j, 200, axis[i], j); 
        line(j, axis[i], 0, j, axis[i], 200);
        line(0, j, axis[i], 200, j, axis[i]); 
        line(j, 0, axis[i], j, 200, axis[i]);
        line(axis[i], 0, j, axis[i], -200, j); 
        line(axis[i], j, 0, axis[i], j, -200); 
        line(0, axis[i], j, -200, axis[i], j); 
        line(j, axis[i], 0, j, axis[i], -200);
        line(0, j, axis[i], -200, j, axis[i]); 
        line(j, 0, axis[i], j, -200, axis[i]);
      }
    }    

    //Board 0 (Player 1's view of the enemy)
    if (boardNum==0) {
      if (p1HitMarkers!=null) {
        for (PVector p : p1HitMarkers) { 
          pushMatrix();
          fill(0, 255, 0, 50);
          translate(p.x, p.y, p.z);
          box(50); 
          popMatrix();
        }
      }
      if (p1MissMarkers!=null) {
        for (PVector p : p1MissMarkers) {
          fill(0, 0, 255, 50);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }
    }    
    if (boardNum==1) {
      if (p1.shipPositions.size()>0) {
        for (PVector p : p1.shipPositions) {
          fill(100);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }      
      if (p2HitMarkers!=null) {
        for (PVector p : p2HitMarkers) { 
          pushMatrix();
          fill(0, 255, 0, 50);
          translate(p.x, p.y, p.z);
          box(50); 
          popMatrix();
        }
      }
      if (p2MissMarkers!=null) {
        for (PVector p : p2MissMarkers) {
          fill(0, 0, 255, 50);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }
    }
    if (boardNum==2) {
      if (p2HitMarkers!=null) {
        for (PVector p : p2HitMarkers) { 
          pushMatrix();
          fill(0, 255, 0, 50);
          translate(p.x, p.y, p.z);
          box(50); 
          popMatrix();
        }
      }
      if (p2MissMarkers!=null) {
        for (PVector p : p2MissMarkers) {
          fill(0, 0, 255, 50);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }
    }    
    if (boardNum==3) {
      if (p2.shipPositions.size()>0) {
        for (PVector p : p2.shipPositions) {
          fill(100);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }      
      if (p1HitMarkers!=null) {
        for (PVector p : p1HitMarkers) { 
          pushMatrix();
          fill(0, 255, 0, 50);
          translate(p.x, p.y, p.z);
          box(50); 
          popMatrix();
        }
      }
      if (p1MissMarkers!=null) {
        for (PVector p : p1MissMarkers) {
          fill(0, 0, 255, 50);
          pushMatrix();
          translate(p.x, p.y, p.z);
          box(50);
          popMatrix();
        }
      }
    }
    //Draws a flashing red cube in the currently selected area.
    fill(255, 0, 0, 50);
    if (timer<30) {
      pushMatrix();
      translate(selection.x, selection.y, selection.z);
      box(50);    
      popMatrix();
    }
    timer++;
    if (timer>=60) {
      timer=0;
    }

    popMatrix();
  }
}