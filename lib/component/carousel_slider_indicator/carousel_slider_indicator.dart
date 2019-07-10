import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderIndicator extends StatefulWidget {
  final items;
  final autoPlay;
  final onPageChanged;
  final height;
  final viewportFraction;

  const CarouselSliderIndicator(
      {Key key,
      this.items,
      this.autoPlay,
      this.onPageChanged,
      this.height,
      this.viewportFraction})
      : super(key: key);

  @override
  _CarouselSliderIndicatorState createState() =>
      _CarouselSliderIndicatorState();
}

class _CarouselSliderIndicatorState extends State<CarouselSliderIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: widget.items,
        autoPlay: widget.autoPlay ?? false,
        height: widget.height ?? 200,
        viewportFraction: widget.viewportFraction ?? 1.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
          widget.onPageChanged(index);
        },
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(widget.items.length, (i) => i).map((index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _current == index ? Colors.red[400] : Colors.white),
                );
              }).toList(),
            ),
          ))
    ]);
  }
}
