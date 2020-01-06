import 'paperwork.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/director/typical_card.dart';

class User{
  String firstName;
  String lastName;
  String email;
  String _password;
  String phoneNum;
  String photo = 'images/profile.png';
  List<User> messageList = [];

  User(firstName, lastName, email, password, cellNum){
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this._password = password;
    this.phoneNum = cellNum;
  }

  bool signIn(String password){
    return this._password == password;
  }

  void setName(String name){

    var splitName = name.split(' ');
    this.firstName = splitName[0];
    this.lastName = splitName[1];
  }

  void setEmail(String email){
    this.email = email;
  }

  void setNumber(String number){
    this.phoneNum = number;
  }

}


class Client extends User{

  List<Program> programs = [];
  Trainer trainer;
  List<Goal> goals = [];

  Client(String firstName, String lastName, String email, String password, String cellNum, Trainer trainer) :
        super(firstName, lastName, email, password, cellNum){
    this.trainer = trainer;
    this.messageList.add(trainer);
  }

  void addProgram(Program program){
    this.programs.add(program);
  }

  void addGoal(String goal){
    this.goals.add(Goal(goal));
  }

}


class Group extends User{
  Trainer trainer;
  List<Program> programs = [];
  List<Client> clients = [];

  Group(String name, Trainer trainer, ) :
  super(null, null, null, null, null){
    this.trainer = trainer;
    this.messageList.add(trainer);
  }

  @override
  bool signIn(String password){
    return false;
  }

  void addClient(Client client){
    this.clients.add(client);
  }

  void addProgram(Program program){
    this.programs.add(program);

    for(Client client in this.clients) {
      client.addProgram(program);
    }
  }
}


class Trainer extends User{
  List<Client> _clients = [];

  Trainer(String firstName, String lastName, String email, String password, String cellNum) :
        super(firstName, lastName, email, password, cellNum);

  void addClient(Client client){
    this._clients.add(client);
  }

  void addClientMessage(Client client){
    this.messageList.add(client);
  }

  List<Client> getClients(User user){
    if ((user is Director) || (user == this)){
      return this._clients;
    }

    return [];
  }

  List<ClientCard> myClientCards(){
    List<ClientCard> cards = [];

    for(Client client in this._clients){
      cards.add(ClientCard(
          client: client,
          name: client.firstName + " " + client.lastName));
    }

    return cards;
  }

}

class Director extends Trainer{
  List<Trainer> _trainers = [];
  List<Director> _directors = [];

  Director(String firstName, String lastName, String email, String password, String cellNum) :
        super(firstName, lastName, email, password, cellNum);

  void addTrainer(Trainer trainer){
    this._trainers.add(trainer);
  }

  void addDirector(Director director){
    this._directors.add(director);
  }


  List<UserCard> directorCards(){
    List<UserCard> cards = [];

    for(Director director in this._directors){
      cards.add(UserCard(director, director.firstName + " " + director.lastName));
    }

    return cards;
  }


  List<UserCard> trainerCards(){
    List<UserCard> cards = [];

    for(Trainer trainer in this._trainers){
      cards.add(UserCard(trainer, trainer.firstName + " " + trainer.lastName));
    }

    return cards;
  }

  List<UserCard> otherClientCards(){
    List<UserCard> cards = [];

    for(Trainer user in (this._trainers + this._directors)){
      for(Client client in user.getClients(user)){
        cards.add(UserCard(client, client.firstName + " " + client.lastName));
      }
    }

    return cards;
  }



}


List<User> localUsers(){
  Director director = Director('Youssef', 'Nafei', 'you@app.com', 'Bebop', '123456789');
  Director mo = Director('Mo', 'Momo', 'mo@app.com', 'Bebop', '123456789');

  Trainer mozza = Trainer('Mozza', 'Hamoda', 'mozza@app.com', 'Bebop', '1234567890');
  Client khalid = Client('Khalid', 'Bob', 'james@app.com', 'Bebop', '1234567890', mozza);
  Client adel = Client('Adel', 'Martinez', 'juan@app.com', 'Bebop', '1234567890', mozza);
  Client ahmed = Client('Ahmed', 'Austaralia', 'sidney@app.com', 'Bebop', '1234567890', mozza);

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

  mozza.addClient(khalid);
  mozza.addClient(adel);
  mozza.addClient(ahmed);

  trainer.addClient(james);
  trainer.addClient(juan);
  trainer.addClient(sidney);
  trainer.addClient(richard);
  trainer.addClient(jonathan);
  trainer.addClient(joseph);
  trainer.addClient(dio);
  trainer.addClient(jotaro);
  trainer.addClient(johnny);
  trainer.messageList.addAll(trainer._clients); // for now.

  director.addTrainer(trainer);
  director.addTrainer(mozza);
  director.addDirector(mo);
  director.addClient(richard);
  director.addClient(dio);




  james.addGoal("Lose 15 lbs before break");
  james.addGoal("Run a marathon in January");
  james.addGoal("Bench 2 plates by the end of the semester");


  return [director, mo, khalid, adel, ahmed, trainer, james, juan, sidney, richard, jonathan, dio, joseph, jotaro, johnny];
}
