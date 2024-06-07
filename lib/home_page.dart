import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rean_korean/consonants.dart';
import 'package:rean_korean/number.dart';
import 'package:rean_korean/srak.dart';
import 'package:rean_korean/word.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'khmer': 'ស្រះ', 'korean': '모음'},
    {'khmer': 'ព្យញ្ជនះ', 'korean': '자음'},
    {'khmer': 'លេខ', 'korean': '숫자'},
    {'khmer': 'កាលបរិច្ឆេទ', 'korean': '날짜'},
    {'khmer': 'ពាក្យ', 'korean': '어휘'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('한국어를 배우다', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SrakPage()));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Consonants()));
                  
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Numbers()));
                      
                      break;
                    case 3:
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => KalPage()));
                      final snackBar = SnackBar(
                        backgroundColor:  Color.fromARGB(204, 0, 46, 98),
                        content: Text('Under Maintenance',style: TextStyle(color: Colors.white),),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      break;
                    case 4:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WordScreen()));
                      break;
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        items[index]['khmer']!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff002D62),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        items[index]['korean']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
