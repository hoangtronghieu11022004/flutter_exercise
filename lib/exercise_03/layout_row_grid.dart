import 'package:flutter/material.dart';

class LayoutRowGrid extends StatelessWidget {
  const LayoutRowGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bài 3: Layout Row/Grid'),
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(scaffoldContext).openDrawer();
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    6,
                        (index) => _buildGridItem(index + 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBox(Color color, String text) {
    return Container(
      width: 80,
      height: 80,
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildGridItem(int number) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple, width: 2),
      ),
      child: Center(
        child: Text(
          'Grid Item $number',
          style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}