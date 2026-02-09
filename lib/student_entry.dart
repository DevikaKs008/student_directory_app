import 'package:flutter/material.dart';
import 'package:student_directory_app/service.dart';

class StudentEntry extends StatefulWidget {
  const StudentEntry({super.key});

  @override
  State<StudentEntry> createState() => _StudentEntryState();
}

class _StudentEntryState extends State<StudentEntry> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getstudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]["name"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]["email"]),
                    Text(data[index]["course"]),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        deletestudent(data[index].id, context);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 8, 89, 109),
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text("Student Directory"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add student"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(6, 8, 55, 255),
                        filled: true,
                        hintText: "name",
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(6, 8, 55, 255),
                        filled: true,
                        hintText: "email",
                      ),
                    ),
                    TextField(
                      controller: courseController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(6, 8, 55, 255),
                        filled: true,
                        hintText: "course",
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        addstudent(
                          nameController.text,
                          emailController.text,
                          courseController.text,
                          context,
                        );
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 3, 72, 87),
        foregroundColor: Colors.white,
      ),
    );
  }
}
