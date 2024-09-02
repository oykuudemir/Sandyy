class Platform {
  PImage image;
  float x,y,dx,dy,w,h;

  Platform(float x,float y,float w, float h, String path) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    image = loadImage(path);
  }
  
  void display() {
    image(image, x, y, w, h); 
  }
  

  void setLeft(float left){
    x = left + w/2;
  }
  float getLeft(){
    return x - w/2;
  }
  void setRight(float right){
    x = right - w/2;
  }
  float getRight(){
    return x + w/2;
  }
  void setTop(float top){
    y = top + h/2;
  }
  float getTop(){
    return y - h/2;
  }
  void setBottom(float bottom){
    y = bottom - h/2;
  }
  float getBottom(){
    return y + h/2;
  }
  
}
