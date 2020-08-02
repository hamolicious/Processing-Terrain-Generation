class FlashText {
  float x;

  void flash(String text) {
    PFont font;
    font = createFont("ariel", 32);
    textFont(font, 32);
    
    fill(0);
    
    text(text, x, 50);
  }
  
}
