import 'paperwork.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/director/director_card.dart';
import 'package:phone/screens/director/trainer_card.dart';

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

  List<ClientCard> cards(){
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
  List<Trainer> trainers = [];
  List<Director> directors = [];

  Director(String firstName, String lastName, String email, String password, String cellNum) :
        super(firstName, lastName, email, password, cellNum);

  void addTrainer(Trainer trainer){
    this.trainers.add(trainer);
  }

  void addDirector(Director director){
    this.directors.add(director);
  }

  List<DirectorCard> directorCards(){
    List<DirectorCard> cards = [];

    for(Director director in this.directors){
      cards.add(DirectorCard(
          director: director,
          name: director.firstName + " " + director.lastName));
    }

    return cards;
  }


  List<TrainerCard> trainerCards(){
    List<TrainerCard> cards = [];

    for(Trainer trainer in this.trainers){
      cards.add(TrainerCard(
          trainer: trainer,
          name: trainer.firstName + " " + trainer.lastName));
    }

    return cards;
  }

  List<ClientCard> clientCards(){
    List<ClientCard> cards = [];

    for(User user in localUsers()){
      if(user is Client){
        cards.add(ClientCard(
            client: user,
            name: user.firstName + " " + user.lastName));
      }
    }

    return cards;
  }



}


List<User> localUsers(){
  Director director = Director('Youssef', 'Nafei', 'you@app.com', 'a7a', '123456789');
  Director mo = Director('Mo', 'Momo', 'mo@app.com', 'a7a', '123456789');

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
