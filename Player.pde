class Player
{
  PVector pos; // controls the position of the objects
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  
  float w,h;
  float theta;
  float trackTime = 1.0f / 60.0f;
  float fireRate = 10.0f; // how fast each bullet is fired
  float passBy = 0.0f;
  float toPass = 1.0f / fireRate;
  
  int speed;
  int x_coord;
  int y_coord;
  
  boolean live; 
  
  Player()
  {
    pos = new PVector(width / 2, height / 2);
  }
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    
    theta= 0 ;
    speed = 10;
    w=40;
    h=40;
    x_coord = 40;
    y_coord = 40;
  }
  Player(int index, color colour, XML xml)
  {
    this(index
    , colour
    , buttonNameToKey(xml, "up")
    , buttonNameToKey(xml, "down")
    , buttonNameToKey(xml, "left")
    , buttonNameToKey(xml, "right")
    , buttonNameToKey(xml, "start")
    , buttonNameToKey(xml, "button1")
    , buttonNameToKey(xml, "button2")
    );
  }
  void update()
  {
    float lx, ly;
    passBy += trackTime;
    
    lx = sin(theta);
    ly = -cos(theta);
    
    if (checkKey(up))
    {
      //pos.y -= 5;
      pos.x += lx * speed;
      pos.y += ly * speed;
    }
    if (checkKey(down))
    {
     // pos.y += 5;
      pos.x -= lx * speed;
      pos.y -= ly * speed;
    }
    if (checkKey(left))
    {
      //pos.x -= 5;
      theta -= 0.1f;
    }
    if (checkKey(right))
    {
      //pos.x += 5;
      theta +=0.1f;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
      if(passBy > toPass)
      {
        Bullet bullet = new Bullet();
        bullet.pos.x = pos.x;
        bullet.pos.y = pos.y;
        bullet.theta = theta;
        players.add(bullet);
        passBy = 0.0f;
      }
  
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }
    
  }
  void display()
  {
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    
    
    /*
    fill(255);
    rect(pos.x-10,pos.y-10,40,40); //outer square
    stroke(colour);
    fill(colour);
    rect(pos.x, pos.y, 20, 20); //main square
    
    //wheels
    rect(pos.x-20,pos.y-20,10,60); //left wheel
    rect(pos.x+30,pos.y-20,10,60); //right wheel
    
    //cannon
    rect(pos.x+5,pos.y,10,-35);
    */
    
    
    fill(255);
    rect(x_coord -40 , y_coord -40 , w,h); //outer square
    
    fill(colour);
    rect(x_coord - 30, y_coord-30 ,w/2,h/2); //inner square
    
    //wheels
    rect(x_coord - 50 , y_coord - 50 ,w-30,h+20); //left wheel
    rect(x_coord,y_coord - 50 ,w-30,h+20); //right wheel
    
    //cannon
    rect(15,10,w-30,-h);
    
    
    popMatrix();
  }
}
