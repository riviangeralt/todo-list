import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    this.list,
    required this.onDelete, required this.onEdit,
  });

  final List? list;
  final void Function(int id) onDelete;
  final void Function(int id) onEdit;

  @override
  Widget build(BuildContext context) {
    return list != null && list!.isNotEmpty
        ? ListView.builder(
            itemCount: list!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return TodoItem(
                id: list![index].id,
                title: list![index].title ?? '',
                description: list![index].description ?? '',
                onDelete: onDelete,
                onEdit: onEdit,
              );
            },
          )
        : const SizedBox(
          height: 300.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber),
                Text('No Data Available')
              ],
            ),
          ),
        );
  }
}
