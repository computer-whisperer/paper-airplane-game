#library('background');
#import('../Graphics.dart');
#import('../Utilities.dart');
#import('../PaperAirplane.dart');
#import('PhysicalObject.dart');
#import('dart:html');

class Background extends PhysicalObject {
  Background(String graphicPath):super(new vector2R(0,0,0),1,graphicPath,-16777216){
    loading = true;
    image.on.load.add((var e){
    position = new vector2R(image.width/2,image.height/2,0);
    gameMode.level.width = image.width;
    gameMode.level.height = image.height;
    graphics.resizeCanvas();
    loading = false;
    });

  }
}
