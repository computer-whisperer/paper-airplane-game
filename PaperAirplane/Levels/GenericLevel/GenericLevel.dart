library GenericLevel;
import '../Level.dart';
import '../../Graphics.dart';
import '../../PaperAirplane.dart';
import '../../PhysicalObjects/Background.dart';
import '../../Utilities.dart';
import '../../PhysicalObjects/ActiveObjects/Airplane/Airplane.dart';

class GenericLevel extends Level {
  GenericLevel(String backgroundPath) : super(){
    physicalObjects.add(new Background(backgroundPath));
    physicalObjects.add(new Airplane(new vector2R(250,750,0),new vector2R(1000,0,0)));
    panFocus = physicalObjects.length - 1;
  }
}
