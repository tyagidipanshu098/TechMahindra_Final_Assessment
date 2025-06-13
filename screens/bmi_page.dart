import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _bmiResult;
  String _bmiStatus = '';

  void _calculateBMI() {
    if (_weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty) {
      double weight = double.parse(_weightController.text);
      double height =
          double.parse(_heightController.text) / 100; // Convert cm to m

      setState(() {
        _bmiResult = weight / (height * height);
        _bmiStatus = _getBMIStatus(_bmiResult!);
      });
    }
  }

  String _getBMIStatus(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _getBMIColor(String status) {
    switch (status) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildBMICategory(String category, String range, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(category, style: TextStyle(fontSize: 16))),
          Text(range, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator'), elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.height),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Calculate BMI',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_bmiResult != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Your BMI',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _bmiResult!.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _getBMIColor(_bmiStatus),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getBMIColor(_bmiStatus),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _bmiStatus,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildBMICategory('Underweight', '< 18.5', Colors.blue),
                    _buildBMICategory('Normal', '18.5 - 24.9', Colors.green),
                    _buildBMICategory(
                      'Overweight',
                      '25.0 - 29.9',
                      Colors.orange,
                    ),
                    _buildBMICategory('Obese', '≥ 30.0', Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
