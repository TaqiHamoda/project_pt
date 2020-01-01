import 'users.dart';

List<User> users = [];

void createUsers(){
  Trainer trainer = Trainer('Taqi', 'Hamoda', 'taqi@app.com', 'passwordbb', '1234567890');
  Client client = Client('Bob', 'James', 'bob@app.com', 'Bebop', '1234567890', trainer);

  users.addAll([trainer, client]);
}
