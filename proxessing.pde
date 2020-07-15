final int block_size = 20;
final int pwidth = 55;
final int pheight = 45;
final int blockN = pwidth*pheight;

boolean[] playground = new boolean[blockN]; 
boolean switcher = false;



class Template {
  public boolean[] data;
  public int twidth;
  public int theight;
  public Template(int[] templateData, 
                  int   templateWidth, 
                  int   templateHeight) {
    boolean[] tData = new boolean[templateData.length];
    for (int i=0;i<tData.length;i++) {
      //tData[i] = (boolean)(templateData[i]);
      tData[i] = templateData[i]==0 ? false : true;
    }
    this.data = tData;
    this.twidth = templateWidth;
    this.theight = templateHeight;
  }
}

final int[] gosperData = {
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,
0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,
0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
final int gosperWidth = 38;
final int gosperHeight = 11;

final int[] gliderData = {
0,0,0,0,0,
0,0,1,0,0,
0,0,0,1,0,
0,1,1,1,0,
0,0,0,0,0};
final int gliderWidth = 5;
final int gliderHeight = 5;

Template gosper = new Template(gosperData,gosperWidth,gosperHeight);
Template glider = new Template(gliderData,gliderWidth,gliderHeight);

void drawTemplate(Template T) {
  int blockX=(int)(mouseX/block_size);
  int blockY=(int)(mouseY/block_size);
  int drawblockX = 0;
  int drawblockY = 0;
  for (int i=0;i<T.theight;i++) {
    for (int j=0;j<T.twidth;j++) {
      drawblockX = j+blockX;
      drawblockY = i+blockY;
      if (drawblockX>=pwidth || drawblockY>=pheight) {
        continue;
      }
      playground[(i+blockY)*pwidth+drawblockX]=T.data[i*T.twidth+j];
    }
  }
}

void setup() {
  size(1101, 901);
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
  else if (key=='G') {
    drawTemplate(gosper);
  }
  else if (key=='g') {
    drawTemplate(glider);
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
  stroke(127,127,127);
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
              int(pre[i-1])        + /*OOOOOOOOOOOOOOOO*/   /******************/
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
