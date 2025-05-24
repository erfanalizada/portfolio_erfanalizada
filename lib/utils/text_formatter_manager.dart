import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/utils/text_formatter_interface.dart';

class TextFormatterManager implements TextFormatterInterface {
  // Singleton pattern
  static final TextFormatterManager _instance = TextFormatterManager._internal();
  
  factory TextFormatterManager() {
    return _instance;
  }
  
  TextFormatterManager._internal();
  
  @override
  Widget buildBulletPointList(
    List<String> items, {
    TextStyle? textStyle,
    double bulletSpacing = 8.0,
    double itemSpacing = 4.0,
    String bulletCharacter = '•',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: itemSpacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bulletCharacter,
                style: textStyle,
              ),
              SizedBox(width: bulletSpacing),
              Expanded(
                child: Text(
                  item,
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  @override
  Widget buildTitleWithBulletPoints(
    String title,
    List<String> bulletPoints, {
    TextStyle? titleStyle,
    TextStyle? bulletStyle,
    double titleSpacing = 12.0,
    double bulletSpacing = 8.0,
    double itemSpacing = 4.0,
    String bulletCharacter = '•',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        SizedBox(height: titleSpacing),
        buildBulletPointList(
          bulletPoints,
          textStyle: bulletStyle,
          bulletSpacing: bulletSpacing,
          itemSpacing: itemSpacing,
          bulletCharacter: bulletCharacter,
        ),
      ],
    );
  }
}