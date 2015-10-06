void drawGreetingCircles(){
  for (int i = circles.size()-1; i>= 0; i--){
              circleFade circle = circles.get(i);
              circle.draw();
              circle.update();
              if (circle.done){
                circles.remove(i);
              }
             }
  

  
}
