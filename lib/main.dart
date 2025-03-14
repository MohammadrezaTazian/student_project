import 'package:flutter/material.dart';
import 'package:student_project/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newStudent = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddStudentScreen()));
          if (newStudent != null) {
            setState(() {});
          }
        },
        label: const Text('Add New Student'),
        icon: const Icon(Icons.person_add),
      ),
      body: FutureBuilder<List<StudentData>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final student = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8 ),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 50,
                              alignment: Alignment.center,
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              child: Text(student.firstName[0]),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${student.firstName} ${student.lastName}'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.grey),
                                    child: Text(student.course),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Icon(Icons.check),
                                Text(student.score.toString())
                              ],
                            ),

                          ],
                        ),
                    ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final courseController = TextEditingController();
    final scoreController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            final newStudent = await saveStudent(StudentData(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                course: courseController.text,
                score: int.parse(scoreController.text)));
            Navigator.pop(context, newStudent);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        label: const Text('Add Student'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
                    const SizedBox(
            height: 16,
          ),
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: courseController,
            decoration: const InputDecoration(labelText: 'Course'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: scoreController,
            decoration: const InputDecoration(labelText: 'Score'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
