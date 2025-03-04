import 'package:flutter/material.dart';

class SwipeButton extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color buttonColor;
  final IconData startIcon;
  final IconData endIcon;
  final String text;
  final TextStyle textStyle;
  final double
      swipeThreshold; // Proportion of width required for a successful swipe
  final VoidCallback onSwipeComplete;

  const SwipeButton({
    super.key,
    this.width = 300,
    this.height = 60,
    this.backgroundColor = Colors.white,
    this.buttonColor = Colors.blue,
    this.startIcon = Icons.arrow_forward,
    this.endIcon = Icons.check,
    this.text = 'Swipe',
    this.textStyle = const TextStyle(fontSize: 18),
    this.swipeThreshold = 0.75, // Default threshold is 75%
    required this.onSwipeComplete,
  });

  @override
  _SwipeButtonState createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton>
    with TickerProviderStateMixin {
  late AnimationController _iconAnimationController;
  late Animation<double> _iconRotationAnimation;

  late AnimationController _fadeOutAnimationController;
  late Animation<double> _fadeOutAnimation;

  double _dragPosition = 0.0;
  bool _isSwiped = false;
  bool _isFadingOut = false;

  @override
  void initState() {
    super.initState();

    // Icon animation
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _iconRotationAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    ));

    // Fade-out animation
    _fadeOutAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeOutAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    _fadeOutAnimationController.dispose();
    super.dispose();
  }

  void _completeSwipe() {
    setState(() {
      _isSwiped = true;
    });

    widget.onSwipeComplete();

    // Trigger fade-out animation
    _fadeOutAnimationController.forward().then((_) {
      setState(() {
        _isFadingOut = true; // Mark the widget as removed
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFadingOut) return const SizedBox(); // Remove the widget entirely

    return FadeTransition(
      opacity: _fadeOutAnimation,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (_isSwiped) return; // Prevent dragging after swipe is complete

          setState(() {
            _dragPosition += details.delta.dx;
            _dragPosition =
                _dragPosition.clamp(0.0, widget.width - widget.height);
          });

          // Rotate the icon as the button moves
          _iconAnimationController.value =
              _dragPosition / (widget.width - widget.height);
        },
        onHorizontalDragEnd: (details) {
          if (_isSwiped) return;

          if (_dragPosition > widget.width * widget.swipeThreshold) {
            _completeSwipe();
          } else {
            setState(() {
              _dragPosition = 0.0; // Reset position if swipe is incomplete
            });
            _iconAnimationController.reverse(); // Reset icon rotation
          }
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background Container
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
              alignment: Alignment.center,
              child: Text(
                _isSwiped ? "Checked In" : widget.text,
                style: widget.textStyle,
              ),
            ),
            // Sliding Button
            Positioned(
              left: _dragPosition,
              child: Container(
                width: widget.height,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.buttonColor,
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _iconRotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _isSwiped
                          ? _iconRotationAnimation.value * 0
                          : _iconRotationAnimation.value * 3.14, // Half-turn
                      child: Icon(
                        _isSwiped ? widget.endIcon : widget.startIcon,
                        color: widget.backgroundColor,
                        size: widget.height * 0.5,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
