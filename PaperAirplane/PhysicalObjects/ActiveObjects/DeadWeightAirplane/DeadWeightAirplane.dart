#library('DeadWeightAirplane');
#import('../../../Graphics.dart');
#import('../../../PaperAirplane.dart');
#import('../../../Utilities.dart');
#import('../../PhysicalObject.dart');
#import('../ActiveObject.dart');
#import('dart:core');
#import('dart:html');

class DeadWeightAirplane extends ActiveObject {
  DeadWeightAirplane(vector2R position, num mass) : super(position, 1/3, new vector2R(), mass, "PhysicalObjects/ActiveObjects/Airplane/PaperAirplane.png", -16777216){
  forces.add(gravity);
  }

}
