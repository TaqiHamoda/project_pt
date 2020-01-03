class User{
  String firstName;
  String lastName;
  String email;
  String _password;
  String phoneNum;
  String age;
  List<User> messageList = [];

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
    this.messageList.add(trainer);
  }

  void addWorkout(){}

}


class Trainer extends User{
  List<Client> clients = [];

  Trainer(String firstName, String lastName, String email, String password, String cellNum, {age = ''}) :
        super(firstName, lastName, email, password, cellNum, age: age);

  void addClient(Client client){
    this.clients.add(client);
  }

  void addClientMessage(Client client){
    this.messageList.add(client);
  }

}

class Director extends Trainer{
  List<Trainer> trainers;

  Director(String firstName, String lastName, String email, String password, String cellNum, {age = ''}) :
        super(firstName, lastName, email, password, cellNum, age: age);

  void addTrainer(Trainer trainer){
    this.trainers.add(trainer);
  }
}


List<User> localUsers(){
  Trainer trainer = Trainer('Taqi', 'Hamoda', 'taqi@app.com', 'Bebop', '1234567890');
  Client james = Client('James', 'Bob', 'james@app.com', 'Bebop', '1234567890', trainer);
  Client juan = Client('Juan', 'Martinez', 'juan@app.com', 'Bebop', '1234567890', trainer);
  Client sidney = Client('Sidney', 'Austaralia', 'sidney@app.com', 'Bebop', '1234567890', trainer);
  Client richard = Client('Richard', 'Henry', 'richard@app.com', 'Bebop', '1234567890', trainer);
  Client jonathan = Client('Jonathan', 'Joestar', 'jonathan@app.com', 'Bebop', '1234567890', trainer);
  Client dio = Client('Dio', 'Brando', 'dio@app.com', 'Bebop', '1234567890', trainer);
  Client joseph = Client('Joseph', 'Joestar', 'joseph@app.com', 'Bebop', '1234567890', trainer);
  Client jotaro = Client('Jotaro', 'Kujo', 'jotaro@app.com', 'Bebop', '1234567890', trainer);
  Client johnny = Client('Johnny', 'Joestar', 'johnny@app.com', 'Bebop', '1234567890', trainer);

  trainer.addClient(james);
  trainer.addClient(juan);
  trainer.addClient(sidney);
  trainer.addClient(richard);
  trainer.addClient(jonathan);
  trainer.addClient(joseph);
  trainer.addClient(dio);
  trainer.addClient(jotaro);
  trainer.addClient(johnny);
  trainer.messageList.addAll(trainer.clients); // for now.


  return [trainer, james, juan, sidney, richard, jonathan, dio, joseph, jotaro, johnny];
}
