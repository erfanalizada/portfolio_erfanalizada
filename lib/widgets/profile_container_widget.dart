import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';
import 'package:portfolio_erfanalizada/interfaces/text_formatter_interface.dart';
import 'package:portfolio_erfanalizada/managers/text_formatter_manager.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

class ProfileContainerWidget extends StatefulWidget {
  final ProjectContainerModel model;

  const ProfileContainerWidget({
    super.key,
    required this.model,
  });

  @override
  State<ProfileContainerWidget> createState() => _ProfileContainerWidgetState();
}

class _ProfileContainerWidgetState extends State<ProfileContainerWidget> {
  bool _isHovering = false;
  final TextFormatterInterface _textFormatter = TextFormatterManager();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = true) : null,
      onExit: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = false) : null,
      cursor: widget.model.enableHoverEffect ? SystemMouseCursors.click : MouseCursor.defer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive dimensions
          final containerWidth = widget.model.containerWidth ?? constraints.maxWidth;
          final containerHeight = widget.model.containerHeight ?? constraints.maxHeight;
          
          // Calculate profile picture width - responsive but with minimum size
          final profilePicWidth = constraints.maxWidth < 600 ? 
              max(constraints.maxWidth * 0.3, 120.0) : 250.0;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              color: widget.model.containerColor,
              borderRadius: BorderRadius.circular(12.0),
              border: widget.model.containerBorderColor != null
                  ? Border.all(
                      color: widget.model.containerBorderColor!,
                      width: widget.model.containerBorderWidth,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: widget.model.shadowColor.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
                if (_isHovering && widget.model.hoverGlowColor != null)
                  BoxShadow(
                    color: widget.model.hoverGlowColor!.withOpacity(0.3),
                    blurRadius: widget.model.hoverGlowRadius,
                    spreadRadius: 1.0,
                  ),
              ],
            ),
            child: Row(
              children: [
                // Left container with profile picture background - now responsive
                Container(
                  width: profilePicWidth,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/pictures/profile_pic.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Right container with three rows
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First row with greeting and flag
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth < 500 ? 20.0 : 24.0,
                                      fontFamily: 'KohSantepheap',
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Hi, I\'m\n',
                                        style: TextStyle(
                                          color: widget.model.titleColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Erfan Alizada',
                                        style: TextStyle(
                                          color: widget.model.titleColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Netherlands flag
                              Container(
                                width: 45,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: widget.model.imageBorderColor != null 
                                    ? Border.all(color: widget.model.imageBorderColor!, width: 1) 
                                    : null,
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/pictures/nl_pic.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Yellow line below first row
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: widget.model.titleColor,
                          margin: const EdgeInsets.only(bottom: 8.0),
                        ),
                        
                        // Second row - now with flexible content
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Subtitle with responsive font size
                                  Text(
                                    'Software Engineer specializing in Mobile & Web App Development and API\'s',
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth < 500 ? 14.0 : 16.0,
                                      color: widget.model.subtitleColor,
                                      fontFamily: 'KohSantepheap',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  
                                  // Bullet points title and list
                                  _textFormatter.buildTitleWithBulletPoints(
                                    'Programming languages mastering:',
                                    [
                                      'Flutter (Mobile App development)',
                                      'React (Web App development)',
                                      'Java for setting API',
                                    ],
                                    titleStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: widget.model.textColor,
                                      fontFamily: 'KohSantepheap',
                                    ),
                                    bulletStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: widget.model.textColor,
                                      fontFamily: 'KohSantepheap',
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 12.0),
                                  
                                  // Additional title
                                  Text(
                                    'This portfolio is built with Flutter!',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: widget.model.titleColor,
                                      fontFamily: 'KohSantepheap',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        // Third row with responsive spacing
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: constraints.maxWidth < 450 ?
                            // Stack vertically on very small screens
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLanguageIcons(),
                                const SizedBox(height: 12.0),
                                YellowButton(
                                  text: 'Read More',
                                  icon: Icons.arrow_forward_ios,
                                  onPressed: () {
                                    // Add your contact action here
                                  },
                                  width: 130,
                                  height: 40,
                                ),
                              ],
                            ) :
                            // Normal layout for larger screens
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildLanguageIcons(),
                                YellowButton(
                                  text: 'Read More',
                                  icon: Icons.arrow_forward_ios,
                                  onPressed: () {
                                    // Add your contact action here
                                  },
                                  width: 130,
                                  height: 40,
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  // Helper method to create bullet points
  Widget _buildBulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14.0,
              color: textColor,
              fontFamily: 'KohSantepheap',
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
                fontFamily: 'KohSantepheap',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create language icons row
  Widget _buildLanguageIcons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive icon sizes
        final iconSize = constraints.maxWidth < 150 ? 30.0 : 40.0;
        final spacing = constraints.maxWidth < 150 ? 8.0 : 15.0;
        
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Flutter image
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pictures/flutter_pic.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: spacing),
            // React image
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pictures/react_pic.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: spacing),
            // Java image
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pictures/java_pic.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}




















