Human human1;

//-------------------------------------
void setup() {

  // Create a new 75yr old human named Fred.
  human1 = new Human(75, "Fred");

  // Print "Fred is a 75 yr old human!" to our console.
  println(human1.name, "is a", human1.age, "yr old human!");
}


//-------------------------------------
void draw() {

}

void keyPressed(){
  int freds_age = human1.getAge();
  
  human1.setAge(freds_age + 1);  
  println(human1.name, "is a", human1.age, "yr old human!");
}