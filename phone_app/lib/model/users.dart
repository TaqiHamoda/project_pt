import 'package:crypto/crypto.dart';
import 'dart:convert';  // for the utf8.encode method

class User{
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  User(firstName, lastName, email, phoneNumber, password){
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phoneNumber = phoneNumber;

    this.storeData(password);
  }

  User.exist(this.firstName, this.lastName, this.email, this.phoneNumber);

  void storeData(String password){}  //Will send the data to server and store

  void setEmail(String email){ this.email = email; }
  String getEmail(){ return this.email; }

  bool checkPassword(String pass){
    return Password.hash(password, PBKDF2()) == this.password;
  }
}

class Client extends User {
  String trainer;

  Client(firstName, lastName, email, phoneNumber, password, trainer) :
    super(firstName, lastName, email, phoneNumber, password) {
    this.trainer = trainer;
  }


}


//class Trainer extends User{}


//class Supervisor extends Trainer{}


//class Director extends Supervisor{}


void main(){
  print(Password.hash("password", PBKDF2()));
}