final int block_size = 20;
final int pwidth = 45;
final int pheight = 35;
final int blockN = pwidth*pheight;

boolean[] playground = new boolean[blockN]; 
boolean switcher = false;

class Template {
  public boolean[] data;
  public int twidth;
  public int theight;
}

void drawTemplate(Template T) {
  for (int i=0;i<T.theight;i++) {
    for (int j=0;j<T.twidth;j++) {
      playground[i*pwidth+j]=T.data[i*T.theight+j];
    }
  }
}

void setup() {
  size(901, 701);
  /*for (int i=0; i<blockN; i++) {
    playground[i] = boolean(int(random(0,2)%2));
  }*/

  /*playground[plength*20+20]=true;
  playground[plength*20+21]=true;
  playground[plength*20+22]=true;*/
  frameRate(60);
}

void keyPressed() {
  if (key==ENTER) {
    switcher = true;
  }
  else if (key=='r') {
    for (int i=0; i<blockN; i++) {
      playground[i] = false;
    }
    switcher = false;
  }
  
  else if (key=='R') {
    for (int i=0; i<blockN; i++) {
      playground[i] = boolean(int(random(0,2)%2));
    }
  }
}

void mousePressed() {
  if (!switcher) {
    int blockX, blockY;
    blockX=(int)(mouseX/block_size);
    blockY=(int)(mouseY/block_size);
    playground[blockX+blockY*pwidth] ^= true;
  }
}



int frameCounter = 0;


void draw() {
  if (switcher) {
    if (frameCounter==45) {
      playground = proxess(playground,pwidth);
      frameCounter = 0;
    }
    else {
      frameCounter++;
    }
  }

  for (int i=0; i<pheight; i++) {
    for (int j=0; j<pwidth; j++) {
      if (playground[i*pwidth+j]==true) {
        fill(0, 0, 0);
        rect(j*block_size, i*block_size, block_size, block_size);
      } 
      else {
        fill(255, 255, 255);
        rect(j*block_size, i*block_size, block_size, block_size);
      }
    }
  }
}



boolean[] proxess(boolean[] pre, int pwidth) {
  boolean[] proxessed = new boolean[blockN];
  int count = 0;
  for (int i=0; i<blockN; i++) {
    if (i==0) {
      count = /******************/   /******************/   /******************/
              /******************/   /*OOOOOOOOOOOOOOOO*/   int(pre[i+1])       +
              /******************/   int(pre[i+pwidth])   + int(pre[i+pwidth+1]);
    }
    else if (i==blockN-1) {
      count = /******************/   /******************/   /******************/
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/   /******************/
              int(pre[i-pwidth-1]) + int(pre[i-pwidth])     /******************/;
    }
    else if (i==blockN-pwidth) {
      count = /******************/   int(pre[i-pwidth])   + int(pre[i-pwidth+1])+
              /******************/   /*OOOOOOOOOOOOOOOO*/   int(pre[i+1])
              /******************/   /******************/   /******************/;
    }
    else if (i==pwidth-1) {
      count = /******************/   /******************/   /******************/
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/   /******************/
              int(pre[i+pwidth-1]) + int(pre[i+pwidth])     /******************/;
    }
    
    
    else if (i<pwidth-1) {
      count = /******************/   /******************/    /******************/
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/    int(pre[i+1])       +
              int(pre[i+pwidth-1]) + int(pre[i+pwidth])   +  int(pre[i+pwidth+1]);
    }
    else if (i>blockN-pwidth) {
      count = int(pre[i-pwidth])   + int(pre[i-pwidth-1]) + int(pre[i-pwidth+1]) +
              int(pre[i-1])          /*OOOOOOOOOOOOOOOO*/ + int(pre[i+1])        
              /******************/   /******************/   /******************/ ;
    }
    else if (i%pwidth==0) {
      count = /******************/   int(pre[i-pwidth])   + int(pre[i-pwidth+1]) + 
              /******************/   /*OOOOOOOOOOOOOOOO*/   int(pre[i+1])        +
              /******************/   int(pre[i+pwidth])   + int(pre[i+pwidth+1]) ;
    }
    else if ((i+1)%pwidth==0) {
      count = int(pre[i-pwidth-1]) + int(pre[i-pwidth])   + /******************/
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/
              int(pre[i+pwidth-1]) + int(pre[i+pwidth])     /******************/ ;
    }
    
    
    else {
      count = int(pre[i+pwidth-1]) + int(pre[i+pwidth])   + int(pre[i+pwidth+1]) +
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/   int(pre[i+1])        +
              int(pre[i-pwidth-1]) + int(pre[i-pwidth])   + int(pre[i-pwidth+1]) ;
    }
    if (pre[i]==true) {
      if (count<2) {
        proxessed[i] = false;
      }
      else if (count<=3) {
        proxessed[i] = pre[i];
      }
      else {
        proxessed[i] = false;
      }
    }
    else if (count==3) {
      proxessed[i] = true;
    }

  }
  return proxessed;
}
