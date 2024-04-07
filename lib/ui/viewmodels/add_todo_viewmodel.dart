import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/data/models/todo.dart';
import 'package:todo_list/data/repositories/todo_repository.dart';
import 'package:todo_list/ui/viewmodels/home_viewmodel.dart';

class AddTodoViewModel extends GetxController {
  static AddTodoViewModel get instance => Get.find();

  final homeController = Get.put(HomeViewModel());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Map<int, String> types = {
    0: "today",
    1: "tomorrow",
    2: "upcoming",
  };

  void addTodo() async {
    if (formKey.currentState!.validate()) {
      final todo = TodoModel();
      if (homeController.selectedTodo.value != null) {
        todo.id = homeController.selectedTodo.value!;
      }
      todo.title = titleController.text;
      todo.description = descriptionController.text;
      todo.type = types[homeController.selectedIndex.value].toString();
      if (homeController.selectedTodo.value != null) {
        await TodoRepository().updateTodo(
          homeController.selectedTodo.value!,
          todo,
        );
      } else {
        await TodoRepository().createTodo(todo);
      }
      homeController.fetchTodayTodos();
      homeController.fetchTomorrowTodos();
      Get.back();

      Get.snackbar(
        "Success",
        "Todo Added Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check),
      );
    }
  }

  void fetchSelectedTodo() async {
    final todo = await TodoRepository()
        .getSelectedTodo(homeController.selectedTodo.value!);
    titleController.text = todo!.title;
    descriptionController.text = todo.description ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    if (homeController.selectedTodo.value != null) {
      fetchSelectedTodo();
    }
  }
}
