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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.model.containerWidth,
        height: widget.model.containerHeight,
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
            // Left container with profile picture background
            Container(
              width: 250,
              height: double.infinity, // Full height of parent
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pictures/profile_pic.png'),
                  fit: BoxFit.cover, // Cover the entire container
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
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 24.0,
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
                          // Netherlands flag
                          Container(
                            width: 45, // 5px bigger
                            height: 35, // 5px bigger
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
                      color:widget.model.titleColor,
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ),
                    
                    // Second row
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Subtitle
                            Text(
                              'Software Engineer specializing in Mobile & Web App Development and API\'s',
                              style: TextStyle(
                                fontSize: 16.0,
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
                    
                    // Third row
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Language images
                          Row(
                            children: [
                              // Flutter image
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/pictures/flutter_pic.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              // React image
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/pictures/react_pic.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Java image
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/pictures/java_pic.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Yellow button
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
}

















