import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/blocs/bloc_imports.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    TaskState state = this.state;

    emit(TaskState(
      allTasks: List.from(state.allTasks)..add(event.task),
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    task.isCompleted == false ? allTasks.insert(index, task.copyWith(isCompleted: true)) : allTasks.insert(index, task.copyWith(isCompleted: false));

    emit(TaskState(allTasks: allTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    emit(TaskState(allTasks: allTasks));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
