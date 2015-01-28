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
ArrayList<Score> scores = new ArrayList<Score>();


boolean[] keys = new boolean[526];
import ddf.minim.*; // to include sound file

AudioPlayer backsound; // to include sound file
AudioPlayer shoot; // the sound fille when the player wants to shoot bullets
AudioPlayer scored; // the sound file if the player scored
AudioPlayer alien; // the sound file if the player hit one of the aliens

Minim minim;//audio context

//insert background images
PImage start_screen;

boolean begin = false;

int lives; // to keep track of how many lives  left
int score; // keeps track of the score for the entire game
int counter=0; //a counter to show the Game over screen

int valueToRemove; // to delete the enemy from the array list

void setup()
{
  score = 0;
  lives = 10;
  
  minim = new Minim(this);
  backsound = minim.loadFile("arcade.mp3", 2048); //this is the background sounds
  shoot = minim.loadFile("Laser.wav", 2048); //when the player shoots
  scored = minim.loadFile("ding.mp3", 2048); // when the player gets the plus sign for points
  alien = minim.loadFile("alien.mp3", 2048); //when the player hits an alien enemy
  
  backsound.play(); // to play the sound file
  backsound.loop(); // to make the background sound
  size(1000, 600);
  setUpPlayerControllers();
  
  
  //to input images
  start_screen = loadImage("open_screen.jpg"); // start game background
  
  //create the number of enemies
  for(int i= 0 ; i < 15; i++)
  {
    Enemy enemy = new Enemy(random(20,40),random(20,40),random(100 ,width),random(height/2,height));
    players.add(enemy); //  draws the enemy objects
    enemies.add(enemy);
    
  }//end for loop
  
  //create the score objects
  for(int i = 0 ; i < 5; i ++)
  {
    Score score = new Score(40,5, random(0,width), random(0, height));
    players.add(score); // draws the score object
    scores.add(score);

  }
  
}
void draw()
{
  textSize(15);
  
  //start background image
  image(start_screen,0,0,width,height);
  
  //Instructions
  fill(255,255,0);
  
  text("Enjoy and Play Safe",450,30);
  text("Dodge the moving Enemies AND Shoot them with everything you got (Smiley Face)",250,50);
  text("Get the Plus Sign to gain points", 400, 70);
    
  text("Press Q to start the game", 20,400);
  text("Player 1 movements are W(up), S(down), A(left), D(right)",20, 450);
  text("Player 1 to shoot press E", 20, 470);
  
  text("Player 2 movements are I(up), K(down), J(left), L(right)", 20, 500);
  text("Player 2 to shoot press P", 20, 520);
  text("NOTE : Both Player1 and Player2 share the same life points and same Score", 20, 550);
  
  
  
  if(key == 'q')
  {
    begin = true; 
  }
  
  if(begin == true) // executes everything if the begin boolean is true
  {
    background(0);
    
    text("Enjoy and Play Safe",450,30);
    text("Dodge the moving Enemies AND Shoot them with everything you got (Smiley Face)",250,50);
    text("Get the Plus Sign to gain points", 400, 70);
    
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
    
    
    text("Lives: " + lives, 50,50);
     text("Score: " + score, 50,80);
    
    //check for collision between enemy and player 
   for(int i = 0 ; i < players.size() - 1 ; i ++)
    {
      Player player1 = players.get(i);
      for (int j = i + 1 ; j < enemies.size() ; j ++)
      {
        Enemy enemy1 = enemies.get(j);
        if (player1.collides(enemy1))
        {
          println("valueToRemove is : " + valueToRemove);
          
          println("Player " + i + " collides with" + "Enemy" + j);
          lives --;
          alien.play();
          alien.rewind();
          
          valueToRemove = j; //when the enemy is touched it will be deleted
          
          //to delete the enemy from the array list
          if(j == valueToRemove)
          {
            enemies.remove(j);
          }//end inside if
        }//and outer if
      }//end inner for loop
    }//end outer for loop
    
    //check for score and player collision
    for(int i = 0 ; i < players.size() - 1 ; i ++)
    {
      Player player1 = players.get(i);
      for (int j = i + 1 ; j < scores.size() ; j ++)
      {
        Score score1 = scores.get(j);
        if (player1.collided(score1))
        {
          
          println("Player " + i + "collides with " + "Score " + j);
          score++;
          scored.play();
          scored.rewind();

        }//end if
        
      }
    }
    
  }//end if
  
  if (lives == 0)
  { 
    counter = 1;
    
  }
        
  if(counter == 1)
  {
    textSize(40);
    background(0);
    text("GAME OVER!!", width/2-80,  height/2);
    text("Press Q to play again and Good Luck", width/2 - 300, height/2 + 60);
    text("Your Score is: " + score, width/2 - 100, height/2 + 100);
          
    if(keyPressed && key == 'q') // If the player wants to play again
    {
      //resets everything
      begin = true;
      counter = 0; 
      lives = 10;
      score = 0;
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
    Player p = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);    
    
    int x = (i*16+1)*width/20;
    //int x = (i + 1 ) * gap;
    
    p.pos.x = x; //controls the x position of the player at the start of the game
    p.pos.y =height/2; //controls the y position of the player at the start of the game
    players.add(p);
    
  }//end for
}
