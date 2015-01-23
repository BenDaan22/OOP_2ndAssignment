class Enemy extends Player
{
  float radius;
  float x,y;
  
  float movementX = 0.40f; // to move the enemies' X- axis
  float movementY = 0.40f; // to move the enemies' Y- axis
  
  Enemy(float radius, float x, float y)
  {
    this.radius = radius;
    pos.x = x;
    pos.y = y;
  }
  
  void update()
  {
    
  }
  
  
  void display()
  {
    stroke(255);
    
    for(int i=0; i < enemies.size(); i ++)
    {
      if(pos.x > width - radius || pos.x < 0)
      {
        movementX = -movementX; // this makes the enemies bounce back when it hits the width
      }
      
      if(pos.y > height - radius || pos.y < 0)
      {
        movementY = -movementY; //this makes the enemies bounce back when it hits the height
      }
      
      pos.x += movementX; // this makes the enemies move
      pos.y += movementY; // this makes the enemies move
      
      
    }//end for loop
    
    fill(255,255,0); // colour yellow
    rect(pos.x,pos.y , radius, radius); // draws the enemy
    
  }  
  
  
}
