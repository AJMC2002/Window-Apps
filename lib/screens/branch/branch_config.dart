import 'package:flutter/material.dart';

import '../../app/config.dart';

abstract class BranchConfig {
  static const taskListPadding = EdgeInsets.only(
    left: 30.0,
    top: 30.0,
    right: 30.0,
    bottom: 2 * kFloatingActionButtonMargin + Config.floatingActionButtonHeight,
  );
  static const _horizontalPaddingDiff = 15;
  static final taskListBackgroundPadding = taskListPadding.copyWith(
    left: taskListPadding.left + _horizontalPaddingDiff,
    right: taskListPadding.right + _horizontalPaddingDiff,
  );
  static const taskTileHeight = 66.0;
  static const taskTileSeparation = 10.0;
  static const taskTileDivisorHeight = 3.0;
}
