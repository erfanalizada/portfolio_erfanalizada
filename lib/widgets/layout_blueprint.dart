import 'package:flutter/material.dart';

class LayoutBlueprint extends StatelessWidget {
  final Widget mainContainer;
  final List<Widget> leftContainers; // Containers that go below the main container
  final List<Widget> rightContainers; // Containers that go on the right side
  final List<Widget> centerContainers; // NEW: Containers that go in the center below both columns
  final double spacing;
  final double breakpointLarge;
  final double breakpointMedium;
  final double breakpointSmall;
  final double mainContainerWidth;
  final double rightContainerWidth;

  const LayoutBlueprint({
    super.key,
    required this.mainContainer,
    this.leftContainers = const [],
    required this.rightContainers,
    this.centerContainers = const [], // NEW: Default to empty list
    this.spacing = 24.0,
    this.breakpointLarge = 1200,
    this.breakpointMedium = 800,
    this.breakpointSmall = 600,
    this.mainContainerWidth = 750.0, // Default profile container width
    this.rightContainerWidth = 370.0, // Default project container width
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpointLarge) {
          return _buildLargeLayout();
        } else if (constraints.maxWidth >= breakpointMedium) {
          return _buildMediumLargeLayout();
        } else if (constraints.maxWidth >= breakpointSmall) {
          return _buildMediumLayout(constraints);
        } else {
          return _buildSmallLayout();
        }
      },
    );
  }

  Widget _buildLargeLayout() {
    return Column(
      children: [
        // Two-column layout
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left column with main container and leftContainers
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainContainer,
                  ...leftContainers.map((container) => 
                    Padding(
                      padding: EdgeInsets.only(top: spacing),
                      child: container,
                    )
                  ).toList(),
                ],
              ),
            ),
            
            SizedBox(width: spacing),
            
            // Right column with rightContainers
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _intersperse(
                  rightContainers,
                  SizedBox(height: spacing),
                ).toList(),
              ),
            ),
          ],
        ),
        
        // Center containers below both columns
        if (centerContainers.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: spacing),
              ...centerContainers.map((container) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: mainContainerWidth + rightContainerWidth + spacing - 10, // Subtract 10px to make it slightly narrower
                    ),
                    child: container,
                  ),
                )
              ).toList(),
            ],
          ),
      ],
    );
  }

  Widget _buildMediumLargeLayout() {
    return Column(
      children: [
        // Top section with main container and leftContainers
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainContainer,
            ...leftContainers.map((container) => 
              Padding(
                padding: EdgeInsets.only(top: spacing),
                child: container,
              )
            ).toList(),
          ],
        ),
        
        SizedBox(height: spacing),
        
        // Bottom section with rightContainers in a row with wrapping
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: rightContainers,
        ),
        
        // Center containers below both sections
        if (centerContainers.isNotEmpty)
          Column(
            children: [
              SizedBox(height: spacing),
              ...centerContainers.map((container) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: container,
                )
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMediumLayout(BoxConstraints constraints) {
    return Column(
      children: [
        // Main container
        mainContainer,
        
        // Left containers below main container
        ...leftContainers.map((container) => 
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: container,
          )
        ).toList(),
        
        SizedBox(height: spacing),
        
        // Right containers in a row with wrapping
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: rightContainers,
        ),
        
        // Center containers below both sections
        if (centerContainers.isNotEmpty)
          Column(
            children: [
              SizedBox(height: spacing),
              ...centerContainers.map((container) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: container,
                )
              ).toList(),
            ],
          ),
      ],
    );
  }

  Widget _buildSmallLayout() {
    return Column(
      children: [
        // Main container
        mainContainer,
        
        // Left containers below main container
        ...leftContainers.map((container) => 
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: container,
          )
        ).toList(),
        
        SizedBox(height: spacing),
        
        // Right containers stacked vertically
        ...rightContainers.map((container) => 
          Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: container,
          )
        ).toList(),
        
        // Center containers below both sections
        if (centerContainers.isNotEmpty)
          Column(
            children: [
              ...centerContainers.map((container) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: container,
                )
              ).toList(),
            ],
          ),
      ],
    );
  }

  // Helper method to intersperse items in a list
  List<Widget> _intersperse(List<Widget> list, Widget separator) {
    if (list.isEmpty) return [];
    if (list.length == 1) return [list.first];
    
    return list.fold<List<Widget>>(
      [],
      (previousValue, element) => previousValue.isEmpty
          ? [element]
          : [...previousValue, separator, element],
    );
  }
}










