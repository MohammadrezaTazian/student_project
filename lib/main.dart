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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: FutureBuilder<List<StudentData>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final student = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('${student.firstName} ${student.lastName}'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
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
                              )
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
