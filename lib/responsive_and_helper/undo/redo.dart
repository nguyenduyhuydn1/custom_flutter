import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String name;

  Todo({required this.id, required this.name});
}

class RedoUndoStore extends ChangeNotifier {
  List<Todo> todos = [];
  int index = 0;

  void add(Todo item) {
    final length = todos.length - 1;
    todos.removeRange(index, length);
    todos.add(item);
    index++;
    notifyListeners();
  }

  void remove(String id) {
    final temp = todos.where((e) => e.id != id).toList();
    todos = temp;
    notifyListeners();
  }

  Todo undo() {
    index--;
    index = index < 0 ? 0 : index;
    return todos[index];
  }

  Todo redo() {
    index++;
    final length = todos.length - 1;
    index = index >= length ? length : index;
    return todos[index];
  }
}
