import 'package:freezed_annotation/freezed_annotation.dart';

part 'taskstep.freezed.dart';

@Freezed()
class TaskStep with _$TaskStep {
  const factory TaskStep({
    required final String id,
    required final String name,
    @Default(false) final bool isDone,
  }) = _TaskStep;
}
