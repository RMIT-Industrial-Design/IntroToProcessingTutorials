ArrayList<Particle> particles;

Particle p;
boolean bGenerateParticles = true;

void setup()
{
  background(0);
  size(800,800);
  
  particles = new ArrayList<Particle>();
 
}

void draw()
{
  background(0);

  // spawn particles
  if(bGenerateParticles) {
    p = new Particle();
    p.setPosition(width/2,height/2);
    p.size = random(10,40);
    p.setSpeed(random(-1.0f,1.0f),random(-1.0f,1.0f));
    p.setColour(color(random(0,255),random(0,255),random(0,255)));
  
    particles.add(p);
  }

  // update and draw particles
  for(int i = 0; i < particles.size();i++ )
  {
    Particle p = particles.get(i);
    p.drawParticle();
    p.update();
  }
  
  // remove particles that are off-screen
  for(int i = 0; i < particles.size();i++ )
  {
    Particle p = particles.get(i);
    if((p.x < -100) || (p.x > width + 100)) {
      particles.remove(i);  
    }
    if((p.y < -100) || (p.y > height + 100)) {
      particles.remove(i);  
    }
  } 
  
  fill(255);
  rect(0,0,150,30);
  fill(0);
  text("Num Particles="+particles.size(), 20,20);
}

void mouseMoved() 
{
  // spawn particles if the mouse is moved
  p = new Particle();
  p.setPosition(mouseX,mouseY);
  p.size = random(3,10);
  p.setSpeed(random(-1.0f,1.0f),random(-1.0f,1.0f));
  p.setColour(color(255,255,255));

  particles.add(p);    
}

void keyPressed()
{
  bGenerateParticles = !bGenerateParticles;
}