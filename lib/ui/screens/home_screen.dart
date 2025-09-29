import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/todo_provider.dart';
import '../widget/task_item.dart';
import '../widget/add_task_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TodoProvider>().tasks;

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do (Provider)')),
      body: tasks.isEmpty
          ? const Center(child: Text('Belum ada task. Tambah yuk!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, i) => TaskItem(task: tasks[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskSheet(),
          );
          if (title != null) {
            context.read<TodoProvider>().addTask(title);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
