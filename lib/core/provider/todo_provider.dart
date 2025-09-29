import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TodoProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    _tasks.add(
      Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    );
    notifyListeners();
  }

  void toggleTask(String id) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    _tasks[idx] = _tasks[idx].copyWith(isDone: !_tasks[idx].isDone);
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void editTask(String id, String newTitle) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx == -1 || newTitle.trim().isEmpty) return;
    _tasks[idx] = _tasks[idx].copyWith(title: newTitle.trim());
    notifyListeners();
  }
}
