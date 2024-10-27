import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';

enum BrandButtonType { matte, accent }

class BrandButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final AssetImage? image;
  final HeroIcon? icon;
  final BrandButtonType type;
  final bool disabled;
  final bool loading;

  const BrandButton({
    super.key,
    this.label = "",
    this.image,
    this.icon,
    this.disabled = false,
    this.loading = false,
    this.type = BrandButtonType.matte,
    required this.onTap,
  });

  @override
  State<BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<BrandButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          HapticFeedback.selectionClick();
          setState(() {
            _isPressed = true;
          });
        },
        onPanEnd: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTap: () {
          if (widget.disabled || widget.loading) return;
          widget.onTap();
        },
        child: AnimatedOpacity(
            opacity:
                _isPressed || widget.disabled || widget.loading ? 0.65 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: Container(
              decoration: BoxDecoration(
                color: BrandButtonType.matte == widget.type
                    ? const Color.fromARGB(255, 21, 21, 21)
                    : const Color.fromARGB(255, 15, 15, 15),
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.image != null)
                            Image(image: widget.image!, width: 20, height: 20),
                          if (widget.icon != null) widget.icon!,
                          if ((widget.image != null || widget.icon != null) &&
                              widget.label != "")
                            const SizedBox(width: 5),
                          Text(
                            widget.label,
                            style: TextStyle(
                                color: BrandButtonType.accent == widget.type
                                    ? const Color.fromARGB(255, 177, 177, 177)
                                    : Colors.white.withOpacity(0.50)),
                          )
                        ],
                      ),
                      if (widget.loading)
                        Positioned(
                          left: 5,
                          child: CupertinoActivityIndicator(
                            animating: widget.loading,
                            radius: 10,
                          ),
                        )
                    ],
                  )),
            )));
  }
}
