class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();  

  ////////////////////////////////////////////////////////
  //variable der er tilføjet
  CarController chosenCar;
  boolean finshed = false;
  boolean dead = false;
  float largestValue = 0; 
  float mutationRate = 0.4;
  ////////////////////////////////////////////////////////

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }  


  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }


    checkFin();
    fin();
    reset();
    stopDriveBack();
  }
  /////////////////////////////////////////////////////////////////////////////////////////
  //Find best car with high value using checkpoint
  void BestCar() {
    for (CarController controller : CarControllerList) {
      for (int i = 0; i < carSystem.CarControllerList.size(); i++) {
        Car ref = carSystem.CarControllerList.get(i).bil;

        for (int j = 0; j < point.size(); j++) {
          float dist = dist(ref.pos.x, ref.pos.y, point.get(j).x, point.get(j).y);
          float value = dist * controller.bil.pointPassed ;
          if (largestValue <= value) {
            largestValue = value;              
            //println(largestValue);
            chosenCar = controller;
          }
        }
      }
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////
  //When car near the finishedline it will restar with better generation
  void fin() {
    for (CarController controller : CarControllerList) {
      if (controller.bil.pointPassed == point.size()) { 
        finshed = true;
        //println("restart");
      }
    }
  }

  void reset() {
    boolean allCarsStopped = false;
    for (int j = 0; j < CarControllerList.size(); j++) {
      if (CarControllerList.get(j).bil.vel.x != 0 && CarControllerList.get(j).bil.vel.y != 0) {
        allCarsStopped = false;
        break;
      }
    }

    if (allCarsStopped) {
      for (int k=0; k<populationSize; k++) { 
        CarController controller2 = new CarController();
        CarControllerList.add(controller2);
      }
    }
  }


  void mutation() {
    CarControllerList.clear();
    for (int i = 0; i < populationSize; i++) {
      CarController controller = new CarController();
      for (int j = 0; j < chosenCar.hjerne.weights.length; j++) {
        if (random(0.0, 1.0) < mutationRate) {
          chosenCar.hjerne.weights[j] = chosenCar.hjerne.weights[j] += random(-0.05, 0.05);
        }
        controller.hjerne.weights[j] = chosenCar.hjerne.weights[j];
      }
      for (int j = 0; j < chosenCar.hjerne.biases.length; j++) {
        if (random(0.0, 1.0) < mutationRate) {
          chosenCar.hjerne.biases[j] = chosenCar.hjerne.biases[j] += random(-0.05, 0.05);
        }
        controller.hjerne.biases[j] = chosenCar.hjerne.biases[j];
      }
      CarControllerList.add(controller);
    }
    generation++;
  }


  void checkFin() {
    if (finshed) {
      BestCar();
      mutation();
      finshed = false;
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////

  //Car who drive backward will stop
  void stopDriveBack() {
    for (int i = 0; i < carSystem.CarControllerList.size(); i++) {

      Car ref = carSystem.CarControllerList.get(i).bil;

      float dist = dist(ref.pos.x, ref.pos.y, point.get(9).x, point.get(9).y);
      if (dist < 50 && ref.pointPassed < 8) {
        CarControllerList.get(i).bil.vel.mult(0);
        disable();
      }
    }
  }

  //Car drive out of track will stop
  void disable() {
    for (CarController controller : CarControllerList) {
      if (controller.sensorSystem.whiteSensorFrameCount > 0) {
        controller.bil.disabled = true;
      }
    }
  }
}
