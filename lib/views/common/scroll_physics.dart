import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  const CustomScrollPhysics({required this.itemDimension, ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(itemDimension: itemDimension, parent: buildParent(ancestor)!);
  }

  double _getPage(double pixels) {
    return pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {

    double page = _getPage(position.pixels);
    if (velocity < -tolerance.velocity) { page -= 0.5; }
    else if (velocity > tolerance.velocity) { page += 0.5; }
    return _getPixels(page.roundToDouble());

  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)){
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);

    if (target != position.pixels){
      return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}