import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/theme/theme_colors.dart';

class RecordButton extends StatefulWidget {
  final void Function()? onTapDown;
  final void Function()? onTapUp;
  final void Function()? onTap;
  final Widget? icon;

  const RecordButton({
    Key? key,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  double _buttonSize = 60.0;

  void onTapDown() {
    setState(() {
      _buttonSize = 90.0;
    });
  }

  void onTapUp() {
    setState(() {
      _buttonSize = 70.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: kIsWeb ? null : (_) => onTapDown(),
        onTapUp: kIsWeb ? null : (_) => onTapUp(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _buttonSize,
          height: _buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemColors.primaryColor,
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}
