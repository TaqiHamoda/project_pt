class User{
  String firstName;
  String lastName;
  String email;
  String _password;
  String phoneNum;
  String age;

  User(firstName, lastName, email, password, cellNum, {age = ''}){
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this._password = password;
    this.phoneNum = cellNum;
    this.age = age;
  }

  bool signIn(String password){
    return this._password == password;
  }
}

class Client extends User{

  List workouts = [];
  Trainer trainer;

  Client(String firstName, String lastName, String email, String password, String cellNum, Trainer trainer, {age = ''}) :
        super(firstName, lastName, email, password, cellNum, age: age){
    this.trainer = trainer;
  }

  void addWorkout(){}

}


class Trainer extends User{
  List<Client> clients = [];

  Trainer(String firstName, String lastName, String email, String password, String cellNum, {age = ''}) :
        super(firstName, lastName, email, password, cellNum, age: age);

}


List<User> createUsers(){
  Trainer trainer = Trainer('Taqi', 'Hamoda', 'taqi@app.com', 'passwordbb', '1234567890');
  Client client = Client('Bob', 'James', 'bob@app.com', 'Bebop', '1234567890', trainer);

  return [trainer, client];
}
