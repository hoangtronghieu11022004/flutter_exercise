import 'package:flutter/material.dart';

class MyClass extends StatelessWidget {
  const MyClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bài 4: Layout List Builder'),
            backgroundColor: Colors.orange, // Thêm màu cho AppBar
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(scaffoldContext).openDrawer();
              },
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 650,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    block1(
                      "XML và ứng dụng - Nhóm 1",
                      "2025-2026.1.TIN4583.001",
                      "58 học viên",
                      "https://images.unsplash.com/photo-1534826249391-131b0b415668?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    const SizedBox(height: 20),
                    block1(
                      "Lập trình ứng dụng cho các thiết bị di động",
                      "2025-2026.1.TIN4403.006",
                      "55 học viên",
                      "https://plus.unsplash.com/premium_photo-1673643405538-de0f82933fcb?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    const SizedBox(height: 20),
                    block1(
                      "Lập trình ứng dụng cho các thiết bị di động",
                      "2025-2026.1.TIN4403.005",
                      "52 học viên",
                      "https://plus.unsplash.com/premium_photo-1673643405552-e75a6ebfa41d?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    const SizedBox(height: 20),
                    block1(
                      "Lập trình ứng dụng cho các thiết bị di động",
                      "2025-2026.1.TIN4403.004",
                      "50 học viên",
                      "https://plus.unsplash.com/premium_photo-1666963323736-5ee1c16ef19d?q=80&w=1075&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
Widget block1(String title, String code, String students, String imageUrl) {
  return Container(
    width: 600,
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.35),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  code, // Mã khóa học
                  style: const TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 13),
                Text(students, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_horiz, color: Colors.white),
        ],
      ),
    ),
  );
}