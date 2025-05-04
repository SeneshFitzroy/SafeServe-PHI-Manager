import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime? lastModified;
  final VoidCallback onTap;

  const NoteCard({
    Key? key,
    required this.title,
    required this.content,
    required this.lastModified,
    required this.onTap,
  }) : super(key: key);

  static const _colors = [
    Color(0xFFABD3FA),
    Color(0xFFFFC4D6),
    Color(0xFFCDE6FE),
    Color(0xFFEFD8FF),
    Color(0xFFFFF4C7),
    Color(0xFFB3F9D2),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = _colors[title.hashCode % _colors.length];
    final preview = content.replaceAll('\n', ' ').trim();
    final dateStr = lastModified != null
        ? DateFormat('d MMM').format(lastModified!)
        : '';

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // card body
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                preview.length > 120
                    ? '${preview.substring(0, 118)}…'
                    : preview,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // title
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          // date
          Text(dateStr,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
