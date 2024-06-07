import 'package:flutter/material.dart';

class Consonants extends StatefulWidget {
  @override
  _ConsonantsState createState() => _ConsonantsState();
}

class _ConsonantsState extends State<Consonants> {
  final List<Map<String, String>> consonants = [
    {'korean': 'ㄱ', 'korean_name': '기역', 'khmer': 'ខ,ក,ក'},
    {'korean': 'ㄴ', 'korean_name': '니은', 'khmer': 'ន,ន,ន'},
    {'korean': 'ㄷ', 'korean_name': '디귿', 'khmer': 'ថ,ថតដ,ត'},
    {'korean': 'ㄹ', 'korean_name': '리을', 'khmer': 'រ,រល,ល'},
    {'korean': 'ㅁ', 'korean_name': '미음', 'khmer': 'ម,ម,ម'},
    {'korean': 'ㅂ', 'korean_name': '비읍', 'khmer': 'ផ,ប៉,ប'},
    {'korean': 'ㅅ', 'korean_name': '시옷', 'khmer': 'ស,ស,ត'},
    {'korean': 'ㅇ', 'korean_name': '이응', 'khmer': '-,-,ង'},
    {'korean': 'ㅈ', 'korean_name': '지읒', 'khmer': 'ឆ,ច,ត'},
    {'korean': 'ㅊ', 'korean_name': '치읓', 'khmer': 'ឆ,ឆ,ត'},
    {'korean': 'ㅋ', 'korean_name': '키읔', 'khmer': 'ខ,ខ,ក'},
    {'korean': 'ㅌ', 'korean_name': '티읕', 'khmer': 'ថ,ថ,ត'},
    {'korean': 'ㅍ', 'korean_name': '피읖', 'khmer': 'ផ,ផ,ប'},
    {'korean': 'ㅎ', 'korean_name': '히읗', 'khmer': 'ហ,ហ,ត'},
    {'korean': 'ㄲ', 'korean_name': '쌍기역', 'khmer': 'ក,ក,ក'},
    {'korean': 'ㄸ', 'korean_name': '쌍디귿', 'khmer': 'ត,ត,ត'},
    {'korean': 'ㅃ', 'korean_name': '쌍비읍', 'khmer': 'ប៉,ប៉,ប៉'},
    {'korean': 'ㅆ', 'korean_name': '쌍시옷', 'khmer': 'ស,ស,ត'},
    {'korean': 'ㅉ', 'korean_name': '쌍지읒', 'khmer': 'ច,ច,ច'},
  ];

  bool _showFirstGroup = true;

  List<Map<String, String>> get firstGroup {
    return consonants.sublist(0, 14);
  }

  List<Map<String, String>> get secondGroup {
    return consonants.sublist(14, 19);
  }

  void _toggleGroup() {
    setState(() {
      _showFirstGroup = !_showFirstGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> groupToShow = _showFirstGroup ? firstGroup : secondGroup;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('ព្យញ្ជនៈ 자음', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Ink(
                  child: InkWell(
                    onTap: () {
                      if (!_showFirstGroup) {
                        _toggleGroup();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: !_showFirstGroup ? Colors.white : Color(0xff002D62),
                        border: Border.all(color: Color(0xff002D62)),
                      ),
                      child: Text(
                        'ព្យញ្ជនៈទោល',
                        style: TextStyle(
                          color: !_showFirstGroup ? Color(0xff002D62) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Ink(
                  child: InkWell(
                    onTap: () {
                      if (_showFirstGroup) {
                        _toggleGroup();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: _showFirstGroup ? Colors.white : Color(0xff002D62),
                        border: Border.all(color: Color(0xff002D62)),
                      ),
                      child: Text(
                        'ព្យញ្ជនៈផ្សំ',
                        style: TextStyle(
                          color: _showFirstGroup ? Color(0xff002D62) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groupToShow.length,
              itemBuilder: (context, index) {
                final item = groupToShow[index];
                int actualIndex = _showFirstGroup ? index + 1 : index + 1;
                return Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$actualIndex. ',
                            style: TextStyle(
                              color: Color.fromARGB(113, 0, 46, 98),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            item['korean']!,
                            style: TextStyle(
                              color: Color(0xff002D62),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item['khmer']!,
                        style: TextStyle(
                          color: Color(0xff002D62),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
