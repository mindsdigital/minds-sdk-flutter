import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../helpers/theme/asset_paths.dart';
import '../../helpers/theme/design_system_constants.dart';
import '../../helpers/theme/theme_colors.dart';

class PressAndHoldButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onReleased;
  final bool isRecording;
  final Color? buttonColor;

  const PressAndHoldButton({
    super.key,
    required this.onPressed,
    required this.onReleased,
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

  void _onPressed() {
    setState(() {
      _isButtonPressed = true;
    });
    _startAnimation();
    widget.onPressed();
  }

  void _onReleased() {
    setState(() {
      _isButtonPressed = false;
    });
    _stopAnimation();
    widget.onReleased();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return GestureDetector(
        onTapDown: (_) => _onPressed(),
        onTapUp: (_) => _onReleased(),
        onTapCancel: () => _onReleased(),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _isButtonPressed ? 1.15 : 1.0,
              child: child,
            );
          },
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: widget.buttonColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.isRecording ? Icons.send : Icons.mic,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _onPressed,
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
