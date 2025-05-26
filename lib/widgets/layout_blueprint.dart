import 'package:flutter/material.dart';

class LayoutBlueprint extends StatelessWidget {
  final Widget mainContainer;
  final List<Widget> leftContainers; // Containers that go below the main container
  final List<Widget> rightContainers; // Containers that go on the right side
  final double spacing;
  final double breakpointLarge;
  final double breakpointMedium;
  final double breakpointSmall;

  const LayoutBlueprint({
    super.key,
    required this.mainContainer,
    this.leftContainers = const [],
    required this.rightContainers,
    this.spacing = 24.0,
    this.breakpointLarge = 1200,
    this.breakpointMedium = 800,
    this.breakpointSmall = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > breakpointLarge) {
          // Large layout: Main container and leftContainers on left, rightContainers stacked on right
          return _buildLargeLayout();
        } else if (constraints.maxWidth > breakpointMedium) {
          // Medium-large layout: Main container and leftContainers on top, rightContainers in row below
          return _buildMediumLargeLayout();
        } else if (constraints.maxWidth > breakpointSmall) {
          // Medium layout: All containers stacked but in columns
          return _buildMediumLayout(constraints);
        } else {
          // Small layout: All containers stacked vertically
          return _buildSmallLayout();
        }
      },
    );
  }

  Widget _buildLargeLayout() {
    return Row(
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
      ],
    );
  }

  Widget _buildSmallLayout() {
    List<Widget> allWidgets = [mainContainer];
    
    // Add left containers
    for (var container in leftContainers) {
      allWidgets.add(SizedBox(height: spacing));
      allWidgets.add(Center(child: container));
    }
    
    // Add right containers
    for (var container in rightContainers) {
      allWidgets.add(SizedBox(height: spacing));
      allWidgets.add(Center(child: container));
    }
    
    return Column(children: allWidgets);
  }

  // Helper method to insert spacing between widgets
  List<Widget> _intersperse(List<Widget> list, Widget separator) {
    List<Widget> result = [];
    
    for (int i = 0; i < list.length; i++) {
      result.add(list[i]);
      if (i < list.length - 1) {
        result.add(separator);
      }
    }
    
    return result;
  }
}


