import 'package:flutter/material.dart';

abstract class TextFormatterInterface {
  /// Creates a bullet point list from a list of strings
  Widget buildBulletPointList(
    List<String> items, {
    TextStyle? textStyle,
    double bulletSpacing = 8.0,
    double itemSpacing = 4.0,
    String bulletCharacter = '•',
  });
  
  /// Creates a formatted text with a title and bullet points
  Widget buildTitleWithBulletPoints(
    String? title,
    List<String> bulletPoints, {
    TextStyle? titleStyle,
    TextStyle? bulletStyle,
    double titleSpacing = 12.0,
    double bulletSpacing = 8.0,
    double itemSpacing = 4.0,
    String bulletCharacter = '•',
  });
}