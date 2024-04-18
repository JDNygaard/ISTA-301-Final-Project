PImage[] images;
String[] imageTexts; 
int currentIndex = 0; 

PFont timesNewRoman;
int lastChangeTime = 0;
int changeInterval = 5000; 
float rotationAngle = 0; 

void setup() {
  size(800, 800, P3D);
  
  // Load Times New Roman font
  timesNewRoman = createFont("Times New Roman", 30);
  textFont(timesNewRoman);
  
  // Load images
  images = new PImage[3]; 
  images[0] = loadImage("Between the desire.jpg");
  images[1] = loadImage("Falls the Shadow.jpg");
  images[2] = loadImage("Of death's twilight kingdom.jpg");
  
  // Load associated texts
  imageTexts = new String[3];
  imageTexts[0] = "Between the desire"; 
  imageTexts[1] = "Falls the Shadow";
  imageTexts[2] = "Of death's twilight kingdom";
  

  shuffleArrays(images, imageTexts);
  
  // Display the first image
  displayNextImage();
}

void draw() {
  background(255);
  noStroke();
  float tiles = 210;
  float tileSize = width/tiles;
  
  push();
  translate(width/2, height/2);
  
  float rotationX = map(mouseY, 0, height, -PI, PI);
  float rotationY = map(mouseX, 0, width, -PI, PI);
  
  rotateY(rotationY);
  rotateX(rotationX);
  
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = images[currentIndex].get(int(x*tileSize), int(y*tileSize));
      float b = map(brightness(c), 0, 255, 0, 1);
      float z = map(b, 0, 1, -100, 100);
      fill(0, 0, 0);
      
      push();
      translate(x*tileSize - width/2, y*tileSize - height/2, z);
      box(tileSize*b);
      pop();
    }  
  }
  pop();
  

  fill(0); 
  displayText(imageTexts[currentIndex], width/2, height - 50); 
  

  if (millis() - lastChangeTime >= changeInterval) {
    displayNextImage();
    lastChangeTime = millis(); 
    rotationAngle = 0; 
  } else {
    // Gradually update the rotation angle over 5 seconds
    float progress = (millis() - lastChangeTime) / (float) changeInterval;
    rotationAngle = map(progress, 0, 1, 0, HALF_PI);
  }
}

void displayNextImage() {
  currentIndex = (currentIndex + 1) % images.length;
}

void displayText(String txt, float x, float y) {
  textAlign(CENTER, BOTTOM); 
  textSize(30);
  text(txt, x, y);
}

void shuffleArrays(PImage[] array1, String[] array2) {
  for (int i = array1.length - 1; i > 0; i--) {
    int index = (int) random(i + 1);
    // Swap elements
    PImage temp1 = array1[index];
    array1[index] = array1[i];
    array1[i] = temp1;
    
    String temp2 = array2[index];
    array2[index] = array2[i];
    array2[i] = temp2;
  }
}
