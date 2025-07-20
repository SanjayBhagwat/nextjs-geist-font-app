import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClassmatesPage extends StatefulWidget {
  const ClassmatesPage({super.key});

  @override
  State<ClassmatesPage> createState() => _ClassmatesPageState();
}

class _ClassmatesPageState extends State<ClassmatesPage> {
  final List<Map<String, dynamic>> _batchmates = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'email': 'rahul@example.com',
      'schoolName': 'Delhi Public School',
      'standard': '10th Standard',
      'year': 2018,
      'avatar': null,
    },
    {
      'id': '2',
      'name': 'Priya Singh',
      'email': 'priya@example.com',
      'schoolName': 'Delhi Public School',
      'standard': '10th Standard',
      'year': 2018,
      'avatar': null,
    },
    {
      'id': '3',
      'name': 'Amit Kumar',
      'email': 'amit@example.com',
      'schoolName': 'St. Xavier\'s School',
      'standard': '12th Standard',
      'year': 2020,
      'avatar': null,
    },
  ];

  String _searchQuery = '';
  String? _selectedStandard;
  String? _selectedYear;

  List<Map<String, dynamic>> get _filteredBatchmates {
    return _batchmates.where((batchmate) {
      final matchesQuery = _searchQuery.isEmpty ||
          batchmate['schoolName'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          batchmate['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesStandard = _selectedStandard == null ||
          batchmate['standard'] == _selectedStandard;
      
      final matchesYear = _selectedYear == null ||
          batchmate['year'].toString() == _selectedYear;
      
      return matchesQuery && matchesStandard && matchesYear;
    }).toList();
  }

  final List<String> _standards = [
    '1st Standard', '2nd Standard', '3rd Standard', '4th Standard', '5th Standard',
    '6th Standard', '7th Standard', '8th Standard', '9th Standard', '10th Standard',
    '11th Standard', '12th Standard', 'College 1st Year', 'College 2nd Year',
    'College 3rd Year', 'College 4th Year', 'Masters', 'PhD'
  ];

  final List<String> _years = List.generate(
    DateTime.now().year - 1990 + 1,
    (index) => (1990 + index).toString(),
  ).reversed.toList();

  void _startChat(String batchmateId) {
    context.go('/chat/$batchmateId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Classmates'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search by school or name',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedStandard,
                        decoration: const InputDecoration(
                          labelText: 'Standard',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text('All Standards'),
                          ),
                          ..._standards.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }),
                        ],
                        onChanged: (String? newValue) {
                          setState(() => _selectedStandard = newValue);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedYear,
                        decoration: const InputDecoration(
                          labelText: 'Year',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text('All Years'),
                          ),
                          ..._years.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }),
                        ],
                        onChanged: (String? newValue) {
                          setState(() => _selectedYear = newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredBatchmates.isEmpty
                ? const Center(
                    child: Text('No classmates found'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredBatchmates.length,
                    itemBuilder: (context, index) {
                      final batchmate = _filteredBatchmates[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              batchmate['name'][0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            batchmate['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(batchmate['schoolName']),
                              Row(
                                children: [
                                  Chip(
                                    label: Text(batchmate['standard']),
                                    backgroundColor: Colors.blue.shade100,
                                    labelStyle: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    label: Text(batchmate['year'].toString()),
                                    backgroundColor: Colors.green.shade100,
                                    labelStyle: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => _startChat(batchmate['id']),
                            child: const Text('Chat'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
