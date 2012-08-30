#library('Level');
#import('../PhysicalObjects/PhysicalObject.dart');
#import('../PhysicalObjects/ActiveObjects/Airplane/Airplane.dart');
#import('../Graphics.dart');
#import('../Utilities.dart');
#import('../GameMode.dart');
class Level
{
  num width, height;
  List<PhysicalObject> physicalObjects;
  num panFocus;
  num GRAVITY = 1000;
  
  Level(){
    height = 2000;
    width = 1000;
    physicalObjects = new List<PhysicalObject>();
  }
  
  vector2 windspeed(vector2 p) => new vector2(0,0);
  
  bool get loading(){
    bool loading = false;
    for(int i = 0; i < physicalObjects.length; i++){
      if(physicalObjects[i].loading) loading = true;      
    }
    return loading;
  }
  
  update(num t,num dt){
    physicalObjects.forEach(void f(PhysicalObject element){element.update(t,dt);});
    //set pan to focus on the physical object identified by panFocus

  }
  
  
 /* void collisionCheck(){
    for(int i = 0; i < dynamicElements[0].pointsForCollisionChecking.length; i++){
      vector2 orgpoint = dynamicElements[0].pointsForCollisionChecking[i];
      num orgx = orgpoint.x,orgy = orgpoint.y;
      num newx = 0, newy = 0;
      newx = orgpoint.x*Math.cos(-dynamicElements[0].rot * Math.PI/180) - orgpoint.y*Math.sin(-dynamicElements[0].rot * Math.PI/180);
      newy = orgpoint.x*Math.sin(-dynamicElements[0].rot * Math.PI/180) + orgpoint.y*Math.cos(-dynamicElements[0].rot * Math.PI/180);
      newx += dynamicElements[0].x;
      newy += dynamicElements[0].y;
      if(newy > background.ielement.height){
        newy = background.ielement.height;
        print('y > 1000!');
      }
      int color = background.getPixelColor(new vector2(newx,newy));
      if(color != -1 && color != 0){
     //   print('color != -1, color = $color');
      }
      if(color== -16777216||newx > background.ielement.width||newx < 0||newy > background.ielement.height||newy < 0){
        print('collision!');
        
        num rot =  Math.atan2(orgy,orgx);
        force f = new force(dynamicElements[0].xSpeed,dynamicElements[0].ySpeed);
        f.rotate(rot);
        if(f.x > 0)f.x *= -dynamicElements[0].REBOUNDFACTOR;
        f.rotate(-rot);
        dynamicElements[0].xSpeed = f.x;
        dynamicElements[0].ySpeed = f.y;
        
 //       Point absCollisionPoint = new Point(orgx.abs(),orgy.abs());
  //      if(absCollisionPoint.x * dynamicElements[0].xSpeed > 0) dynamicElements[0].xSpeed *= -dynamicElements[0].REBOUNDFACTOR;
   //     if(absCollisionPoint.y * dynamicElements[0].ySpeed > 0) dynamicElements[0].ySpeed *= -dynamicElements[0].REBOUNDFACTOR;
      }
    }
  }*/
  render(num alpha){
    vector2R correctedPos = physicalObjects[panFocus].position*alpha + physicalObjects[panFocus].previousState.pos*(1-alpha);
    graphics.xpan = correctedPos.x - graphics.canvas.width/2;
    graphics.ypan = correctedPos.y - graphics.canvas.height/2;
    if(graphics.xpan < 0)graphics.xpan = 0;
    if(graphics.xpan > width - graphics.canvas.width)graphics.xpan = width - graphics.canvas.width;
    if(graphics.ypan > height - graphics.canvas.height) graphics.ypan = height - graphics.canvas.height;
    if(graphics.ypan < 0) graphics.ypan = 0;
    physicalObjects.forEach(void f(var element){element.render(alpha);});
  }
  
  
  
}