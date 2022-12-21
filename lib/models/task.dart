import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@Freezed()
class Task with _$Task {
  const factory Task({
    required final String id,
    required final String title,
    @Default(false) final bool isDone,
    @Default(false) final bool isFavorite,
  }) = _Task;
}
