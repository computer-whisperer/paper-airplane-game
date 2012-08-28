#library('PhysicalObject');
#import('../Graphics.dart');
#import('../Utilities.dart');


class PhysicalObject extends Graphic  {
  bool loading = false;
  vector2R position;
  num scale;

  State previousState;
  int edgeColor;
  bool active = false;
  num friction = .3;
  num Id;
  PhysicalObject(this.position, this.scale, String graphicPath, this.edgeColor){
    previousState = new State(0,position,new vector2R());
    loading = true;
    LoadGraphic(graphicPath);
    image.on.load.add((var e){
      loadImageData();
      loading = false;
    });
  }
  
  bool isEdge(vector2 point){
    point -= new vector2(position.x,position.y);
    point.rotate(-position.r);
    if(point.x < -width/2 || point.x > width/2 || point.y < -height/2 || point.y > height/2)
      return false;

    return (getPixelColor(point) == edgeColor);
  }
  
  bool addExternalForce(force f){
    return false;
  }
  

  
  update(num t,num dt){
    
  }
  render(num alpha){
    DrawWithScale(position,scale);
  }
}
