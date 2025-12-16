import 'package:flutter/material.dart';
import 'package:my_exercise/exercise_01/my_home_page.dart';
import 'package:my_exercise/exercise_02/my_place.dart';
import 'package:my_exercise/exercise_03/layout_row_grid.dart';
import 'package:my_exercise/exercise_04/my_class.dart';
import 'package:my_exercise/exercise_05/home_page.dart';
import 'package:my_exercise/exercise_06/counter_app.dart';
import 'package:my_exercise/exercise_07/change_color_app.dart';
import 'package:my_exercise/exercise_08/login.dart';
import 'package:my_exercise/exercise_09/register_form.dart';
import 'package:my_exercise/exercise_10/bmi.dart';
import 'package:my_exercise/exercise_11/feedback.dart';
import 'package:my_exercise/exercise_12/my_product.dart';
import 'package:my_exercise/exercise_13/news_list_screen.dart';
import 'package:my_exercise/exercise_14/auth_flow_wrapper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const MyHomePage(),      // 0: Bài 1
    const MyPlace(),         // 1: Bài 2
    const LayoutRowGrid(),   // 2: Bài 3
    const MyClass(),         // 3: Bài 4
    const HomePage(),        // 4: Bài 5
    const CounterApp(),      // 5: Bài 6
    const ChangeColorApp(),  // 6: Bài 7
    const Login(),           // 7: Bài 8
    const RegisterForm(),    // 8: Bài 9
    const BMICalculator(),   // 9: Bài 10
    const FeedbackForm(),    // 10: Bài 11
    const MyProduct(),       // 11: Bài 12
    const NewsListScreen(),  // 12: Bài 13
    const AuthFlowWrapper(), // 13: Bài 14
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Bài 01: Layout Cơ bản', 'icon': Icons.favorite_border},
    {'title': 'Bài 02: Layout Network', 'icon': Icons.photo},
    {'title': 'Bài 03: Layout Row/Grid', 'icon': Icons.grid_on},
    {'title': 'Bài 04: Layout List Builder', 'icon': Icons.list_alt},
    {'title': 'Bài 05: Layout Assets', 'icon': Icons.image},
    {'title': 'Bài 06: Ứng dụng Đếm số', 'icon': Icons.plus_one},
    {'title': 'Bài 07: Ứng dụng Đổi màu', 'icon': Icons.color_lens},
    {'title': 'Bài 08: Form Đăng nhập', 'icon': Icons.login},
    {'title': 'Bài 09: Form Đăng ký', 'icon': Icons.person_add},
    {'title': 'Bài 10: Tính chỉ số BMI', 'icon': Icons.monitor_weight},
    {'title': 'Bài 11: Form Phản hồi', 'icon': Icons.feedback},
    {'title': 'Bài 12: API Danh sách Sản phẩm', 'icon': Icons.shopping_bag},
    {'title': 'Bài 13: API Tin tức (My Post)', 'icon': Icons.article},
    {'title': 'Bài 14: Đăng nhập/Profile API', 'icon': Icons.security},
  ];
  void _onMenuItemTap(int index, BuildContext drawerContext) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(drawerContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (drawerContext) {
        return Scaffold(
          appBar: null,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.deepPurple),
                  child: Text('Menu Bài Tập Flutter',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                ..._menuItems
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  return ListTile(
                    leading: Icon(item['icon'] as IconData),
                    title: Text(item['title'] as String),
                    selected: _selectedIndex == index,
                    onTap: () => _onMenuItemTap(index, drawerContext),
                  );
                }).toList(),
              ],
            ),
          ),
          body: _screens[_selectedIndex],
        );
      },
    );
  }
}