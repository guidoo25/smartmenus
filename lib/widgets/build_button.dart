import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _buildButton(String text, IconData icon, {bool isSmall = false}) {
  return Container(
    width: isSmall ? null : double.infinity,
    child: CupertinoButton(
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 8 : 12,
        horizontal: isSmall ? 16 : 24,
      ),
      color: Color(0xFFD1D1D6),
      borderRadius: BorderRadius.circular(8),
      onPressed: () {
        print('Button pressed: $text');
      },
      child: Row(
        mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black87, size: isSmall ? 20 : 24),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isSmall) ...[
            SizedBox(width: 8),
            Icon(CupertinoIcons.arrow_right, color: Colors.black87, size: 20),
          ],
        ],
      ),
    ),
  );
}
