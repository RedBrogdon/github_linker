import 'package:flutter/material.dart';

extension BoldableTextStyle on TextStyle {
  TextStyle makeBold() {
    return copyWith(fontWeight: FontWeight.bold);
  }
}
