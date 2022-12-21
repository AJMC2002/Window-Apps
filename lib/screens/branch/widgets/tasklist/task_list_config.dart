import 'package:flutter/material.dart';

abstract class TaskListConfig {
  static const taskTileHeight = 66.0;
  static const taskTileSeparation = 10.0;
  static const taskTileDivisorHeight = 3.0;
  static const _floatingActionButtonHeight = 56.0;
  static const taskListBackgroundPadding = EdgeInsets.only(
    top: 30.0,
    left: 40.0,
    right: 40.0,
    bottom: 2 * kFloatingActionButtonMargin + _floatingActionButtonHeight,
  );
  static const taskListPadding = EdgeInsets.only(
    top: 30.0,
    left: 30.0,
    right: 30.0,
    bottom: 2 * kFloatingActionButtonMargin + _floatingActionButtonHeight,
  );
}
