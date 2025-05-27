import 'package:flutter/material.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

class TallProjectContainer extends StatefulWidget {
  final ProjectContainerModel model;

  const TallProjectContainer({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<TallProjectContainer> createState() => _TallProjectContainerState();
}

class _TallProjectContainerState extends State<TallProjectContainer> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = true) : null,
      onExit: widget.model.enableHoverEffect ? (_) => setState(() => _isHovering = false) : null,
      cursor: widget.model.enableHoverEffect ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 200, // Fixed height to avoid layout issues
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Screenshot and title
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
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
                              maxLines: 1,
                            ),
                          ),
                      ],
                    ),
                    
                    // Subtitle
                    if (widget.model.subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          widget.model.subtitle!,
                          style: TextStyle(
                            fontFamily: 'KohSantepheap',
                            fontSize: 14.0,
                            color: widget.model.subtitleColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    
                    const SizedBox(height: 8.0),
                    
                    // Image
                    if (widget.model.imageUrls != null && widget.model.imageUrls!.isNotEmpty)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.model.imageRadius ?? 8.0),
                            border: widget.model.imageBorderColor != null
                                ? Border.all(
                                    color: widget.model.imageBorderColor!,
                                    width: widget.model.imageBorderWidth,
                                  )
                                : null,
                            image: DecorationImage(
                              image: AssetImage(widget.model.imageUrls!.first),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16.0),
              
              // Right side - Content and button
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, // Important to avoid unbounded height
                  children: [
                    // Header text
                    Text(
                      'A Flutter plugin:',
                      style: TextStyle(
                        fontFamily: 'KohSantepheap',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.model.titleColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Bullet points
                    _buildBulletPoint(
                      'allows you to download and mux (merge) YouTube video and audio streams into a single video file.',
                      widget.model.textColor,
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint(
                      'support for multiple qualities & ...',
                      widget.model.textColor,
                    ),
                    
                    const Spacer(), // Use Spacer to push button to bottom
                    
                    // Yellow Button
                    if (widget.model.yellowButton != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: widget.model.yellowButton!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: TextStyle(fontSize: 16, color: textColor, fontFamily: 'KohSantepheap')),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: textColor, fontFamily: 'KohSantepheap'),
            maxLines: 2, // Limit to 2 lines
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
