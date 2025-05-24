import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

class ProjectContainerWidget extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final double? containerWidth;
  final double? containerHeight;
  final List<String>? imageUrls;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageRadius;
  final double? imageSize;
  final String? text;
  final Widget? customTextWidget;
  final String? textId;
  final Color textColor;
  final YellowButton? yellowButton;
  final Color containerColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color shadowColor;
  
  // Minimum sizes for responsiveness
  final double minWidth;
  final double minHeight;

  // New properties for border customization
  final Color? containerBorderColor;
  final double containerBorderWidth;
  final Color? imageBorderColor;
  final double imageBorderWidth;

  // New properties for hover effect
  final Color? hoverGlowColor;
  final double hoverGlowRadius;
  final bool enableHoverEffect;

  const ProjectContainerWidget({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.containerWidth,
    this.containerHeight,
    this.imageUrls,
    this.imageSize,
    this.imageWidth,
    this.imageHeight,
    this.imageRadius,
    this.text,
    this.customTextWidget,
    this.textId,
    this.textColor = Colors.black54,
    this.yellowButton,
    this.containerColor = Colors.white,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black87,
    this.shadowColor = Colors.black,
    this.minWidth = 300.0,
    this.minHeight = 200.0,
    this.containerBorderColor,
    this.containerBorderWidth = 1.0,
    this.imageBorderColor,
    this.imageBorderWidth = 1.0,
    this.hoverGlowColor,
    this.hoverGlowRadius = 12.0,
    this.enableHoverEffect = true,
  });

  @override
  State<ProjectContainerWidget> createState() => _ProjectContainerWidgetState();
}

class _ProjectContainerWidgetState extends State<ProjectContainerWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive width and height
        final width = max(
          widget.minWidth,
          widget.containerWidth ?? constraints.maxWidth,
        );
        
        final height = max(
          widget.minHeight,
          widget.containerHeight ?? constraints.maxHeight,
        );

        return MouseRegion(
          onEnter: widget.enableHoverEffect ? (_) => setState(() => _isHovering = true) : null,
          onExit: widget.enableHoverEffect ? (_) => setState(() => _isHovering = false) : null,
          cursor: widget.enableHoverEffect ? SystemMouseCursors.click : MouseCursor.defer,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: widget.containerColor,
              borderRadius: BorderRadius.circular(12.0),
              border: widget.containerBorderColor != null
                  ? Border.all(
                      color: widget.containerBorderColor!,
                      width: widget.containerBorderWidth,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: _isHovering && widget.hoverGlowColor != null
                      ? widget.hoverGlowColor!.withOpacity(0.3)
                      : widget.shadowColor.withOpacity(0.1),
                  blurRadius: _isHovering && widget.hoverGlowColor != null
                      ? widget.hoverGlowRadius
                      : 8.0,
                  spreadRadius: _isHovering && widget.hoverGlowColor != null ? 2.0 : 0.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and title row
                  if (widget.icon != null || widget.title != null)
                    Row(
                      children: [
                        if (widget.icon != null)
                          Icon(widget.icon, size: 24.0, color: widget.titleColor),
                        if (widget.icon != null && widget.title != null)
                          const SizedBox(width: 8.0),
                        if (widget.title != null)
                          Expanded(
                            child: Text(
                              widget.title!,
                              style: TextStyle(
                                fontFamily: 'KohSantepheap',
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                                color: widget.titleColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                
                  // Subtitle
                  if (widget.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.subtitle!,
                        style: TextStyle(
                          fontFamily: 'KohSantepheap',
                          fontSize: 14.0,
                          color: widget.subtitleColor,
                        ),
                      ),
                    ),
                
                  // Images (and text for single image)
                  if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: _buildImageGallery(),
                      ),
                    ),
                
                  // Custom text widget or regular text
                  if (widget.customTextWidget != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: widget.customTextWidget!,
                      ),
                    )
                  else if (widget.text != null && (widget.imageUrls == null || widget.imageUrls!.length != 1))
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.text!,
                        style: TextStyle(
                          fontFamily: 'KohSantepheap',
                          fontSize: 14.0,
                          color: widget.textColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                  // Yellow Button
                  if (widget.yellowButton != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: widget.yellowButton!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageGallery() {
    if (widget.imageUrls == null || widget.imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    if (widget.imageUrls!.length == 1) {
      // For a single image, create a column with the image and text
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height for image to prevent overflow
          double availableHeight = constraints.maxHeight;
          if (widget.text != null) {
            // Reserve space for text (approximate)
            availableHeight -= 50; // Reserve space for text + padding
          }
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with constrained height
              SizedBox(
                height: availableHeight > 0 ? availableHeight : constraints.maxHeight * 0.7,
                child: _buildSingleImage(widget.imageUrls!.first),
              ),
              if (widget.text != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.text!,
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      fontSize: 14.0,
                      color: widget.textColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          );
        }
      );
    }
    
    // For multiple images, use a grid with fixed height
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0, // Square items
          ),
          itemCount: widget.imageUrls!.length,
          itemBuilder: (context, index) {
            return _buildSingleImage(widget.imageUrls![index]);
          },
        );
      }
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return Container(
      width: widget.imageWidth ?? widget.imageSize,
      height: widget.imageHeight ?? widget.imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.imageRadius ?? 8.0),
        border: widget.imageBorderColor != null
            ? Border.all(
                color: widget.imageBorderColor!,
                width: widget.imageBorderWidth,
              )
            : null,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}





















