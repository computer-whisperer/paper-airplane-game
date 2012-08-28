#library('ActiveObject');
#import('../../PaperAirplane.dart');
#import('../PhysicalObject.dart');
#import('../../Utilities.dart');
#import('dart:html');
#import('dart:math');

class ActiveObject extends PhysicalObject {
  List forces;
  vector2R velocity;
  num mass;
  List edgePoints;
  List externalForces;
  ActiveObject(vector2R pos, num scale, this.velocity, this.mass, String graphicPath, int edgeColor):super(pos, scale, graphicPath, edgeColor){
    Id = new Random().nextDouble();
    externalForces = new List();
    forces = new List();
    forces.add(collisionResults);
    active = true;
    previousState = new State(mass,position,velocity);
    image.on.load.add((var e){
      loading = true;
      edgePoints = parseImageForPixels(edgeColor);
    for(int i = 0; i < edgePoints.length; i++){
      edgePoints[i].x = (edgePoints[i].x-(image.width/2))*scale;
      edgePoints[i].y = (edgePoints[i].y-(image.height/2))*scale;
      loading = false;
    }
    });
  }
  
  update(num t, num dt){
    integrate(t,dt);
    super.update(t,dt);
  }
  
  integrate(num t, num dt){
    previousState = new State(mass,position,velocity);
    RK4Derivative a = RK4Evaluate(previousState, t);
    RK4Derivative b = RK4Evaluate(previousState, t, dt*.5, a);
    RK4Derivative c = RK4Evaluate(previousState, t, dt*.5, b);
    RK4Derivative d = RK4Evaluate(previousState, t, dt, c);
    
    vector2R dxdt = (a.dPos + (b.dPos + c.dPos)*2 + d.dPos)/6;
    vector2R dvdt = (a.dVel + (b.dVel + c.dVel)*2 + d.dVel)/6;
    
    position += dxdt * dt;
    velocity += dvdt * dt;
    }
  
  RK4Derivative RK4Evaluate(State init, num t,[ num dt, RK4Derivative der]){
    RK4Derivative output = new RK4Derivative();
    if(dt != null){
      State state = new State(mass);
      state.pos = init.pos + der.dPos*dt;
      state.vel = init.vel + der.dVel*dt;
      output.dPos = state.vel;
      output.dVel = getTotalForce(state, dt+t);
    }
    else{
      output.dPos = init.vel;
      output.dVel = getTotalForce(init, t);
    }
    return output;
  }
  
  vector2R getTotalForce(State state,num t){
    List forceList = new List();
    for(int i = 0; i<forces.length; i++){
      forceList.add(forces[i](state,t));
      forceList[i].forceVector /= mass;
    }
    forceList.addAll(externalForces);
    externalForces == new List();
    return force.add(forceList);
  }
  
  force gravity(State state,num dt)=> new force(new vector2(0,-gameMode.level.GRAVITY)*mass,new vector2(0,0));
  
  force collisionResults(State state, num dt){
    
    Stopwatch t = new Stopwatch.start();
    List<vector2> allContacts = new List<vector2>();
    List<num> contactNormals = new List<num>();
    List<num> objects = new List<num>();
    
    //get contact points
    
    for(num po = 0; po < gameMode.level.physicalObjects.length; po++){
      if (gameMode.level.physicalObjects[po].Id == Id)continue;
      List<vector2> pointsOfContact = new List<vector2>();
      for(num ep = 0; ep < edgePoints.length; ep++){
        vector2 point = edgePoints[ep];
        point = state.translateToWorld(point);
        if(gameMode.level.physicalObjects[po].isEdge(point)){
          pointsOfContact.add(edgePoints[ep]);
        }
      }
      if(pointsOfContact.length == 1){
        // will implement later
        
      }
      else if(pointsOfContact.length > 1){
        //find the two points that are furthest apart
        num distance = 0, c1, c2;
        for(num cp = 0; cp < pointsOfContact.length; cp++){
          for(num cp2 = 0; cp2 < pointsOfContact.length; cp2++){
            num d = pointsOfContact[cp].getDistanceTo(pointsOfContact[cp2]);
            if(d > distance){
              distance = d;
              c1 = cp;
              c2 = cp2;
            }
          }
        }
        if(pointsOfContact[c2].x-pointsOfContact[c1].x == 0) contactNormals.add(0);
        else contactNormals.add(atan(pointsOfContact[c2].y-pointsOfContact[c1].y/pointsOfContact[c2].x-pointsOfContact[c1].x)+ PI/2);
        allContacts.add(pointsOfContact[c1]+(pointsOfContact[c2]-pointsOfContact[c1])/2);
        objects.add(po);
      }
    }
    //print('all contact points retrieved in ${t.elapsedInMs()} milliseconds');
    // calculate collision reactions
    List<force> collisionReactions = new List<force>();
    for(num c = 0; c < allContacts.length; c++){
      vector2 startForce = new vector2(state.vel.x,state.vel.y);
      startForce.rotate(contactNormals[c]);
      force appliedForce = new force(new vector2(-(startForce.y).abs(),startForce.x*(friction+gameMode.level.physicalObjects[objects[c]].friction)/2),state.translateToWorld(allContacts[c]));
      appliedForce.rotateForce(-contactNormals[c]);
      appliedForce.forceVector/=2;
      if(gameMode.level.physicalObjects[objects[c]].addExternalForce(appliedForce)){
        appliedForce.point -= new vector2(state.pos.x, state.pos.y);
        appliedForce.forceVector.rotate(state.pos.r);
        externalForces.add(appliedForce);
      }
      else{
        appliedForce.forceVector *= 2;
        appliedForce.point -= new vector2(state.pos.x, state.pos.y);
        appliedForce.forceVector.rotate(state.pos.r);
        externalForces.add(appliedForce);
      }
    }
    physicsTimePerFrame = t.elapsedInMs();
    return new force(new vector2(),new vector2());
  }
  
  bool addExternalForce(force f){
      f.point -= new vector2(position.x, position.y);
      f.forceVector.rotate(-position.r);
      externalForces.add(f);
      return true;
  }
 
  render(num alpha){
    DrawWithScale(position*alpha + previousState.pos*(1-alpha),scale);
  }
}
