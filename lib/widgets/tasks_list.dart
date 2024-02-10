import 'package:flutter/material.dart';

import '../models/task.dart';
import '../blocs/bloc_imports.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: ((context, index) {
            Task task = taskList[index];
            return ListTile(
              title: Text(
                task.title,
              ),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: ((value) {
                  context.read<TaskBloc>().add(UpdateTask(task: task));
                }),
              ),
              onLongPress: () {
                context.read<TaskBloc>().add(DeleteTask(task: task));
              },
            );
          })),
    );
  }
}
