import 'package:flutter/material.dart';
import 'package:week_15_butterflies/info.dart';

class ButterFliesItem extends StatefulWidget {
  final String name;
  final String description;
  final String image;
  const ButterFliesItem(
      {required this.name,
      required this.description,
      required this.image,
      super.key});

  @override
  State<ButterFliesItem> createState() => _ButterFliesItemState();
}

class _ButterFliesItemState extends State<ButterFliesItem>
    with SingleTickerProviderStateMixin {
  bool showPicker = false;
  late AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _animationDropDown;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animationDropDown = Tween(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(widget.name),
              ],
            ),
            Container(
              width: 30,
              child: RotationTransition(
                turns: _animationDropDown,
                child: GestureDetector(
                  onTap: () {
                    showPicker = !showPicker;
                    if (showPicker) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  },
                  child: const Icon(Icons.expand_more),
                ),
              ),
            ),
          ],
        ),
        SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: SizedBox(
              height: 300,
              // width: MediaQuery.of(context).size.width / 3 * 2,
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(widget.image), fit: BoxFit.fill),
                    ),
                  ),
                  Text(widget.description),
                ],
              ),
            )),
      ],
    );
  }
}
