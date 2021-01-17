class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos = new PVector(542, 182);
  PVector vel = new PVector(0, 5);
  boolean passed = false;
  float pointPassed = 0;
  boolean disabled = false; 

  void turnCar(float turnAngle) {
    vel.rotate(turnAngle);
  }

  void displayCar() {
    stroke(100);
    fill(100);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void update() {
    if (!disabled) {
      pos.add(vel);
    }

    for (int i = 0; i < point.size(); i++) {
      if (i != point.size()) {
        float dist = dist(pos.x, pos.y, point.get(i).x, point.get(i).y);

        if (dist < 40) {
          if (pointPassed < point.size()) {
            pointPassed = i+1;
            passed = true;
          }
        }
      }
    }
  }
}
