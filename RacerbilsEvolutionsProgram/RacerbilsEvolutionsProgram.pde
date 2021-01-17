//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 500;

int generation = 0;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//ArrayList for the points
ArrayList<PVector> point = new ArrayList<PVector>();

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;



void setup() {
  size(1152, 800);
  trackImage = loadImage("CarBane.png");

  //checkpoint
  point.add(new PVector(409, 182));
  point.add(new PVector(129, 199));
  point.add(new PVector(71, 443));
  point.add(new PVector(145, 666));
  point.add(new PVector(524, 688));
  point.add(new PVector(886, 690));
  point.add(new PVector(1025, 502));
  point.add(new PVector(1010, 280));
  point.add(new PVector(813, 178));
  point.add(new PVector(600, 182));
}

void draw() {
  clear();
  background(255);
  image(trackImage, 0, 80);
  noStroke();
  fill(255, 0, 0);
  rect(600, 140, 2, 80);

  fill(0);
  text("The Current Generation is: "+generation, 20, 20);

  //draw points
  fill(255, 255, 102);
  for (int i = 0; i < point.size(); i++) {
    ellipse(point.get(i).x, point.get(i).y, 10, 10);
  }

  carSystem.disable();
  carSystem.updateAndDisplay();


}
