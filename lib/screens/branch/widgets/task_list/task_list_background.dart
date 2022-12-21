import 'package:flutter/material.dart';

import '../../branch_config.dart';

class TaskListBackground extends StatelessWidget {
  const TaskListBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: BranchConfig.taskListBackgroundPadding,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          MediaQuery.of(context).size.height ~/ BranchConfig.taskTileHeight + 1,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        height: BranchConfig.taskTileHeight +
            (BranchConfig.taskTileSeparation +
                    BranchConfig.taskTileDivisorHeight) /
                2,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.deepPurpleAccent.shade100,
              width: BranchConfig.taskTileDivisorHeight,
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: (BranchConfig.taskTileSeparation -
                BranchConfig.taskTileDivisorHeight) /
            2,
      ),
    );
  }
}
