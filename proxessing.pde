final int block_size = 10;
final int pwidth = 100;
final int pheight = 100;
final int blockN = pwidth*pheight;

boolean[] playground = new boolean[blockN]; 
boolean switcher = false;

void setup() {
  size(1000, 1000);
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
}

void mousePressed() {
  if (!switcher) {
    int blockX, blockY;
    blockX=mouseX/block_size;
    blockY=mouseY/block_size;
    playground[blockX+blockY*pwidth] = !playground[blockX+blockY*pwidth];
  }
}



int frameCounter = 0;


void draw() {
  if (switcher) {
    if (frameCounter==60) {
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
      count = int(pre[i+1]) +
              int(pre[i+pwidth]) + int(pre[i+pwidth+1]);
    }
    else if (i==blockN-1) {
      count = int(pre[i-1]) +
              int(pre[i-pwidth]) + int(pre[i-pwidth-1]);
    }
    else if (i==blockN-pwidth) {
      count = int(pre[i+1]) +
              int(pre[i-pwidth]) + int(pre[i-pwidth+1]);
    }
    else if (i==pwidth-1) {
      count = int(pre[i-1]) +
              int(pre[i+pwidth]) + int(pre[i+pwidth-1]);
    }
    else if (i<pwidth-1) {
      count = int(pre[i-1]) + int(pre[i+1]) +
              int(pre[i+pwidth]) + int(pre[i+pwidth-1]) + int(pre[i+pwidth+1]);
    }
    else if (i>blockN-pwidth) {
      count = int(pre[i-1]) + int(pre[i+1]) +
              int(pre[i-pwidth]) + int(pre[i-pwidth-1]) + int(pre[i-pwidth+1]);
    }
    else if (i%pwidth==0) {
      count = int(pre[i+1]) +
              int(pre[i+pwidth]) + int(pre[i+pwidth+1]) + 
              int(pre[i-pwidth]) + int(pre[i-pwidth+1]);
    }
    else if ((i+1)%pwidth==0) {
      count = int(pre[i-1]) +
              int(pre[i+pwidth]) + int(pre[i+pwidth-1]) + 
              int(pre[i-pwidth]) + int(pre[i-pwidth-1]);
    }
    else {
      count = int(pre[i+1]) + int(pre[i-1]) +
              int(pre[i+pwidth-1]) + int(pre[i+pwidth]) + int(pre[i+pwidth+1]) + 
              int(pre[i-pwidth-1]) + int(pre[i-pwidth]) + int(pre[i-pwidth+1]);
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
