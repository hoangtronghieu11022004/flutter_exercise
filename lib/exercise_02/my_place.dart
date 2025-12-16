import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (scaffoldContext){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Bài 2:Layout Net Work'),
              backgroundColor: Colors.blue,
              leading: IconButton(
                  onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
                  icon: const Icon(Icons.menu, color: Colors.red,
                  )
              )
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network('https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Oeschinen Lake Campground',style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                  Text('Kandersteg, Switzerland',style: TextStyle(color: Colors.grey))
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.star,color: Colors.amber,),
                                  Text('41'),
                                ],
                              )
                            ]
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildButton(Colors.blue, Icons.call, 'CALL'),
                              _buildButton(Colors.blue, Icons.near_me, 'ROUTE'),
                              _buildButton(Colors.blue, Icons.share, 'SHARE')
                              ]
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
                                'Alps. Situated 1,578 meters above sea level, it is one of the '
                                'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
                                'half-hour walk through pastures and pine forest, leads you to the '
                                'lake, which warms to 20 degrees Celsius in the summer. Activities '
                                'enjoyed here include rowing, and riding the summer toboggan run.',
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                  ),

                ],
              ),
            )
          );
        },
    );
  }
  Widget _buildButton(Color color, IconData icon, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style:TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
    ],
    );
  }
}
