import 'package:uuid/uuid.dart';

abstract class Config {
  static const uuid = Uuid();
  static const maxTopicTitleLength = 40;
  static const maxTaskTitleLength = 40;
  static const floatingActionButtonHeight = 56.0;
}
