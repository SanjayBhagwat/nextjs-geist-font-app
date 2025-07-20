import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myclassmates/src/features/dashboard/presentation/widgets/add_education_form.dart';
import 'package:myclassmates/src/features/dashboard/presentation/widgets/education_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> _educationList = [
    {
      'id': '1',
      'schoolName': 'Delhi Public School',
      'standard': '10th Standard',
      'year': 2018,
    },
    {
      'id': '2',
      'schoolName': 'St. Xavier\'s School',
      'standard': '12th Standard',
      'year': 2020,
    },
  ];

  void _addEducation(Map<String, dynamic> education) {
    setState(() {
      _educationList.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        ...education,
      });
    });
  }

  void _removeEducation(String id) {
    setState(() {
      _educationList.removeWhere((edu) => edu['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Educational Background',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AddEducationForm(onAdd: _addEducation),
            const SizedBox(height: 30),
            EducationList(
              educationList: _educationList,
              onRemove: _removeEducation,
            ),
            const SizedBox(height: 30),
            if (_educationList.isNotEmpty) ...[
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go('/classmates'),
                      icon: const Icon(Icons.people),
                      label: const Text('Find Classmates'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/chat'),
                      icon: const Icon(Icons.chat),
                      label: const Text('Chats'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
