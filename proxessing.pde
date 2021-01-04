int blockSize = 20;
int playgroundWidth = 65;
int playgroundHeight = 35;
int blockAmount = playgroundWidth*playgroundHeight;


boolean[] playground = new boolean[blockAmount];
boolean isRunning = false;


void setup() {
  size(1301, 701);
  stroke(127,127,127);
  frameRate(5);
}


void previewTemplate(Template T) {
  int mouseCoordinateX=(int)(mouseX/blockSize);
  int mouseCoordinateY=(int)(mouseY/blockSize);
  int blockCoordinateX = 0;
  int blockCoordinateY = 0;
  height = T.data.length/T.width;
  drawBlocks(mouseCoordinateX,mouseCoordinateY,T.data,T.width);
}


void applyTemplate(Template T) {
  int mouseCoordinateX=(int)(mouseX/blockSize);
  int mouseCoordinateY=(int)(mouseY/blockSize);
  int blockCoordinateX = 0;
  int blockCoordinateY = 0;
  height = T.data.length/T.width;
  for (int i=0;i<height;i++) {
    for (int j=0;j<T.width;j++) {
      blockCoordinateX = j+mouseCoordinateX;
      blockCoordinateY = i+mouseCoordinateY;
      if (blockCoordinateX>=playgroundWidth || blockCoordinateY>=playgroundHeight) {
        continue;
      }
      playground[(i+mouseCoordinateY)*playgroundWidth+blockCoordinateX]=T.data[i*T.width+j];
    }
  }
}


void keyPressed() {
  if (key==ENTER) {
    isRunning ^= true;
  }
  else if (key=='r') {
    for (int i=0; i<blockAmount; i++) {
      playground[i] = false;
    }
    isRunning = false;
  }
  else if (key=='R') {
    for (int i=0; i<blockAmount; i++) {
      playground[i] = boolean(int(random(0,2)%2));
    }
  }
  else if (key=='G') {
    previewTemplate(gosperTemplate);
  }
  else if (key=='g') {
    previewTemplate(gliderTemplate);
  }
}


void keyReleased() {
  if (key=='G') {
    applyTemplate(gosperTemplate);
  }
  if (key=='g') {
    applyTemplate(gliderTemplate);
  }
}


void mousePressed() {
  if (!isRunning) {
    int blockX, blockY;
    blockX=(int)(mouseX/blockSize);
    blockY=(int)(mouseY/blockSize);
    playground[blockX+blockY*playgroundWidth] ^= true;
  }
}


void mouseWheel(MouseEvent event) {
  if (!isRunning) {
    float e = event.getCount();
    blockSize += e;
    playgroundWidth = (int)width/blockSize;
    playgroundHeight = (int)height/blockSize;
    blockAmount = playgroundWidth*playgroundHeight;
    playground = new boolean[blockAmount];
  }
}


void drawBlocks(int x, int y, boolean[] data, int dataWidth) {
  int dataHeight = data.length/dataWidth;
  for (int i=0; i<dataHeight; i++) {
    for (int j=0; j<dataWidth; j++) {
      if (data[i*dataWidth+j]==true) {
        fill(0, 0, 0);
        rect((j+x)*blockSize, (i+y)*blockSize, blockSize, blockSize);
      } 
      else {
        fill(255, 255, 255);
        rect((j+x)*blockSize, (i+y)*blockSize, blockSize, blockSize);
      }
    }
  }
}


void draw() {
  background(255);
  if (isRunning) {
    playground = proxess(playground,playgroundWidth);
  }
  drawBlocks(0,0,playground,width/blockSize);
}


boolean[] proxess(boolean[] pre, int playgroundWidth) {
  boolean[] proxessed = new boolean[blockAmount];
  int count = 0;
  for (int i=0; i<blockAmount; i++) {
    if (i==0) {
      count = /***************************/   /***************************/   /***************************/
              /***************************/   /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   int(pre[i+1])                +
              /***************************/   int(pre[i+playgroundWidth])   + int(pre[i+playgroundWidth+1]);
    }
    else if (i==blockAmount-1) {
      count = /***************************/   /***************************/   /***************************/
              int(pre[i-1])                 + /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   /***************************/
              int(pre[i-playgroundWidth-1]) + int(pre[i-playgroundWidth])     /***************************/;
    }
    else if (i==blockAmount-playgroundWidth) {
      count = /***************************/   int(pre[i-playgroundWidth])   + int(pre[i-playgroundWidth+1])+
              /***************************/   /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   int(pre[i+1])
              /***************************/   /***************************/   /***************************/;
    }
    else if (i==playgroundWidth-1) {
      count = /***************************/   /***************************/   /***************************/
              int(pre[i-1])                 + /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   /***************************/
              int(pre[i+playgroundWidth-1]) + int(pre[i+playgroundWidth])     /***************************/;
    }
    else if (i<playgroundWidth-1) {
      count = /***************************/   /***************************/    /***************************/
              int(pre[i-1])                 + /*OOOOOOOOOOOOOOOOOOOOOOOOO*/    int(pre[i+1])                +
              int(pre[i+playgroundWidth-1]) + int(pre[i+playgroundWidth])   +  int(pre[i+playgroundWidth+1]);
    }
    else if (i>blockAmount-playgroundWidth) {
      count = int(pre[i-playgroundWidth])   + int(pre[i-playgroundWidth-1]) + int(pre[i-playgroundWidth+1]) +
              int(pre[i-1])                   /*OOOOOOOOOOOOOOOOOOOOOOOOO*/ + int(pre[i+1])        
              /***************************/   /***************************/   /***************************/ ;
    }
    else if (i%playgroundWidth==0) {
      count = /***************************/   int(pre[i-playgroundWidth])   + int(pre[i-playgroundWidth+1]) + 
              /***************************/   /*O000000000OOOOOOOOOOOOOOO*/   int(pre[i+1])                 +
              /***************************/   int(pre[i+playgroundWidth])   + int(pre[i+playgroundWidth+1]) ;
    }
    else if ((i+1)%playgroundWidth==0) {
      count = int(pre[i-playgroundWidth-1]) + int(pre[i-playgroundWidth])   + /***************************/
              int(pre[i-1])                 + /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   /***************************/
              int(pre[i+playgroundWidth-1]) + int(pre[i+playgroundWidth])     /***************************/ ;
    }
    else {
      count = int(pre[i+playgroundWidth-1]) + int(pre[i+playgroundWidth])   + int(pre[i+playgroundWidth+1]) +
              int(pre[i-1])                 + /*OOOOOOOOOOOOOOOOOOOOOOOOO*/   int(pre[i+1])                 +
              int(pre[i-playgroundWidth-1]) + int(pre[i-playgroundWidth])   + int(pre[i-playgroundWidth+1]) ;
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


//Templates
class Template {
  public boolean[] data;
  public int width;
  public Template(int[] templateData, int templateWidth) {
    boolean[] tData = new boolean[templateData.length];
    for (int i=0;i<tData.length;i++) {
      //tData[i] = (boolean)(templateData[i]);
      tData[i] = templateData[i]==0 ? false : true;
    }
    this.data = tData;
    this.width = templateWidth;
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


final int[] gliderData = {
0,0,0,0,0,
0,0,1,0,0,
0,0,0,1,0,
0,1,1,1,0,
0,0,0,0,0};
final int gliderWidth = 5;


final Template gosperTemplate = new Template(gosperData,gosperWidth);
final Template gliderTemplate = new Template(gliderData,gliderWidth);
