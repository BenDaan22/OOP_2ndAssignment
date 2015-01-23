/*
  Author: Ben Joshua Daan
  
  Date: January 13 2015

/*
DIT OOP Assignment 2 Starter Code
=================================
Loads player properties from an xml file
See: https://github.com/skooter500/DT228-OOP
*/
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();


boolean[] keys = new boolean[526];
import ddf.minim.*; // to include sound file

AudioPlayer backsound; // to include sound file
AudioPlayer shoot;

Minim minim;//audio context

//insert background images
PImage start_screen;

boolean begin = false;

void setup()
{
  minim = new Minim(this);
  backsound = minim.loadFile("arcade.mp3", 2048);
  shoot = minim.loadFile("Explosion4.wav", 2048);
  
  //backsound.play(); // to play the sound file
  //backsound.loop(); // to make the background sound
  size(1000, 600);
  setUpPlayerControllers();
  
  
  //to input images
  start_screen = loadImage("tank_wars.jpg"); // start game background
  
  //create the number of enemies
  for(int i= 0 ; i < 10; i++)
  {
    Enemy enemy = new Enemy(random(20,40),random(100 ,width),random(height/2,height));
    players.add(enemy);
    enemies.add(enemy);
    
  }//end for loop
  
}
void draw()
{
  textSize(15);
  
  //start background image
  image(start_screen,0,0,width,height);
  
  //Instructions
  text("Press Q to start the game", 20,250);
  text("Player 1 movements are W(up), S(down), A(left), D(right)",20, 300);
  text("Player 1 to shoot press E", 20, 320);
  
  text("Player 2 movements are I(up), K(down), J(left), L(right)", 20, 350);
  text("Player 2 to shoot press P", 20, 370);
  
  
  
  if(key == 'q')
  {
    begin = true;
  }
  
  if(begin == true)
  {
    background(0);
    
    /*
    for(Player player:players)
    {
      player.update();
      player.display();
    }
    */
    
    text("Enjoy and Play Safe",450,30);
    text("Dodge the moving Enemies AND Shoot them with everything you got (Smiley Face)",250,50);
    
    if(keyPressed && key == 'e' || keyPressed && key == 'p')
    {
      shoot.play();
      shoot.rewind();
      
    }
    
    for(int i =0 ; i < players.size(); i++)
    {
      players.get(i).update();
      players.get(i).display();
    }//end for loop
    
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
    Player p = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);
    //Player p2 = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);
    
    int x = (i*16+1)*width/20;
    //int x = (i + 1 ) * gap;
    
    p.pos.x = x; //controls the x position of the player at the start of the game
    p.pos.y =height/2; //controls the y position of the player at the start of the game
    players.add(p);
    
    /*
    p2.pos.x = x;
    p2.pos.y = 100; //controls the y position of the player at the start of the game
    players.add(p2);
    */
  }//end for
}
