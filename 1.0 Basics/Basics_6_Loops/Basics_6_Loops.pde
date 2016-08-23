
void setup(){
  
   //start with a while loop and a counter
    println("------------while loop and a counter");
    int counter = 0;
    while (counter < 5){
        println("counter = " + counter);
        counter++;
    }
    println();
    
    //a for loop is a more concise and expressive way of writing a while loop with a counter
    //here are two for loops with slighty different conditions
    println("------------for (int i = 0; i < 5; i++)");
    for (int i = 0; i < 5; i++){
        println("i = " + i);
    }
    println();
    
    println("------------for (int i = 0; i <= 5; i++)");
    for (int i = 0; i <= 5; i++){
        println("i = " + i);
    }
    println();
    
    //a for loop with a descending counter
    println("------------for (int i = 5; i > 0; i--)");
    for (int i = 5; i > 0; i--){
        println("i = " + i);
    }
    println();
    
    //a for loop with an increment greater than 1
    println("------------for (int i = 0; i < 5; i+=2)");
    for (int i = 0; i < 5; i+=2){
        println("i = " + i);
    }
    println();
    
    println("------------for (int i = 0; i <= 5; i+=2)");
    for (int i = 0; i <= 5; i+=2){
        println("i = " + i);
    }
    println();
    
    //a floating point counter
    println("------------for (float f = 0.0f; f < 0.5; f+=0.1)");
    for (float f = 0.0f; f < 0.5; f+=0.1){
        println("f = " + f);
    }
    println();
    
    //a for loop where the counter decreases in a non-linear way
    println("------------for (float f = 1.0f; f > 0.1; f*=0.5)");
    for (float f = 1.0f; f > 0.1; f*=0.5){
        println("f = " + f);
    }
    println();
    
    println("------------a for loop within a for loop");
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
            println("i = " + i + " | j = " + j);
        }
    }
    println();
    
    println("------------for loop inception!!!!!!");
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
            for (int k = 0; k < 3; k++){
                println("i = " + i + " | j = " + j + " | k = " + k);
            }
        }
    }
    println();
}