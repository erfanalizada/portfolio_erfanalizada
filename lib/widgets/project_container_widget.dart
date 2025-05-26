import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

class ProjectContainerWidget extends StatefulWidget {
  final ProjectContainerModel model;

  const ProjectContainerWidget({
    super.key,
    required this.model,
  });

  @override
  State<ProjectContainerWidget> createState() => _ProjectContainerWidgetState();
}

class _ProjectContainerWidgetState extends State<ProjectContainerWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 370), // Increased from 340 by 30px
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive width and height
          // Apply 15% width reduction to the container, but add 30px
          final width = max(
            widget.model.minWidth * 0.85 + 30, // Apply 15% reduction to minimum width, then add 30px
            (widget.model.containerWidth != null) 
                ? widget.model.containerWidth! * 0.85 + 30 // Apply 15% reduction to specified width, then add 30px
                : constraints.maxWidth,
          );
          
          // Ensure minimum height accommodates the smaller image section
          // Increase the minimum height to avoid overflow
          const minHeightForImage = 340.0; // Increased from 315.0 to avoid overflow
          
          final height = max(
            max(widget.model.minHeight, minHeightForImage),
            widget.model.containerHeight ?? constraints.maxHeight,
          );

          // Determine background color based on hover state
          final backgroundColor = widget.model.containerColor;

          return MouseRegion(
            onEnter: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = true) : null,
            onExit: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = false) : null,
            cursor: widget.model.enableHoverEffect ? SystemMouseCursors.click : MouseCursor.defer,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor,
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and title row
                    if (widget.model.icon != null || widget.model.title != null)
                      Row(
                        children: [
                          if (widget.model.icon != null)
                            Icon(widget.model.icon, size: 24.0, color: widget.model.titleColor),
                          if (widget.model.icon != null && widget.model.title != null)
                            const SizedBox(width: 8.0),
                          if (widget.model.title != null)
                            Expanded(
                              child: Text(
                                widget.model.title!,
                                style: TextStyle(
                                  fontFamily: 'KohSantepheap',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                  color: widget.model.titleColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1, // Limit to 1 line
                              ),
                            ),
                        ],
                      ),
                
                    // Subtitle
                    if (widget.model.subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Reduced from 8.0
                        child: Text(
                          widget.model.subtitle!,
                          style: TextStyle(
                            fontFamily: 'KohSantepheap',
                            fontSize: 14.0,
                            color: widget.model.subtitleColor,
                          ),
                          maxLines: 1, // Limit to 1 line
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                
                    // Images (and text for single image)
                    if (widget.model.imageUrls != null && widget.model.imageUrls!.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0), // Reduced from 12.0
                          child: _buildImageGallery(),
                        ),
                      ),
                
                    // Custom text widget or regular text
                    if (widget.model.customTextWidget != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Reduced from 8.0
                        child: SizedBox(
                          width: double.infinity,
                          child: widget.model.customTextWidget!,
                        ),
                      )
                    else if (widget.model.text != null && (widget.model.imageUrls == null || widget.model.imageUrls!.length != 1))
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Reduced from 8.0
                        child: Text(
                          widget.model.text!,
                          style: TextStyle(
                            fontFamily: 'KohSantepheap',
                            fontSize: 14.0,
                            color: widget.model.textColor,
                          ),
                          maxLines: 2, // Limit to 2 lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                
                    // Yellow Button
                    if (widget.model.yellowButton != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0), // Reduced from 16.0
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: widget.model.yellowButton!,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageGallery() {
    if (widget.model.imageUrls == null || widget.model.imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    // Define a standard image section height for all containers
    const standardImageSectionHeight = 165.0;
    
    if (widget.model.imageUrls!.length == 1) {
      // For a single image, create a column with the image and text
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height for image after accounting for text
          final textHeight = widget.model.text != null ? 40.0 : 0.0; // Estimated text height
          final availableImageHeight = min(standardImageSectionHeight, constraints.maxHeight - textHeight);
          
          // Calculate 85% of the available width (15% smaller) + 30px
          final imageWidth = constraints.maxWidth * 0.85 + 30;
          
          return Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space needed
            children: [
              // Center the image with adjusted width and height
              SizedBox(
                height: availableImageHeight,
                width: imageWidth,
                child: _buildSingleImage(widget.model.imageUrls!.first),
              ),
              if (widget.model.text != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.model.text!,
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      fontSize: 14.0,
                      color: widget.model.textColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Limit to 2 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          );
        }
      );
    }
    
    // For multiple images, use a grid with fixed height and adjusted width
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available height
        final availableHeight = min(standardImageSectionHeight, constraints.maxHeight);
        
        // Calculate 85% of the available width (15% smaller) + 30px
        final gridWidth = constraints.maxWidth * 0.85 + 30;
        
        return Center(
          child: SizedBox(
            height: availableHeight,
            width: gridWidth,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0, // Square items
              ),
              itemCount: widget.model.imageUrls!.length,
              itemBuilder: (context, index) {
                return _buildSingleImage(widget.model.imageUrls![index]);
              },
            ),
          ),
        );
      }
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    // Calculate the width - either use the model's width minus 15px or default to container width minus 15px
    final adjustedWidth = (widget.model.imageWidth != null) 
        ? widget.model.imageWidth! - 15.0 
        : double.infinity;
        
    return Container(
      width: adjustedWidth,
      height: widget.model.imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.model.imageRadius ?? 8.0),
        border: widget.model.imageBorderColor != null
            ? Border.all(
                color: widget.model.imageBorderColor!,
                width: widget.model.imageBorderWidth,
              )
            : null,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
















