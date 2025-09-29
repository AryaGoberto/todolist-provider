import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/todo_provider.dart';
import '../../core/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final todo = context.read<TodoProvider>();
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => todo.removeTask(task.id),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => todo.toggleTask(task.id),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            final controller = TextEditingController(text: task.title);
            final newTitle = await showDialog<String>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Edit Task'),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Task title'),
                  onSubmitted: (v) => Navigator.pop(context, v),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            );
            if (newTitle != null) {
              todo.editTask(task.id, newTitle);
            }
          },
        ),
      ),
    );
  }
}
