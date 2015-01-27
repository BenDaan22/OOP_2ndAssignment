class Score extends Player
{
  float w,h;
  float x, y;
  
  float movementX = 0.50;
  float movementY = 0.50;
  
  Score(float w, float h, float x, float y)
  {
    this.h = h; 
    this.w = w;
    
    pos.x = x;
    pos.y = y;
    
  }
  
  void update()
  {
    
  }
  
  void display()
  {
    stroke(255);
    
    //Allows the Score objects to move and to bounce back from the edge of the screen
    for(int i=0; i < scores.size(); i ++)
    {
      if(pos.x > width - w || pos.x < 0)
      {
        movementX = -movementX; // this makes the enemies bounce back when it hits the width
      }
      
      if(pos.y > height - h || pos.y < 0)
      {
        movementY = -movementY; //this makes the enemies bounce back when it hits the height
      }
      
      pos.x += movementX; // this makes the enemies move
      pos.y += movementY ; // this makes the enemies move
      
      
    }//end for loop
    
    
    //draws the score objects
    fill(0,255,225);
    rect(pos.x,pos.y, w, h);
    fill(0,255,225);
    rect(pos.x+17, pos.y - 18, h,w);
    
  }
    
}
