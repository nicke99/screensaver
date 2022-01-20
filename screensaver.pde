
import processing.opengl.*; 

DNA dna;

void setup()
{
  size(displayWidth,displayHeight,P3D);
  textureMode(NORMAL);
  noStroke();
  background(0);
  dna=new DNA();
  frameRate(60);
}

float angle=0;

void draw()
{
  angle=angle+0.05;
  angle=angle%360;
  
  background(0);
  translate(width/2,height/2,-800);
  rotateY(radians(angle));
  rotateX(radians(60));
  dna.draw(0,0,0);
}

class DNA
{
  int numBars=60;
  Bar[]bar=new Bar[numBars];
  
  DNA()
  {
    int numImages=6;
    for(int l=0;l<numBars;l++)
    {
      int imgNo=l%numImages;
      PImage img=loadImage(str(imgNo) + ".bmp");
      bar[l]= new Bar(img);
    }
  }
  
  public void draw(int x,int y,int z)
  {
    int spacing = 40;
    translate(0,-(numBars/2) * spacing);
    rotateY(radians(angle));
    for(int l=0;l<numBars;l++)
    {  
      bar[l].draw(0,0,0);
      translate(0,spacing);
      rotateY(PI/11);  
    } 
  }
}

//A Bar is a piece of DNA with a picture at each end
class Bar
{
  CoverArt cover;
  
  Bar(PImage art)
  {
    cover = new CoverArt(art);
  }
  
  //draw the bar
  public void draw(int x,int y,int z)
  {
    cover.draw(x,y,z+800);
    cover.draw(x,y,z-800);
  }
}

//draw cover art at x,y,z, facing camera
class CoverArt
{
  PImage img;

  //pass art to constructor  
  CoverArt(PImage art)
  {
    img=art;
  }
  
  public void draw(int x,int y,int z)
  {
    beginShape();
    texture(img);
    vertex(x - 100,y - 100,z,0,0);
    vertex(x + 100,y - 100,z,1,0);
    vertex(x + 100,y + 100,z,1,1);
    vertex(x - 100,y +100,z,0,1);
    endShape();
  }
}