import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:my_exercise/exercise_14/register.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userProfileFuture;
  @override
  void initState() {
    super.initState();
    _userProfileFuture = _fetchUserProfile();
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('Không tìm thấy token. Vui lòng đăng nhập lại.');
    }

    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception('Lỗi khi lấy thông tin: ${errorData['message']}');
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: const Text('Thông tin cá nhân',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, )),
      backgroundColor: Colors.red,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: _buildAppBar(scaffoldContext),
          body: FutureBuilder<Map<String, dynamic>>(
            future: _userProfileFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        'Lỗi: ${snapshot.error}', textAlign: TextAlign.center),
                  ),
                );
              }
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(user['image']),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${user['firstName']} ${user['lastName']}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${user['username']}',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(Icons.cake, 'Tuổi', user['age'].toString()),
                        _buildInfoRow(
                            Icons.transgender, 'Giới tính', user['gender']),
                        _buildInfoRow(Icons.email, 'Email', user['email']),
                        _buildInfoRow(Icons.phone, 'Số điện thoại', user['phone']),
                        _buildInfoRow(
                            Icons.bloodtype, 'Nhóm máu', user['bloodGroup']),
                        _buildInfoRow(
                            Icons.height, 'Chiều cao', '${user['height']} cm'),
                        _buildInfoRow(
                            Icons.work, 'Công ty', user['company']['name']),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: const Text(
                              'Đăng xuất', style: TextStyle(color: Colors.white,
                              fontSize: 16)),
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: Text('Không có dữ liệu.'));
            },
          ),
        );
      },
    );
  }
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}