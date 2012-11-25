library PaperAirplane;
import 'dart:html';
import 'Levels/Level.dart';
import "Levels/GenericLevel/GenericLevel.dart";
import 'Graphics.dart';
import 'LevelSelect.dart';
import 'GameMode.dart';

bool framerateData = true;
GameMode gameMode;
Stopwatch timer;
num updateTimeout;
num renderTimeout;
num uCurrentTime = 0;
num rCurrentTime = 0;
num uStartTime = 0;
num rStartTime = 0;
num uDeltaTime = 1/100;
num rDeltaTime = 1/70;
num uFrameTime = 0;
num rFrameTime = 0;
num physicsTimePerFrame = .002;
Element frameRateData;

void main() {
  graphics = new Graphics(query('canvas'));
  gameMode = new GameMode();
  frameRateData = query('.framerateData');
  timer = new Stopwatch()..start();
  updateLoop();
  renderLoop();
}


updateLoop(){
  uStartTime = timer.elapsed()/timer.frequency();
  if(!gameMode.loading)
  gameMode.update(uStartTime, uDeltaTime);
  uCurrentTime = timer.elapsed()/timer.frequency();
  uFrameTime = uCurrentTime - uStartTime;
  updateTimeout = window.setTimeout(updateLoop,(uDeltaTime - uFrameTime/1000).toInt());
}

renderLoop(){
  rStartTime = timer.elapsed()/timer.frequency();
  if(!gameMode.loading)
  gameMode.render(1);
  rCurrentTime = timer.elapsed()/timer.frequency();
  rFrameTime = rCurrentTime - rStartTime;
  renderTimeout = window.setTimeout(renderLoop,(rDeltaTime - rFrameTime/1000).toInt());
}

/*gameLoop1(){
  newTime = timer.elapsed()/timer.frequency();
  frameTime = newTime - currentTime;
  if ( frameTime > deltaTime * 3 )
    frameTime = deltaTime * 3;
  currentTime = newTime;
  accumulator += frameTime - .005;
  int i = 0;
  num s;
  while(accumulator >= deltaTime){
    if(gameMode.loading == false){
      s = timer.elapsed()/timer.frequency();
     gameMode.update(time,deltaTime);
     s -= timer.elapsed()/timer.frequency();
     }
    accumulator -= deltaTime;
    time+=deltaTime;

    i++;
  }
  if(framerateData)frameRateData.innerHTML = 's = $s <br/>ptpf = $physicsTimePerFrame <br/>  fps = ${1/frameTime} <br/> frameTime = $frameTime <br/> deltaTime = $deltaTime, <br/> accumulator = $accumulator <br/> time = $time <br/> currentTime = $currentTime <br/> newTime = $newTime  <br/> i = $i ';
  gameMode.render(accumulator/deltaTime);
  window.setTimeout(gameLoop1,3);
}*/






