import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasky/models/taskstep.dart';

part 'task.freezed.dart';

@Freezed()
class Task with _$Task {
  const factory Task({
    required final String id,
    required final String title,
    required final DateTime datetime,
    @Default(false) final bool isDone,
    @Default(false) final bool isFavorite,
    @Default([]) final List<Step> steps,
  }) = _Task;
}
