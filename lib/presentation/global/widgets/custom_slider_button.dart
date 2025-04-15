import 'package:flutter/material.dart';

class CustomSliderButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onSlideComplete;
  final bool enabled;
  final Duration animationDuration;

  const CustomSliderButton({
    Key? key,
    required this.onSlideComplete,
    required this.width,
    this.height = 60.0,
    this.text = 'Submit',
    this.enabled = true,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _CustomSliderButtonState createState() => _CustomSliderButtonState();
}

class _CustomSliderButtonState extends State<CustomSliderButton> with SingleTickerProviderStateMixin {
  // Start at 5% progressed.
  double _sliderProgress = 0.08;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Maximum horizontal movement for the slider handle.
  double get _maxSliderPosition => widget.width - widget.height - 12;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Animate the slider back to the initial 5% position.
  void _animateSliderBack() {
    _animation = Tween<double>(begin: _sliderProgress, end: 0.08).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {
          _sliderProgress = _animation.value;
        });
      });
    _animationController.forward(from: 0.0);
  }

  // Build the background using a Row with two side-by-side containers.
  Widget _buildBackground({required double width, required double backgroundSplitX}) {
    final double _radius = widget.height / 2;
    // Clamp the left width so that it’s never greater than the available width.
    double leftWidth = backgroundSplitX.clamp(0, width - 10);
    double rightWidth = width - leftWidth;

    return SizedBox(
      width: width,
      child: Row(
        children: [
          SizedBox(
            width: leftWidth - 10,
            height: widget.height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_radius),
                  bottomLeft: Radius.circular(_radius),
                ),
                color: widget.enabled ? Theme.of(context).primaryColor : Colors.grey.shade200,
              ),
            ),
          ),
          SizedBox(
            width: rightWidth - 12,
            height: widget.height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_radius),
                  bottomRight: Radius.circular(_radius),
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double handleDiameter = widget.height;
    // The background is split at a point that is the slider's progress times the maximum movement plus half the handle's width.
    double backgroundSplitX = _sliderProgress * _maxSliderPosition + handleDiameter / 2;

    return Container(
      width: widget.width - 10,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(
          color: widget.enabled ? Theme.of(context).primaryColor : Colors.grey.shade200,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background built with two colored portions.
          _buildBackground(width: widget.width, backgroundSplitX: backgroundSplitX),
          // Center label.
          Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.enabled
                    ? _sliderProgress > 0.5
                        ? Colors.white70
                        : Theme.of(context).primaryColor
                    : Colors.grey.shade200,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          // Draggable circular handle.
          Positioned(
            left: _sliderProgress * _maxSliderPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (!widget.enabled) return;
                setState(() {
                  _sliderProgress += details.delta.dx / _maxSliderPosition;
                  _sliderProgress = _sliderProgress.clamp(0.0, 1.0);
                });
              },
              onHorizontalDragEnd: (details) {
                if (!widget.enabled) return;
                if (_sliderProgress >= 0.9) {
                  widget.onSlideComplete();
                } else {
                  _animateSliderBack();
                }
              },
              child: Container(
                width: handleDiameter,
                height: handleDiameter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: widget.enabled ? Theme.of(context).primaryColor : Colors.grey.shade200, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
