
//Globale Variablen
Car car = new Car();
Driver driver = new Driver();
int leftBorder = 185;
int rightBorder = 315;
int state = 0; //State kann sptäer zwischen 0 und 1 wechseln, 1 heisst "Game Over" (im moment ein schwarzer screen)

void setup() { 
  size(500, 500);
} 

void draw() {
  background(255, 255, 255);
  
  //Aufbau der Strasse
  fill(0);
  line(leftBorder,0,leftBorder,height);
  line(rightBorder,0,rightBorder,height);
  for(int y = 0; y < height; y += 20){
   line(250, y, 250, y+10); 
  }
  
  //Normalbetrieb wenn das Spiel gestartet wird
  if(state == 0){
    car.paint();
    driver.paint();
    if(car.y >= height){
      car = new Car(); //erzeugt ein neues Fahrzeug, wenn das momentane fahrzeug unten angekommen ist
    }
    
    if(driver.didCrash(car)){
      state = 1;
    }
  
    if(keyCode == LEFT){
      driver.steerLeft();
    } else if(keyCode == RIGHT){
      driver.steerRight();
    }
    keyCode = 0; //Setzt den keyCode von LEFT oder RIGHT zurück auf 0
  }
  if(state == 1){
    fill(0);
    rect(0,0,width,height);
    if(keyCode == ENTER){ //Beim schwarzen Screen oder "Game Over" kann man mit ENTER das spiel wieder von neu starten
      car = new Car();
      driver = new Driver();
      state = 0;
    }
  }
}

public class Car {
  int random;
  int x,y;
  int heght, wdth;
  int speed;
  int lane;
  
  public Car(){
    random = (int) random(1,3);
    //Die x position wird hier zufällig angewiesen (linke oder rechte Fahrbahn)
    if(random == 1){
      x = (random+1)*100-10;
    } else {
      x = random*100+60;
    }
    y = -100;
    heght = 100;
    wdth = 50;
    speed = 4;
    lane = random; //lane kann entweder 1 oder 2 sein, 1=linke spur, 2=rechte spur
  }
  
  public void paint(){
    fill(0);
    rect(x,y,wdth,heght);
    y += speed;
  }
  
}

//Driver ist der Spieler und kann diesen Steuern
public class Driver extends Car {
  
  public Driver(){
    super();
    x = 250;
    y = 300;
  }
  
  public void paint(){
    fill(255);
    rect(x,y,wdth,heght);
  }
    
  
  public void steerLeft(){
    if(x >= leftBorder+10){
      x -= 5;
    }
  }
  
  public void steerRight(){
    if(x+wdth <= rightBorder-10){
      x += 5;
    }
  }
  
  public boolean didCrash(Car car){
    if(car.lane == 1){
      if(x <= car.x+wdth && x >= car.x && (y <= car.y+heght && y >= car.y || y+heght >= car.y && y+heght <= car.y+heght)){
        return true;
      }
    }
    if(car.lane == 2){
      if(x+wdth >= car.x && x+wdth <= car.x+wdth && (y <= car.y+heght && y >= car.y || y+heght >= car.y && y+heght <= car.y+heght)){
        return true;
      }
    }
    return false;
  }
}
