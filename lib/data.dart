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
      String? createAt,
      String? updateAt})
      : createAt = createAt ?? DateTime.now().toIso8601String(),
        updateAt = updateAt ?? DateTime.now().toIso8601String();
  StudentData.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        course = json['course'],
        score = json['score'],
        createAt = json['createAt'],
        updateAt = json['updateAt'];

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'course': course,
        'score': score,
        'createAt': createAt,
        'updateAt': updateAt,
      };
}

class HttpClient {
  static Dio instance = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
}

Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.instance.get('students');
  final List<StudentData> students = [];
  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      students.add(StudentData.fromJson(element));
    }
  }
  return students;
}

Future<StudentData> saveStudent(StudentData student) async {
  final response =
      await HttpClient.instance.post('students', data: student.toJson());
  return StudentData.fromJson(response.data);
}
