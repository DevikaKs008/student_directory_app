import 'package:cloud_firestore/cloud_firestore.dart';
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
  void editbox(DocumentSnapshot doc) {
    nameController.text = doc["name"];
    emailController.text = doc["email"];
    courseController.text = doc["course"];
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [
          Text(
            "Edit Student",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Name",
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Email",
              fillColor: const Color.fromARGB(255, 11, 11, 11),
            ),
          ),
          TextField(
            controller: courseController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Course",
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 60,
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 8, 89, 109),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                updatestudent(
                  doc.id,
                  nameController.text,
                  emailController.text,
                  courseController.text,
                  context,
                );
              },

              child: Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

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
                      onPressed: () {
                        editbox(data[index]);
                      },
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
