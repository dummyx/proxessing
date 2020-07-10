final int block_size = 10;
final int plength = 100;
final int pwidth = 100;

boolean[] playground = new boolean[10000]; 

void setup() {
  size(1000, 1000);
  for (int i=0; i<10000; i++) {
    playground[i] = boolean(int(random(0,2)%2));
  }
  /*playground[plength*20+20]=true;
  playground[plength*20+21]=true;
  playground[plength*20+22]=true;*/
  frameRate(1);
} //<>//

boolean[] proxess(boolean[] pre, int plength) {
  boolean[] proxessed = new boolean[10000];
  int count = 0;
  for (int i=0; i<10000; i++) {
    if (i==0) {
      count = int(pre[i+1]) +
              int(pre[i+plength]) + int(pre[i+plength+1]);
    }
    else if (i==9999) {
      count = int(pre[i-1]) +
              int(pre[i-plength]) + int(pre[i-plength-1]);
    }
    else if (i==9900) {
      count = int(pre[i+1]) +
              int(pre[i-plength]) + int(pre[i-plength+1]);
    }
    else if (i==99) {
      count = int(pre[i-1]) +
              int(pre[i+plength]) + int(pre[i+plength-1]);
    }
    else if (i<99) {
      count = int(pre[i-1]) + int(pre[i+1]) +
              int(pre[i+plength]) + int(pre[i+plength-1]) + int(pre[i+plength+1]);
    }
    else if (i>9900) {
      count = int(pre[i-1]) + int(pre[i+1]) +
              int(pre[i-plength]) + int(pre[i-plength-1]) + int(pre[i-plength+1]);
    }
    else if (i%100==0) {
      count = int(pre[i+1]) +
              int(pre[i+plength]) + int(pre[i+plength+1]) + 
              int(pre[i-plength]) + int(pre[i-plength+1]);
    }
    else if ((i+1)%100==0) {
      count = int(pre[i-1]) +
              int(pre[i+plength]) + int(pre[i+plength-1]) + 
              int(pre[i-plength]) + int(pre[i-plength-1]);
    }

    if (count<2) {
      proxessed[i] = false;
    }
    else if (count<=3) {
      proxessed[i] = pre[i];
    }
    else {
      proxessed[i] = true;
    }

  }
  return proxessed;
}

void draw() {
  playground = proxess(playground,plength); //<>//
  for (int i=0; i<plength; i++) {
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
