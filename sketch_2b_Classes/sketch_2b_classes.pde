// We can also make our own "Type"s in processing by making something called a Class.
// A class can be thought of as a type that is made up of other types.
// Below is a small example of a "Class" in processing.
class Human {
  int age;
  String name;

  Human(int a, String n) {
    age = a;
    name = n;
  }
}


//-------------------------------------
void setup() {

  // Create a new 75yr old human named Fred.
  Human human = new Human(75, "Fred");

  // Print "Fred is a 75 yr old human!" to our console.
  println(human.name, "is a", human.age, "yr old human!");
}


//-------------------------------------
void draw() {
}

