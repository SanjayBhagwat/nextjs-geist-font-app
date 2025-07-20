import 'package:flutter/material.dart';

class EducationList extends StatelessWidget {
  final List<Map<String, dynamic>> educationList;
  final Function(String) onRemove;

  const EducationList({
    super.key,
    required this.educationList,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (educationList.isEmpty) {
      return const Center(
        child: Text(
          'No education details added yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Education',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...educationList.map((education) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              education['schoolName'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Chip(
                  label: Text(education['standard']),
                  backgroundColor: Colors.blue.shade100,
                  labelStyle: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(education['year'].toString()),
                  backgroundColor: Colors.green.shade100,
                  labelStyle: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(education['id']),
            ),
          ),
        )).toList(),
      ],
    );
  }
}
