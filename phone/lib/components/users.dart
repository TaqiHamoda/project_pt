import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'paperwork.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/director/typical_card.dart';
import 'dart:math';

class User {
  String firstName;
  String lastName;
  String email;
  String _password;
  String phoneNum;
  List<User> messageList = [];
  ImageProvider photo = AssetImage('images/profile.png');

  User(firstName, lastName, email, password, cellNum) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this._password = password;
    this.phoneNum = cellNum;
  }

  bool signIn(String email, String password) {
    return (this.email == email) && (this._password == password);
  }

  void setName(String name) {
    var splitName = name.split(' ');
    this.firstName = splitName[0];
    this.lastName = splitName[1];
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setNumber(String number) {
    this.phoneNum = number;
  }


  void setPassword(String password) {
    this._password = password;
  }

}


class Client extends User{

  List<Program> programs = [];
  Trainer trainer;
  List<Goal> goals = [];
  int sessions;

  Client(String firstName, String lastName, String email, String password, String cellNum) :
        super(firstName, lastName, email, password, cellNum);

  void assignTrainer(Trainer trainer){
    this.trainer = trainer;
    this.messageList.add(trainer);

  }

  void addProgram(Program program){
    this.programs.add(program);
  }

  void addGoal(String goal){
    this.goals.add(Goal(goal));
  }

  void addSessions(int sessionsNum){
    this.sessions = sessionsNum;
  }

}


class Group extends User{
  Trainer trainer;
  List<Program> programs = [];
  List<Client> clients = [];
  List<Goal> goals = [];

  Group(String name, Trainer trainer, ) :
  super(null, null, null, null, null){
    this.messageList.add(trainer);
  }

  @override
  bool signIn(String email, String password){
    return false;
  }

  void addClient(Client client){
    this.clients.add(client);
    this.goals.addAll(client.goals);
    this.trainer = client.trainer;
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
  Director director;

  Trainer(String firstName, String lastName, String email, String password, String cellNum) :
        super(firstName, lastName, email, password, cellNum);

  void addClient(Client client){
    this._clients.add(client);
    client.assignTrainer(this);
  }

  void addClientMessage(Client client){
    this.messageList.add(client);
  }

  void assignDirector(Director director){
    this.director = director;
    this.messageList.add(director);
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

  List<UserCard> viewClientCards(){
    List<UserCard> cards = [];

    for(Client client in this._clients){
      cards.add(UserCard(client, client.firstName + " " + client.lastName));
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
    trainer.assignDirector(this);
  }

  @override
  void assignDirector(Director director);

  void addDirector(Director dir){
    this._directors.add(dir);
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


String phoneNumberGenerator(){
  Random generator = Random();
  String phoneNum = '';

  for(int i = 0; i < 10; i++){
    phoneNum += generator.nextInt(10).toString();
  }

  return phoneNum;
}


List<User> userCreator(){
  Random generator = Random();

  List<String> firstNames = ['Ahmed', 'Jotaro', 'Dio', 'Joe', 'James', 'Juan', 'Richard', 'Ahsan', 'Moaz', 'Mohammed'];
  List<String> lastNames = ['Mo', 'Kujo', 'Martinez', 'Brando', 'Joestar', 'Bob', 'Henry', 'Waheed', 'Mohammed', 'Smith'];
  List<String> goals = ['Lose 15 lbs', 'Get shredded', 'Get deezed', 'Run a marathon', 'Become a beast',
    'Get pussy', 'Bench 3 plates', 'Sqaut 4 plates', 'Gain weight'];

  List<Client> clients = [];

  Director hiro = Director('Hiro', 'Diver', 'hiro@app.com', 'Bebop', phoneNumberGenerator());
  Director youssef = Director('Youssef', 'Nafei', 'you@app.com', 'Bebop', phoneNumberGenerator());

  Trainer taqi = Trainer('Taqi', 'Hamoda', 'taqi@app.com', 'Bebop', phoneNumberGenerator());
  Trainer samy = Trainer('Samy', 'Hamoda', 'samy@app.com', 'Bebop', phoneNumberGenerator());

  Client andrew = Client('Andrew', 'Petersen', 'andrew@app.com', 'Bebop', '1234567890');
  andrew.addGoal('OverHead Press 2 Plates');
  andrew.addGoal('Bench 3 Plates');
  andrew.addGoal('Squat 4 Plates');

  samy.addClient(andrew);
  clients.add(andrew);

  hiro.addTrainer(taqi);
  hiro.addTrainer(samy);
  youssef.addTrainer(taqi);
  youssef.addTrainer(samy);
  hiro.addDirector(youssef);
  youssef.addDirector(hiro);

  for(int i = 0; i < 30; i++){
    String firstName = firstNames[generator.nextInt(firstNames.length)];
    String lastName = lastNames[generator.nextInt(lastNames.length)];
    String goal1 = goals[generator.nextInt(goals.length)];
    String goal2 = goals[generator.nextInt(goals.length)];
    String goal3 = goals[generator.nextInt(goals.length)];

    int number = generator.nextInt(4);

    if(number == 0){
      Client client = Client(firstName, lastName, firstName.toLowerCase() + '@app.com', 'Bebop', phoneNumberGenerator());
      hiro.addClient(client);
      client.addGoal(goal1);
      client.addGoal(goal2);
      client.addGoal(goal3);
    }

    else if(number == 1){
      Client client = Client(firstName, lastName, firstName.toLowerCase() + '@app.com', 'Bebop', phoneNumberGenerator());
      youssef.addClient(client);
      client.addGoal(goal1);
      client.addGoal(goal2);
      client.addGoal(goal3);
    }

    else if(number == 2){
      Client client = Client(firstName, lastName, firstName.toLowerCase() + '@app.com', 'Bebop', phoneNumberGenerator());
      taqi.addClient(client);
      client.addGoal(goal1);
      client.addGoal(goal2);
      client.addGoal(goal3);
    }

    else{
      Client client = Client(firstName, lastName, firstName.toLowerCase() + '@app.com', 'Bebop', phoneNumberGenerator());
      samy.addClient(client);
      client.addGoal(goal1);
      client.addGoal(goal2);
      client.addGoal(goal3);
    }
  }


  List<User> users = [hiro, youssef, taqi, samy];
  users.addAll(clients);

  return users;
}
