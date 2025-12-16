import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formkey = GlobalKey<FormState>();
  String _fullName = '';
  String? _rating;
  String _content = '';

  final List<String> _starOptions = [
    '1 Sao',
    '2 Sao',
    '3 Sao',
    '4 Sao',
    '5 Sao',
  ];

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gửi thành công!\nTên: $_fullName\nĐánh giá: $_rating\nNội dung: $_content',
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.deepOrange,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Vui lòng điền đầy đủ thông tin!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Gửi phản hồi",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.deepOrange,
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
                  const Text('Họ và Tên:', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nhập tên của bạn',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onSaved: (value) => _fullName = value ?? '',
                    // Thêm validator
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text('Đánh giá dịch vụ:', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Chọn số sao',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    value: _rating,
                    items: _starOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _rating = newValue;
                      });
                    },
                    onSaved: (value) => _rating = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn đánh giá!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text('Nội dung phản hồi:', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nhập nội dung phản hồi của bạn',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => _content = value ?? '',
                    // Thêm validator
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập nội dung!';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Gửi phản hồi',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
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