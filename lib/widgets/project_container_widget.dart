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
      constraints: const BoxConstraints(maxWidth: 400),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive width and height
          final width = max(
            widget.model.minWidth,
            widget.model.containerWidth ?? constraints.maxWidth,
          );
          
          final height = max(
            widget.model.minHeight,
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
                              ),
                            ),
                        ],
                      ),
                
                    // Subtitle
                    if (widget.model.subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.model.subtitle!,
                          style: TextStyle(
                            fontFamily: 'KohSantepheap',
                            fontSize: 14.0,
                            color: widget.model.subtitleColor,
                          ),
                        ),
                      ),
                
                    // Images (and text for single image)
                    if (widget.model.imageUrls != null && widget.model.imageUrls!.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: _buildImageGallery(),
                        ),
                      ),
                
                    // Custom text widget or regular text
                    if (widget.model.customTextWidget != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: widget.model.customTextWidget!,
                        ),
                      )
                    else if (widget.model.text != null && (widget.model.imageUrls == null || widget.model.imageUrls!.length != 1))
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.model.text!,
                          style: TextStyle(
                            fontFamily: 'KohSantepheap',
                            fontSize: 14.0,
                            color: widget.model.textColor,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                
                    // Yellow Button
                    if (widget.model.yellowButton != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
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
    
    if (widget.model.imageUrls!.length == 1) {
      // For a single image, create a column with the image and text
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height for image to prevent overflow
          double availableHeight = constraints.maxHeight;
          if (widget.model.text != null) {
            // Reserve space for text (approximate)
            availableHeight -= 50; // Reserve space for text + padding
          }
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with constrained height
              SizedBox(
                height: availableHeight > 0 ? availableHeight : constraints.maxHeight * 0.7,
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
          itemCount: widget.model.imageUrls!.length,
          itemBuilder: (context, index) {
            return _buildSingleImage(widget.model.imageUrls![index]);
          },
        );
      }
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return Container(
      width: widget.model.imageWidth ?? widget.model.imageSize,
      height: widget.model.imageHeight ?? widget.model.imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.model.imageRadius ?? 8.0),
        border: widget.model.imageBorderColor != null
            ? Border.all(
                color: widget.model.imageBorderColor!,
                width: widget.model.imageBorderWidth,
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


























