#library('Graphics');
#import('dart:html');
#import('Utilities.dart');
#import('PaperAirplane.dart');

Graphics graphics;

class Graphics {
  
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  num xpan = 0;
  num ypan = 0;
  
  Graphics(this.canvas){
    //set canvas size to max visible without scrolling
    canvas.width = window.innerWidth-100;
    canvas.height = window.innerHeight-100;
    window.on.resize.add((var e){
    resizeCanvas();
    });
    //get the context
    context = canvas.getContext('2d');
  }
  
  void resizeCanvas(){
    //this will be called whenever the window is resized or the level started
    if(gameMode.width == null)return;
    canvas.width = window.innerWidth-100;
    canvas.height = window.innerHeight-100;
    if(canvas.height > gameMode.height)canvas.height = gameMode.height;
    if(canvas.width > gameMode.width)canvas.width = gameMode.width;

  }
  
  void DrawGraphic(ImageElement img, num x, num y, num r){
    context.save();
    context.translate((x-xpan), canvas.height-(y-ypan));
    context.rotate(r);
    context.drawImage(img, -(img.width/2), -(img.height/2));
    context.restore();
  }
  
  void DrawGraphicWithScale(ImageElement img, num x, num y, num r, num scale){
    
    context.save();
    context.translate((x-xpan), canvas.height-(y-ypan));
    context.rotate(r);
    context.drawImage(img, -((img.width*scale)/2), -((img.height*scale)/2),img.width*scale,img.height*scale);
    context.restore();
  }
  
  
  
}


class Graphic{
  ImageElement image;
  ImageData imageData;
  Int32Array pixelData;
  num width, height;
  
  void LoadGraphic(String path){
   image = new ImageElement(path);
   image.on.load.add(f(var e){
     width = image.width;
     height = image.height;
   });
  }
  
  void Draw(vector2R v){
    graphics.DrawGraphic(image, v.x, v.y, v.r);
  }
  
  void DrawWithScale(vector2R v, num s){
    graphics.DrawGraphicWithScale(image, v.x, v.y, v.r, s);
  }
  
  void saveImageData(){
   // data.data.setImageData(buf8);
  
  }
  
  int getPixelColor(vector2 p){
    if(pixelData == null)return 0;
    p.x += width/2;
    p.y += height/2;
    p = p.round();
    if(p.x < 0 || p.x > width || p.y < 0 || p.y > height){
      print('alert');
    }
    p.y = image.height - p.y - 1;
    num i = ((image.width*p.y)+p.x).toInt();
    if(i<0) print('i < 0, i = $i !');
    int color = pixelData[i];
    return color;
  }
  
  void loadImageData(){
    CanvasElement canvas = new CanvasElement();
    canvas.width = image.width;
    canvas.height = image.height;
    CanvasRenderingContext2D context = canvas.getContext('2d');
    context.drawImage(image, 0, 0);
    imageData = context.getImageData(0,0,canvas.width,canvas.height);
    pixelData = new Int32Array.fromBuffer(imageData.data.buffer);
  }
  
  List parseImageForPixels(int hex){
    List result = new List();
    if(hex == null)return result;
    int k;
    for(int i = 0; i < pixelData.length; i++){
      k = pixelData[i];
      if(k == hex){
        num x = i % image.width;
        num y = image.height - ((i-x)/image.width);
        result.add(new vector2(x,y));
      }
    }
    return result;
  } 
}