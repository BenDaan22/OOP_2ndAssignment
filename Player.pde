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
  
  float w,h; // width and height of th player
  float theta;
  float trackTime = 1.0f / 60.0f;
  float fireRate = 10.0f; // how fast each bullet is fired
  float passBy = 0.0f; // how many bullets has passed by
  float toPass = 1.0f / fireRate;
  
  int speed;
  int x_coord; // x coordination of the player
  int y_coord; // y coordination of the player
  
  boolean live;  // to see if the bullet will live or not
  
  Player()
  {
    pos = new PVector(width / 2, height / 2); // determines the position of everything
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
      pos.x += lx * speed;
      pos.y += ly * speed;
    }
    if (checkKey(down))
    {
      pos.x -= lx * speed;
      pos.y -= ly * speed;
    }
    if (checkKey(left))
    {
      theta -= 0.1f;
    }
    if (checkKey(right))
    {
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
        Bullet bullet = new Bullet(); // creates the Bullet 
        bullet.pos.x = pos.x; // uses the player's x position
        bullet.pos.y = pos.y; // uses the player's y position
        bullet.theta = theta;
        players.add(bullet); 
        passBy = 0.0f; // resets the bullets that has passed by
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
  
  // determines if there is collision between the player and the enemy
  boolean collides(Player p) 
  {
     //check if they dont collide
    if (p.pos.x + p.w < pos.x) // to check the x axis of the player if it hits an enemy
    {
      return false;
    }
    if (p.pos.x > pos.x + w) // to check the x axis of the player if it hits an enemy
    {
      return false;
    }
    if (p.pos.y > pos.y + h) // to check the y axis of the player if it hits the enemy
    {
      return false;
    }
    if (p.pos.y + p.h < pos.y) // to check the y axis of the player if it hits the enemy
    {
      return false;
    }
    
    // If they collided then its true
    return true;
    
    
  }//end boolean
  
  
  // determines if there is collision between the player and the score objects
  boolean collided(Player play)
  {
     //check if they dont  collide
    if (play.pos.x + play.w < pos.x) // to check the x axis of the player if it hits a score object
    {
      return false;
    }
    if (play.pos.x > pos.x + w) // to check the x axis of the player if it hits a score object
    {
      return false;
    }
    if (play.pos.y > pos.y + h) // to check the y axis of the player if it hits a score object
    {
      return false;
    }
    if (play.pos.y + play.h < pos.y) // to check the y axis of the player if it hits a score object
    {
      return false;
    }
    
    // If they collided then its true
    return true;
    
    
  }
  
}//end class Player
