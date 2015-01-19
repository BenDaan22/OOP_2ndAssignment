/*
DIT OOP Assignment 2 Starter Code
=================================
Loads player properties from an xml file
See: https://github.com/skooter500/DT228-OOP
*/
ArrayList<Player> players = new ArrayList<Player>();
boolean[] keys = new boolean[526];
import ddf.minim.*; // to include sound file

AudioPlayer backsound; // to include sound file
Minim minim;//audio context

//insert background images
PImage start_screen;

boolean begin = false;

void setup()
{
  minim = new Minim(this);
  backsound = minim.loadFile("arcade.mp3", 2048);
  //backsound.play();
  //backsound.loop();
  size(500, 500);
  setUpPlayerControllers();
  
  
  //to input images
  start_screen = loadImage("tank_wars.jpg"); // start game background
  
}
void draw()
{
  //start background image
  image(start_screen,0,0,height,width);
  
  if(key == 'q')
  {
    begin = true;
  }
  
  if(begin == true)
  {
    background(0);
    
    for(Player player:players)
    {
      player.update();
      player.display();
    }
  }
}


void keyPressed()
{
    keys[keyCode] = true;
}

void keyReleased()
{
   keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
    return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value = xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
  return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
  return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
  return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
  return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);
}
void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  for(int i = 0 ; i < children.length ; i ++)
  {
    XML playerXML = children[i];
    Player p1 = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);
   // Player p2 = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);
    int x = (i + 1) * gap;
    
    p1.pos.x = x; //controls the x position of the player at the start of the game
    p1.pos.y =200; //controls the y position of the player at the start of the game
    players.add(p1);
    
    /*
    p2.pos.x = x;
    p2.pos.y = 100; //controls the y position of the player at the start of the game
    players.add(p2);
    */
  }
}
