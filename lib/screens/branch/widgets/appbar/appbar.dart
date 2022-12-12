import 'package:flutter/material.dart';

import 'popupmenu.dart';

class BranchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BranchAppBar({
    super.key,
    required this.requireNotDone,
    required this.switchRequireNotDone,
    required this.requireFavorite,
    required this.switchRequireFavorite,
    required this.removeDoneTasks,
    required this.topic,
    required this.editTopic,
  });

  final bool requireNotDone;
  final VoidCallback switchRequireNotDone;
  final bool requireFavorite;
  final VoidCallback switchRequireFavorite;
  final VoidCallback removeDoneTasks;
  final String topic;
  final ValueSetter<String> editTopic;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<BranchAppBar> createState() => _BranchAppBarState();
}

class _BranchAppBarState extends State<BranchAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.topic,
        style: const TextStyle(fontSize: 30),
      ),
      actions: <Widget>[
        BranchPopUpMenu(
          requireNotDone: widget.requireNotDone,
          switchRequireNotDone: widget.switchRequireNotDone,
          requireFavorite: widget.requireFavorite,
          switchRequireFavorite: widget.switchRequireFavorite,
          removeDoneTasks: widget.removeDoneTasks,
          topic: widget.topic,
          editTopic: widget.editTopic,
        ),
      ],
    );
  }
}
