import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ và chính xác thông tin!', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    _formKey.currentState!.save();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đăng ký tài khoản thành công! (Demo)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Form Đăng ký"),
      backgroundColor: Colors.blue,
      centerTitle: true,
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
    required IconData icon,
    bool isPassword = false,
    bool isConfirm = false,
  }) {
    bool isVisible = isPassword ? _isPasswordVisible : (isConfirm ? _isConfirmPasswordVisible : true);

    if (isConfirm) {
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng xác nhận mật khẩu!';
        }
        if (value != _passwordController.text) {
          return 'Mật khẩu xác nhận không khớp!';
        }
        return null;
      };
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Nhập $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            prefixIcon: Icon(icon),
            suffixIcon: isPassword || isConfirm
                ? IconButton(
              icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  if (isPassword) {
                    _isPasswordVisible = !_isPasswordVisible;
                  } else if (isConfirm) {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  }
                });
              },
            )
                : null,
          ),
          obscureText: isPassword || isConfirm ? !isVisible : false,
          onSaved: (value) {
          },
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  _buildLabeledField(
                    label: 'Họ Tên',
                    controller: _nameController,
                    icon: Icons.person_outline,
                    validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng nhập Họ Tên!' : null,
                  ),
                  _buildLabeledField(
                    label: 'Email',
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng nhập Email!' : null,
                  ),
                  _buildLabeledField(
                    label: 'Mật khẩu',
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng nhập Mật khẩu!' : null,
                  ),
                  _buildLabeledField(
                    label: 'Xác nhận Mật khẩu',
                    controller: _confirmPasswordController,
                    icon: Icons.lock_outline,
                    isConfirm: true,
                    validator: (value) => null,
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text('Đăng ký', style: TextStyle(fontSize: 16)),
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
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