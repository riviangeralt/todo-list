import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_list/data/models/todo.dart';
import 'package:todo_list/data/repositories/todo_repository.dart';
import 'package:todo_list/ui/screens/add_todo_screen.dart';

class HomeViewModel extends GetxController {
  static HomeViewModel get instance => Get.find();

  RxInt selectedIndex = 0.obs;
  RxnInt selectedTodo = RxnInt();
  RxList<TodoModel> todayTodos = <TodoModel>[].obs;
  RxList<TodoModel> tomorrowTodos = <TodoModel>[].obs;
  RxList<TodoModel> upcomingTodos = <TodoModel>[].obs;

  void onTabChanged(int index) {
    selectedIndex.value = index;
  }

  void navigateToAddTodoScreen() {
    Get.to(
      () => const AddTodoScreen(),
    );
  }

  void navigateBack() {
    selectedTodo.value = null;
    Get.back();
  }

  void fetchTodayTodos() async {
    try {
      List<TodoModel> todos = await TodoRepository().getTodayTodos();
      todayTodos.value = todos.obs;
    } catch (e) {
      log('Error fetching today todos: $e');
    }
  }

  void fetchTomorrowTodos() async {
    try {
      List<TodoModel> todos = await TodoRepository().getTomorrowTodos();
      tomorrowTodos.value = todos.obs;
    } catch (e) {
      log('Error fetching tomorrow todos: $e');
    }
  }

  void fetchUpcomingTodos() async {
    try {
      List<TodoModel> todos = await TodoRepository().getUpcomingTodos();
      upcomingTodos.value = todos.obs;
    } catch (e) {
      log('Error fetching upcoming todos: $e');
    }
  }

  void removeTodo(int id) async {
    try {
      await TodoRepository().deleteTodo(id);
      fetchTodayTodos();
      fetchTomorrowTodos();
      fetchUpcomingTodos();
    } catch (e) {
      log('Error removeTodo: $e');
    }
  }

  void editTodo(int id) async {
    try {
      selectedTodo.value = id;
      Get.to(() => const AddTodoScreen());
    } catch (e) {
      log('Error removeTodo: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTodayTodos();
    fetchTomorrowTodos();
    fetchUpcomingTodos();
  }
}
