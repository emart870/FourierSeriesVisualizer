class FourierCoef
{
  public FourierCoef()
  {
  }
  
  public float[] square(int i)
  {
    int n = 2*i - 1;
    float coef = (float)(4 / (n * Math.PI));
    float[] output = {n, coef};
    return output;
  }
  
  public float[] sawtooth(int i)
  {
    int n = i;
    float coef = (float) (2 / (Math.pow(-1, n+1) * (n) * Math.PI));
    float[] output = {n, coef};
    return output;
  }
  
  public float[] tri(int i)
  {
    int n = 2*i - 1;
    float coef = (float) (Math.pow(-1, (n-1)/2) / (n*n));
    float[] output = {n, coef};
    return output;
  }
  
  
}
