library LevelSelect;
import 'dart:html';
import 'Levels/Level.dart';
import "Levels/DeadWeightTestLevel/DeadWeightTestLevel.dart";
import 'Levels/GenericLevel/GenericLevel.dart';
import 'PaperAirplane.dart';
import 'GameMode.dart';
import 'Graphics.dart';

String levelsrc = 'Levels/GenericLevel/airplane-game.png';

void importBackground(Event e){
  FileReader reader = new FileReader();
  FileList flist = e.target.files;
  File file = flist[0];
  reader.readAsDataURL(file);
  reader.on.load.add((var e){levelsrc = e.target.result;});
}

class LevelSelect{
  num width, height;
  bool loading = false;
  LevelSelect(){
    width = 10;
    height = 10;
    document.query('input').on.change.add(importBackground);
    document.query('button').on.click.add((var e){startLevel();});
  }

  void startLevel(){
   gameMode.level = new GenericLevel(levelsrc);
   gameMode.change(1);
  }

  void render(){}

  void update(num t,num dt){}

}
