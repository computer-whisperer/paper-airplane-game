#library('GameMode');
#import('Levels/Level.dart');
#import('LevelSelect.dart');
class GameMode {
  num get width(){
    switch(mode){
      case 1:
        return level.width;
      case 0:
        return levelSelect.width;
    }
  }
  num get height(){
    switch(mode){
      case 1:
        return level.height;
      case 0:
        return levelSelect.height;
    }
  }
  bool get loading(){
    switch(mode){
      case 1:
        return level.loading;
      case 0:
        return levelSelect.loading;
    }
  }
  Level level;
  LevelSelect levelSelect;
  num mode = 0;
  GameMode(){
    levelSelect = new LevelSelect();
  }
  
  change(num m){
    mode = m;
  }
  
  update(num t, num dt){
    switch(mode){
      case 1:
        return level.update(t, dt);
      case 0:
        return levelSelect.update(t, dt);
    }
  }
  
  render(num alpha){
    switch(mode){
      case 1:
        return level.render(alpha);
      case 0:
        return levelSelect.render();
    }
  }
}
