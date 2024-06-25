
class UserModel {
  //List<ExamModel>? students;
  String? uid;

  String? name;
  String? deposit;
  String? email;
  String? password;
  // Constructor
  UserModel({
    //required this.students,
    required this.uid,
    required this.email,
    required this.password,
    required this.deposit,
    required this.name,
  });

  // Factory method to create a User object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(

    //  students: List<Student_Model>.from(json['students'] as List<Student_Model>),
      email: json['email'],
      deposit: json['deposit'],
      password: json['password'],
      uid: json['uid'],
      name: json['name'],
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
  //  dynamic studentsJson = students?.map((student) => student.toJson()).toList() ?? [];

    return {
      'name': name,
      'deposit': deposit,
      'uid': uid,
      'password': password,
      'email': email,
     // 'students': studentsJson,
    };
  }
}
