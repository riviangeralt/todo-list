import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/data/models/todo.dart';

class TodoRepository {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoModelSchema],
      directory: dir.path,
    );
  }

  final List<TodoModel> todayTodos = [];
  final List<TodoModel> tomorrowTodos = [];
  final List<TodoModel> upcomingTodos = [];

  Future<List<TodoModel>> getTodayTodos() async {
    final List<TodoModel> allTodos =
        await isar.todoModels.filter().typeMatches('today').findAll();
    todayTodos.clear();
    todayTodos.addAll(allTodos);
    return todayTodos;
  }

  Future<List<TodoModel>> getTomorrowTodos() async {
    final List<TodoModel> allTodos =
        await isar.todoModels.filter().typeEqualTo('tomorrow').findAll();

    return allTodos;
  }

  Future<List<TodoModel>> getUpcomingTodos() async {
    final List<TodoModel> allTodos =
        await isar.todoModels.filter().typeEqualTo('upcoming').findAll();

    return allTodos;
  }

  Future<void> createTodo(TodoModel todo) async {
    await isar.writeTxn(
      () => isar.todoModels.put(todo),
    );
    await getTodayTodos();
    await getTomorrowTodos();
    await getUpcomingTodos();
  }

  Future<void> updateTodo(int id, TodoModel updatedTodo) async {
    final todo = await isar.todoModels.get(id);
    if (todo != null) {
      await isar.writeTxn(
        () => isar.todoModels.put(updatedTodo),
      );
      await getTodayTodos();
      await getTomorrowTodos();
      await getUpcomingTodos();
    }
  }

  Future<void> deleteTodo(int id) async {
    final todo = await isar.todoModels.get(id);
    if (todo != null) {
      await isar.writeTxn(
        () => isar.todoModels.delete(id),
      );
      await getTodayTodos();
      await getTomorrowTodos();
      await getUpcomingTodos();
    }
  }

  Future<TodoModel?> getSelectedTodo(int id) async {
    final todo = await isar.todoModels.get(id);
    return todo;
  }
}
