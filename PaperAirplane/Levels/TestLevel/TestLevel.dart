library TestLevel;
import '../Level.dart';
import '../../Graphics.dart';

class TestLevel extends Level {

  TestLevel(){
    background = new Graphic();
    backgroundOutline = new Graphic();
    background.LoadGraphic("Levels/TestLevel/TestLevelMain.png");
    backgroundOutline.LoadGraphic("Levels/TestLevel/TestLevelOutline.png");
  }
  draw(){
    num a = graphics.xpan % 1000;
    num b = (graphics.xpan - a)/1000;
    background.Draw(1000*(b+1), 500, 0);
    background.Draw(1000*b, 500, 0);
    background.Draw(1000*(b-1), 500, 0);
    super.draw();
  }




}
