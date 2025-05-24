import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

class ProjectContainerWidget extends StatelessWidget {
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
  
  // Minimum sizes for responsiveness
  final double minWidth;
  final double minHeight;

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
    this.minWidth = 300.0,
    this.minHeight = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive width and height
        final width = max(
          minWidth,
          containerWidth ?? constraints.maxWidth,
        );
        
        final height = max(
          minHeight,
          containerHeight ?? constraints.maxHeight,
        );

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
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
                if (icon != null || title != null)
                  Row(
                    children: [
                      if (icon != null)
                        Icon(icon, size: 24.0, color: titleColor),
                      if (icon != null && title != null)
                        const SizedBox(width: 8.0),
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: titleColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                
                // Subtitle
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: 'KohSantepheap',
                        fontSize: 14.0,
                        color: subtitleColor,
                      ),
                    ),
                  ),
                
                // Images (and text for single image)
                if (imageUrls != null && imageUrls!.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: _buildImageGallery(),
                    ),
                  ),
                
                // Custom text widget or regular text
                if (customTextWidget != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: customTextWidget!,
                    ),
                  )
                else if (text != null && (imageUrls == null || imageUrls!.length != 1))
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      text!,
                      style: TextStyle(
                        fontFamily: 'KohSantepheap',
                        fontSize: 14.0,
                        color: textColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                
                // Yellow Button
                if (yellowButton != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: yellowButton!,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageGallery() {
    if (imageUrls == null || imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    if (imageUrls!.length == 1) {
      // For a single image, create a column with the image and text
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height for image to prevent overflow
          double availableHeight = constraints.maxHeight;
          if (text != null) {
            // Reserve space for text (approximate)
            availableHeight -= 50; // Reserve space for text + padding
          }
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with constrained height
              SizedBox(
                height: availableHeight > 0 ? availableHeight : constraints.maxHeight * 0.7,
                child: _buildSingleImage(imageUrls!.first),
              ),
              if (text != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text!,
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      fontSize: 14.0,
                      color: textColor,
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
          itemCount: imageUrls!.length,
          itemBuilder: (context, index) {
            return _buildSingleImage(imageUrls![index]);
          },
        );
      }
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return Container(
      width: imageWidth ?? imageSize,
      height: imageHeight ?? imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(imageRadius ?? 8.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover, // Changed back to cover for original appearance
        ),
      ),
    );
  }
}














