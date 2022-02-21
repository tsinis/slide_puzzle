import 'package:flutter/material.dart';

class AnimatedWidgetKey extends ValueKey<MapEntry<int, bool>> {
  static const _backgroundMultiply = 100;

  int get backgroundIndex => value.key ~/ _backgroundMultiply;
  bool get isDone => value.value;

  AnimatedWidgetKey._(int index, {bool isDone = false})
      : super(MapEntry(index, isDone));

  AnimatedWidgetKey.background(int index, {bool isDone = false})
      : super(MapEntry(index * _backgroundMultiply, isDone));

  const AnimatedWidgetKey.wheel() : super(const MapEntry(0, false));
  const AnimatedWidgetKey.skiTow() : super(const MapEntry(1, false));
  const AnimatedWidgetKey.gate() : super(const MapEntry(2, false));
  const AnimatedWidgetKey.telescope() : super(const MapEntry(3, false));
  const AnimatedWidgetKey.windmill() : super(const MapEntry(4, false));
  const AnimatedWidgetKey.smoke() : super(const MapEntry(5, false));
  const AnimatedWidgetKey.crane() : super(const MapEntry(6, false));
  const AnimatedWidgetKey.plane() : super(const MapEntry(7, false));
  const AnimatedWidgetKey.submarine() : super(const MapEntry(8, false));
  const AnimatedWidgetKey.bridge() : super(const MapEntry(9, false));
  const AnimatedWidgetKey.train() : super(const MapEntry(10, false));
  const AnimatedWidgetKey.rainbow() : super(const MapEntry(11, false));
  const AnimatedWidgetKey.whale() : super(const MapEntry(12, false));
  const AnimatedWidgetKey.lighthouse() : super(const MapEntry(13, false));
  const AnimatedWidgetKey.balloon() : super(const MapEntry(14, false));

  AnimatedWidgetKey copyWith({bool? isDone, int? index}) => AnimatedWidgetKey._(
        index ?? value.key,
        isDone: isDone ?? this.isDone,
      );
}
