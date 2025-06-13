import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../utils/category_utils.dart';

class AddWorkoutPage extends StatefulWidget {
  final Function(Workout) onAddWorkout;

  const AddWorkoutPage({super.key, required this.onAddWorkout});

  @override
  _AddWorkoutPageState createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  String _selectedCategory = 'Cardio';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Workout'), elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Workout Title',
                          hintText: 'e.g., Push-ups',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.fitness_center),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a workout title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: CategoryUtils.getCategories().map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _durationController,
                        decoration: InputDecoration(
                          labelText: 'Duration (minutes)',
                          hintText: 'e.g., 30',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.timer),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter duration';
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'Please enter a valid duration';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final workout = Workout(
                      title: _titleController.text,
                      category: _selectedCategory,
                      duration: int.parse(_durationController.text),
                      date: _selectedDate,
                    );
                    widget.onAddWorkout(workout);
                    _titleController.clear();
                    _durationController.clear();
                    setState(() {
                      _selectedCategory = 'Cardio';
                      _selectedDate = DateTime.now();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Workout added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Add Workout', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
