// We can also make our own "Type"s in processing by making something called a Class.
// A class can be thought of as a type that is made up of other types.
// Below is a small example of a "Class" in processing.
class Human {
  int age;
  String name;

  //Constructor
  Human(int a, String n) {
    age = a;
    name = n;
  }
  
  void setAge(int a){
    age = a;  
  }
  
  int getAge(){
    return age;  
  }
}