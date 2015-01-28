class Bullet extends Player
{
  float passBy = 0.0f; // how many bullets has passed by
  float trackTime = 1.0f / 60.f; //how many seconds it will take for each bullet to fade
  float showBullet = 5.0f; // determines when the bullet will die
  
  int x1, y1; // first points for the bullet
  int w, h; // second points for the bullet
  
  Bullet()
  {
    pos.x = width /2 ;
    pos.y = height / 2;
    x1 = 18;
    w = 5;
    y1 = -30;
    h = 10;
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
    
    //check for bullet and enemy collision
    for (int j = 0 ; j < enemies.size() ; j ++)
    {
      Enemy enemy = enemies.get(j); // checks which enemy will be hit
      if (collision(enemy))
      {
        //if you hit an enemy with a bullet it diappears and you gain a points
        score++; 
        
        enemy.pos.x = 10000; // will make the enemy disappear
        enemy.pos.y = 10000; // will make the enemy disappear
            
          
      }//end if
        
    }
    
  }//end void update
  
  void display()
  {
    pushMatrix(); // saves the current coordinate of the player object
    translate(pos.x, pos.y);
    rotate(theta);
    
    stroke(255);
 
    rect(x1,y1,w,h); // bullet
    
    
    popMatrix(); //restores the prior coordinate of the player object
    
  }//end void display
  
  
  //to check if the bullets hits an enemy
  boolean collision(Enemy b)
  {
    //check if they collide
    if (b.pos.x + b.w < pos.x)
    {
       return false;
    }
    if (b.pos.x > pos.x + w)
    {
      return false;
    }
    if (b.pos.y > pos.y + h)
    {
      return false;
    }
    if (b.pos.y + b.h < pos.y)
    {
      return false;
    }
      
     // If they collided then its true
     return true;
      
      
   }
  
}//end Bullet class
