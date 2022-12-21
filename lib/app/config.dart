import 'package:uuid/uuid.dart';

abstract class Config {
  static const uuid = Uuid();
  static const maxTopicNameLength = 40;
  static const maxTaskNameLength = 40;
}
