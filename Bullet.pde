class Bullet extends Player
{
  float passBy = 0.0f; // how many bullets has passed by
  float trackTime = 1.0f / 60.f; //how many seconds it will take for each bullet to fade
  float showBullet = 5.0f; // determines when the bullet will die
  
  int x1, y1; // first points for the bullet
  int x2, y2; // second points for the bullet
  
  Bullet()
  {
    pos.x = width /2 ;
    pos.y = height / 2;
    x1 = 18;
    x2 = 5;
    y1 = -30;
    y2 = 10;
  }
  
  void update()
  {
    float Ax = sin(theta); // will determine the Angle of the x-axis when the object moves
    float Ay = -cos(theta); // will determine the Angle of the y-axis when the object moves
    float speed = 10.0f;
    
    pos.x += Ax * speed; // determines how fast the bullet is fired
    pos.y += Ay * speed;
    
    passBy += trackTime; // how many bullets per second
    
    if(passBy > showBullet)
    {
      live = false; 
      
    }
    
    
    
  }//end void update
  
  void display()
  {
    pushMatrix(); // saves the current coordinate of the player object
    translate(pos.x, pos.y);
    rotate(theta);
    
    stroke(255);
 
    rect(x1,y1,x2,y2); // bullet
    
    
    popMatrix(); //restores the prior coordinate of the player object
    
  }//end void display
  
  
}//end Bullet class
