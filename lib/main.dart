import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Task Tracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: TaskHome(),
    );
  }
}

class TaskHome extends StatefulWidget {
  @override
  _TaskHomeState createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController controller = TextEditingController();

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      tasks.add({"title": title, "done": false});
    });
    controller.clear();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quick Task Tracker")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "New Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => addTask(controller.text),
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text("No tasks yet!"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (_, index) {
                      final task = tasks[index];
                      return ListTile(
                        title: Text(
                          task["title"],
                          style: TextStyle(
                            decoration: task["done"]
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: task["done"],
                          onChanged: (_) => toggleTask(index),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
