import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _formkey = GlobalKey<FormState>();
  String _height = '';
  String _weight = '';
  double _bmiResult = 0;
  String _classification = '';

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      double h = double.parse(_height);
      double w = double.parse(_weight);
      double bmi = w / (h * h);
      String type = "";

      if (bmi < 18.5) {
        type = "Thiếu cân";
      } else if (bmi <= 24.9) {
        type = "Bình thường";
      } else if (bmi <= 29.9) {
        type = "Thừa cân";
      } else {
        type = "Béo phì";
      }
      setState(() {
        _bmiResult = bmi;
        _classification = type;
      });
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Tính chỉ số BMI",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFF468376),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: _buildAppBar(scaffoldContext),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Chiều cao (mét):', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ví dụ: 1.75',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onSaved: (value) => _height = value ?? '',
                    validator: (value) {
                      if (value == null || double.tryParse(value) == null) {
                        return 'Vui lòng nhập chiều cao hợp lệ!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Cân nặng (kg):', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ví dụ: 70.5',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onSaved: (value) => _weight = value ?? '',
                    validator: (value) {
                      if (value == null || double.tryParse(value) == null) {
                        return 'Vui lòng nhập cân nặng hợp lệ!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Nút tính toán
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calculate),
                    label: const Text(
                      'Tính BMI',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF468376),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_bmiResult > 0)
                    Column(
                      children: [
                        Text(
                          'Chỉ số BMI: ${_bmiResult.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phân loại: $_classification',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}