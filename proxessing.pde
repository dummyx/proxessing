final int block_size = 10;
final int plength = 100;
final int pwidth = 100;

//test only


size(1000, 1000);


boolean[] playground = new boolean[10000]; 
for (int i=0; i<10000; i++)
{
  playground[i] = false;
}
for (int i=0; i<plength; i++)
{
  for (int j=0; j<pwidth; j++)
  {
    if (playground[i*pwidth+j]==true)
    {
      fill(0, 0, 0);
      rect(j*block_size, i*block_size, block_size, block_size);
    } else 
    {
      fill(255, 255, 255);
      rect(j*block_size, i*block_size, block_size, block_size);
    }
  }
}
