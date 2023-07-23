import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../helpers/theme/asset_paths.dart';
import '../../helpers/theme/design_system_constants.dart';
import '../../helpers/theme/theme_colors.dart';

class PressAndHoldButton extends StatefulWidget {
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;
  final VoidCallback onTap;
  final bool isRecording;
  final Color? buttonColor;

  const PressAndHoldButton({
    super.key,
    required this.onLongPressStart,
    required this.onLongPressEnd,
    required this.onTap,
    this.isRecording = false,
    this.buttonColor,
  });

  @override
  _PressAndHoldButtonState createState() => _PressAndHoldButtonState();
}

class _PressAndHoldButtonState extends State<PressAndHoldButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward();
  }

  void _stopAnimation() {
    _animationController.reverse();
  }

  void _onLongPressStart() {
    setState(() {
      _isButtonPressed = true;
    });
    _startAnimation();
    widget.onLongPressStart();
  }

  void _onLongPressEnd() {
    setState(() {
      _isButtonPressed = false;
    });
    _stopAnimation();
    widget.onLongPressEnd();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return GestureDetector(
        onTap: widget.onTap,
        onLongPressStart: (_) => _onLongPressStart(),
        onLongPressEnd: (_) => _onLongPressEnd(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: _isButtonPressed ? 75 : 60,
          height: _isButtonPressed ? 75 : 60,
          decoration: BoxDecoration(
            color: widget.buttonColor ?? ThemeColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              widget.isRecording ? Icons.send : Icons.mic,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.isRecording
              ? const Icon(Icons.send)
              : Image.asset(
                  AssetPaths.mic,
                  package: DesignSystemConstants.packageName,
                  width: 28,
                  height: 28,
                ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
          backgroundColor: widget.buttonColor ?? ThemeColors.primaryColor,
        ),
      );
    }
  }
}
