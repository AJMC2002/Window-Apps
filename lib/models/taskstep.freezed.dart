// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taskstep.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskStep {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskStepCopyWith<TaskStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStepCopyWith<$Res> {
  factory $TaskStepCopyWith(TaskStep value, $Res Function(TaskStep) then) =
      _$TaskStepCopyWithImpl<$Res, TaskStep>;
  @useResult
  $Res call({String id, String name, bool isDone});
}

/// @nodoc
class _$TaskStepCopyWithImpl<$Res, $Val extends TaskStep>
    implements $TaskStepCopyWith<$Res> {
  _$TaskStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskStepCopyWith<$Res> implements $TaskStepCopyWith<$Res> {
  factory _$$_TaskStepCopyWith(
          _$_TaskStep value, $Res Function(_$_TaskStep) then) =
      __$$_TaskStepCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, bool isDone});
}

/// @nodoc
class __$$_TaskStepCopyWithImpl<$Res>
    extends _$TaskStepCopyWithImpl<$Res, _$_TaskStep>
    implements _$$_TaskStepCopyWith<$Res> {
  __$$_TaskStepCopyWithImpl(
      _$_TaskStep _value, $Res Function(_$_TaskStep) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDone = null,
  }) {
    return _then(_$_TaskStep(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TaskStep implements _TaskStep {
  const _$_TaskStep(
      {required this.id, required this.name, this.isDone = false});

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isDone;

  @override
  String toString() {
    return 'TaskStep(id: $id, name: $name, isDone: $isDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskStep &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskStepCopyWith<_$_TaskStep> get copyWith =>
      __$$_TaskStepCopyWithImpl<_$_TaskStep>(this, _$identity);
}

abstract class _TaskStep implements TaskStep {
  const factory _TaskStep(
      {required final String id,
      required final String name,
      final bool isDone}) = _$_TaskStep;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$_TaskStepCopyWith<_$_TaskStep> get copyWith =>
      throw _privateConstructorUsedError;
}
