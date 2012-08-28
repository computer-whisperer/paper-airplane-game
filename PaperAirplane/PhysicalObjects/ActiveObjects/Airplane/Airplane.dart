#library('Airplane');
#import('../../../Graphics.dart');
#import('../../../PaperAirplane.dart');
#import('../../../Utilities.dart');
#import('../../PhysicalObject.dart');
#import('../ActiveObject.dart');
#import('dart:core');
#import('dart:html');

class Airplane extends ActiveObject {
  num AIRFOILLIFTFACTOR = 2;
  num ANGLEOFATTACKLIFTFACTOR = 15;
  num DRAG = -0.00001;
  num ROTATIONFACTOR = 5;
  num REBOUNDFACTOR = 1.00002;
  num DAMAGETHRESHHOLD = 50.0;
  bool leftArrowPressed = false;
  bool rightArrowPressed = false;
  
  
  Airplane(vector2R position,vector2R speed) : super(position, 1/3, speed, .5, "PhysicalObjects/ActiveObjects/Airplane/PaperAirplane.png", -16777216){
    document.on.keyDown.add((KeyboardEvent event) {
      switch (event.keyCode) {
        case 37:
          leftArrowPressed = true;
          rightArrowPressed = false;
          break;
        case 39:
          rightArrowPressed = true;
          leftArrowPressed = false;
          break;
      }});
      document.on.keyUp.add((KeyboardEvent event) {        
        switch (event.keyCode) {
          case 37:
            leftArrowPressed = false;
            break;
          case 39:
            rightArrowPressed = false;
            break;
        }});
      forces.add(gravity);
      forces.add(drag);
      forces.add(lift);
     // forces.add(elevator);
    }
    
  
  force lift(State state, num t){
    vector2 windspeed = state.vel + gameMode.level.windspeed(position);
    windspeed.rotate(-state.pos.r);
    num airfoilLift = AIRFOILLIFTFACTOR*windspeed.x.abs();
    num aoaLift = -windspeed.y*ANGLEOFATTACKLIFTFACTOR;
    force total = new force(new vector2(0,airfoilLift+aoaLift), new vector2(0,0));
    total.rotateForce(state.pos.r);
    total.forceVector.rindex = 0;
    return total;
  }
  
  force drag(State state, num t){
    vector2 windspeed = state.vel + gameMode.level.windspeed(position);
    windspeed.rotate(-state.pos.r);
    force d = new force(new vector2(windspeed.x*DRAG,0),new vector2(0,0));
    d.rotateForce(state.pos.r);
    d.forceVector.rindex = 0; 
    return d;
    }
  
  force elevator(State state, num t){
    vector2 windspeed = state.vel + gameMode.level.windspeed(position);
    windspeed.rotate(-state.pos.r);
    force rot = new force(new vector2(0,0), new vector2(-20,0));
    if(rightArrowPressed)rot.forceVector.y -= ROTATIONFACTOR;
    if(leftArrowPressed)rot.forceVector.y += ROTATIONFACTOR ;
    rot.rotateForce(state.pos.r);
    return rot;
  }
  
  void update(num t, num dt){
    if(rightArrowPressed)position.r += ROTATIONFACTOR * dt;
    if(leftArrowPressed)position.r -= ROTATIONFACTOR * dt;
    super.update(t,dt);
  }
}


