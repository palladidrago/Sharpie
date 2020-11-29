class Grades {
  String title, date, description; //Date: dd/mm/yyyy
  //Description: <b>מבחן: </b>קרופיצקי אלה-מתמטיקה(א-2)</br><b>תאריך: </b> יום שני-ז' כסלו, 23/11
  //</br><b>כיתות: </b> ט 1,ט 2

  Grades(this.title, this.date, {this.description});
}

class Model {
  String firstName;
  String lastName;
  String email;
  String password;

  Model({this.firstName, this.lastName, this.email, this.password});
}
