import 'package:flutter/material.dart';

class AddEducationForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddEducationForm({super.key, required this.onAdd});

  @override
  State<AddEducationForm> createState() => _AddEducationFormState();
}

class _AddEducationFormState extends State<AddEducationForm> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  String? _selectedStandard;
  final _yearController = TextEditingController();

  final List<String> _standards = [
    '1st Standard', '2nd Standard', '3rd Standard', '4th Standard', '5th Standard',
    '6th Standard', '7th Standard', '8th Standard', '9th Standard', '10th Standard',
    '11th Standard', '12th Standard', 'College 1st Year', 'College 2nd Year',
    'College 3rd Year', 'College 4th Year', 'Masters', 'PhD'
  ];

  final List<String> _schoolSuggestions = [
    'Delhi Public School',
    'Kendriya Vidyalaya',
    'St. Xavier\'s School',
    'Modern School',
    'Ryan International School',
    'DAV Public School',
    'Amity International School',
    'The Heritage School',
    'Springdales School',
    'Bal Bharati Public School',
  ];

  @override
  void dispose() {
    _schoolController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onAdd({
      'schoolName': _schoolController.text,
      'standard': _selectedStandard,
      'year': int.parse(_yearController.text),
    });

    _formKey.currentState!.reset();
    _schoolController.clear();
    _yearController.clear();
    setState(() => _selectedStandard = null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Education Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _schoolSuggestions.where((String option) {
                    return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'School/College Name',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter school name';
                      }
                      return null;
                    },
                  );
                },
                onSelected: (String selection) {
                  _schoolController.text = selection;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStandard,
                decoration: const InputDecoration(
                  labelText: 'Standard/Class',
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                ),
                items: _standards.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => _selectedStandard = newValue);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a standard';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter year';
                  }
                  final year = int.tryParse(value);
                  if (year == null || year < 1990 || year > DateTime.now().year) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Add Education'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
