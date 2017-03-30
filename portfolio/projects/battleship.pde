int[] axis = {-200, -150, -100, -50, 0, 50, 100, 150, 200};
ArrayList<PVector> p1HitMarkers;
ArrayList<PVector> p1MissMarkers;
ArrayList<PVector> p2HitMarkers;
ArrayList<PVector> p2MissMarkers;
Board board;
Button buttons[];
Button p1Place;
Button p2Place;
PVector selection;
private int timer;
int placeToRemove;
boolean shouldDelete;
int currentBoard;
Player p1;
Player p2;
boolean p1ShipsPlaced;
boolean p2ShipsPlaced;
boolean menu;
int menuTimer;
PFont font;
void setup() {  
  size(1000, 800, P3D);   
  font=createFont("Agency FB", 24);
  textFont(font);
  String[] fonts = PFont.list();
  println(fonts);
  menuTimer = 300;
  menu=false;
  p2ShipsPlaced=false;
  p1ShipsPlaced=false;
  currentBoard = 1;
  shouldDelete = false;
  placeToRemove =0;
  timer=0;
  board = new Board();
  buttons = new Button[8];
  buttons[0]=new Button(5, 5, 'x', '+');
  buttons[1]=new Button(5, 105, 'x', '-');
  buttons[2]=new Button(105, 5, 'y', '+');
  buttons[3]=new Button(105, 105, 'y', '-');
  buttons[4]=new Button(205, 5, 'z', '+');
  buttons[5]=new Button(205, 105, 'z', '-');
  buttons[6]=new Button(305, 105, 's', ' ');
  buttons[7]=new Button(305, 5, 'n', ' ');
  p1Place = new Button(305, 5, '1', ' ');
  p2Place = new Button(305, 5, '2', ' ');
  p1 = new Player();
  p2 = new Player();
  p1MissMarkers = new ArrayList<PVector>();
  p1HitMarkers=new ArrayList<PVector>();
  p2MissMarkers = new ArrayList<PVector>();
  p2HitMarkers=new ArrayList<PVector>();
  //button = new Buttons();
  selection = new PVector(-175, -175, -175);
}

float rotx = (75/800.0)*-2;
float roty = (25/800.0);
float zoom =1;
boolean hit;
void draw() {  
  background(255);
  pushMatrix();
  translate(0, 0, 500);
  fill(0);
  //text("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",width/2,height/2);
  fill(255, 0, 0);
  //text("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",width/2,height/4);
  popMatrix();
  if (menu) {
    board.drawMenu(hit);
  }
  if (!menu) {
    board.drawBoard(currentBoard);

    if ((!p1ShipsPlaced)||(!p2ShipsPlaced)) {
      for (int i=0; i<6; i++) {
        buttons[i].update();
        if ((!p1ShipsPlaced)) {
          p1Place.update();
        } else {
          p2Place.update();
        }
      }
    } else {
      for (Button b : buttons) {
        b.update();
      }
    }
  }
}

//Handles zoom functionality
void mouseWheel(MouseEvent event) {
  float e=event.getCount();
  if (e<0) {
    zoom+=.0625;
  }
  if (e>0) {
    zoom-=.0625;
  }
}
public void doAction() {

  //Move selection
  switch(axis) {
  case 'x': 
    if (incrementAmount>0&&selection.x<175) {
      selection.x+=incrementAmount;
    }
    if (incrementAmount<0&&selection.x>-175) {
      selection.x+=incrementAmount;
    } 
    break;
  case 'y':
    if (incrementAmount>0&&selection.y<175) {
      selection.y+=incrementAmount;
    }
    if (incrementAmount<0&&selection.y>-175) {
      selection.y+=incrementAmount;
    }
    break;  
  case 'z':
    if (incrementAmount>0&&selection.z<175) {
      selection.z+=incrementAmount;
    }
    if (incrementAmount<0&&selection.z>-175) {
      selection.z+=incrementAmount;
    }
    break;
    //Switch board view
  case 'n':      
    if (p1ShipsPlaced&&p2ShipsPlaced) {

      switch(currentBoard) {
      case 0:
        currentBoard=1;
        break;
      case 1:
        currentBoard=0;
        break;
      case 2:
        currentBoard = 3;
        break;
      case 3:
        currentBoard=2;
        break;
      }
    }
    break;
  case 's':      
    if (p1ShipsPlaced&&p2ShipsPlaced) {

      shoot();
    }
    break;


  case '1':      
    if ((!p1ShipsPlaced)||(!p2ShipsPlaced)) {

      if (7-(p1.shipPositions.size())>0) {
        p1.addShip();
      } else {            
        currentBoard=3;
        p1ShipsPlaced=true;
        selection=new PVector(-175, -175, -175);
      }
    }
    break;
  case '2':      
    if ((!p1ShipsPlaced)||(!p2ShipsPlaced)) {

      if (7-(p2.shipPositions.size())>0) {
        p2.addShip();
      } else {
        p2ShipsPlaced=true;
        selection=new PVector(-175, -175, -175);
      }
    }
    break;
  }
}