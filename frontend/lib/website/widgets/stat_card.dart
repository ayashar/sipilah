import 'package:flutter/material.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final isCompact = maxHeight.isFinite && maxHeight < 90;
        final verticalPadding = isCompact ? 10.0 : 16.0;
        final iconSize = isCompact ? 18.0 : 24.0;
        final titleStyle = TextStyle(
          color: Colors.grey,
          fontSize: isCompact ? 12 : 14,
        );
        final valueStyle = TextStyle(
          fontSize: isCompact ? 18 : 20,
          fontWeight: FontWeight.bold,
        );

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.green, size: iconSize),
              SizedBox(height: isCompact ? 4 : 8),
              Text(
                title,
                style: titleStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isCompact ? 2 : 4),
              Text(
                value,
                style: valueStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
