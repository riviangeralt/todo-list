import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.title,
    this.description = '',
    required this.id,
    required this.onDelete,
    required this.onEdit,
  });

  final String title;
  final String? description;
  final int id;
  final void Function(int id) onDelete;
  final void Function(int id) onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description ?? ''),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => onEdit(id),
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () => onDelete(id),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
