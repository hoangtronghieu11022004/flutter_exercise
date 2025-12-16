import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Làm Quen Flutter'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            leading:  IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: (){
                Scaffold.of(scaffoldContext).openDrawer();
              },
            ),
          ),
          body: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const[
                Center(
                  child: Text (
                    'Trái tim tan vỡ',
                    style: TextStyle(color: Colors.red,fontSize: 30),
                  ),
                ),
                Icon(Icons.heart_broken, size: 30,color: Colors.red),
                Text("Flutter",style: TextStyle(color: Colors.red,fontSize: 30),)
              ],
          ),
        );
      },
    );
  }
}

