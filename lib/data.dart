import 'package:dio/dio.dart';

class StudentData {
  final String firstName;
  final String lastName;
  final String course;
  final int score;
  final String createAt;
  final String updateAt;

  StudentData(
      {required this.firstName,
      required this.lastName,
      required this.course,
      required this.score,
      required this.createAt,
      required this.updateAt});
  StudentData.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        course = json['course'],
        score = json['score'],
        createAt = json['createAt'],
        updateAt = json['updateAt'];
}

class HttpClient {
  static Dio instance = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
}

Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.instance.get('students');
  final List<StudentData> students = [];
  if (response.data is List<dynamic>) {
    (response.data as List<dynamic>).forEach((element) {
      students.add(StudentData.fromJson(element));
    });
  }
  return students;
}
