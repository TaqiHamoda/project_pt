class Goal{
  String goal;
  bool reached = false;

  Goal(this.goal);

  void reachedGoal(){
    this.reached = true;
  }
}