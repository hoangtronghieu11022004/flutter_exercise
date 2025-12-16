// lib/exercise_07/change_color_app.dart

import 'dart:math';
import 'package:flutter/material.dart';

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  late Color currentColor;
  late List<Color> colors;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các giá trị ban đầu
    currentColor = Colors.black;
    colors = [
      Colors.black,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
  }
  void changeColor() {
    setState(() {
      Color newColor;
      do {
        newColor = colors[random.nextInt(colors.length)];
      } while (newColor == currentColor);
      currentColor = newColor;
    });
  }
  void resetColor() {
    setState(() {
      currentColor = Colors.black;
    });
  }
  String getColorName(Color color) {
    if (color == Colors.black) return "Đen";
    if (color == Colors.red) return "Đỏ";
    if (color == Colors.blue) return "Xanh dương";
    if (color == Colors.green) return "Xanh lá";
    if (color == Colors.purple) return "Tím";
    if (color == Colors.orange) return "Cam";
    return "";
  }
  AppBar myAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Ứng dụng đổi màu"),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }
  Widget myBody() {
    return Container(
      color: currentColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Màu hiện tại:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getColorName(currentColor),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: changeColor,
                  icon: const Icon(Icons.shuffle),
                  label: const Text("Ngẫu nhiên"),
                  style: ElevatedButton.styleFrom(
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: resetColor,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Đặt lại"),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: myAppBar(scaffoldContext),
          body: myBody(),
        );
      },
    );
  }
}