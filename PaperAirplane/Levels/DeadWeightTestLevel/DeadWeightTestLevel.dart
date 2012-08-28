#library('DeadWeightTestLevel');
#import('../Level.dart');
#import('../../Graphics.dart');
#import('../../PaperAirplane.dart');
#import('../../PhysicalObjects/Background.dart');
#import('../../Utilities.dart');
#import('../../PhysicalObjects/ActiveObjects/DeadWeightAirplane/DeadWeightAirplane.dart');

class DeadWeightTestLevel extends Level {
  DeadWeightTestLevel(String backgroundPath) : super(){
    physicalObjects.add(new Background(backgroundPath));
    physicalObjects.add(new DeadWeightAirplane(new vector2R(250,750,0),1));
    panFocus = physicalObjects.length - 1;
  }  
}
