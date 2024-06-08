import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SrakPage extends StatefulWidget {
  @override
  _SrakPageState createState() => _SrakPageState();
}

class _SrakPageState extends State<SrakPage> {
  final List<Map<String, String>> vowels = [
    {'korean': '아', 'khmer': 'អា'},
    {'korean': '야', 'khmer': 'យ៉ា'},
    {'korean': '어', 'khmer': 'អ'},
    {'korean': '여', 'khmer': 'យ៉'},
    {'korean': '오', 'khmer': 'អូ'},
    {'korean': '요', 'khmer': 'យូ'},
    {'korean': '우', 'khmer': 'អូ'},
    {'korean': '유', 'khmer': 'យូ'},
    {'korean': '으', 'khmer': 'អឺ'},
    {'korean': '이', 'khmer': 'អ៊ី'},
    {'korean': '애', 'khmer': 'អែ'},
    {'korean': '얘', 'khmer': 'យែ'},
    {'korean': '에', 'khmer': 'អេ'},
    {'korean': '예', 'khmer': 'យ៉េ'},
    {'korean': '와', 'khmer': 'វ៉ា'},
    {'korean': '왜', 'khmer': 'វ៉ែ'},
    {'korean': '외', 'khmer': 'វេ'},
    {'korean': '워', 'khmer': 'វ៉'},
    {'korean': '웨', 'khmer': 'វ៉េ'},
    {'korean': '위', 'khmer': 'វី'},
    {'korean': '의', 'khmer': 'អ៊ើយ'}
  ];

  bool _showFirstGroup = true;
  FlutterTts flutterTts = FlutterTts();

  List<Map<String, String>> get firstGroup {
    return vowels.sublist(0, 10);
  }

  List<Map<String, String>> get secondGroup {
    return vowels.sublist(10, 21);
  }

  void _toggleGroup() {
    setState(() {
      _showFirstGroup = !_showFirstGroup;
    });
  }

  Future<void> _speak(String koreanText) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(koreanText);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> groupToShow = _showFirstGroup ? firstGroup : secondGroup;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('ស្រះ 모음', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 8,),
              Expanded(
                child: Ink(
                  child: InkWell(
                    onTap: () async {
                      if (!_showFirstGroup) {
                        _toggleGroup();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: _showFirstGroup ? Color(0xff002D62) : Colors.white,
                      ),
                      child: Text(
                        'ស្រះទោល',
                        style: TextStyle(color: _showFirstGroup ? Colors.white : Color(0xff002D62)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                child: Ink(
                  child: InkWell(
                    onTap: () async {
                      if (_showFirstGroup) {
                        _toggleGroup();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: !_showFirstGroup ? Color(0xff002D62) : Colors.white,
                      ),
                      child: Text(
                        'ស្រះទោល',
                        style: TextStyle(color: !_showFirstGroup ? Colors.white : Color(0xff002D62)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groupToShow.length,
              itemBuilder: (context, index) {
                final item = groupToShow[index];
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
                            item['korean']!,
                            style: TextStyle(
                              color: Color(0xff002D62),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            item['khmer']!,
                            style: TextStyle(
                              color: Color(0xff002D62),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.volume_up, color: Color(0xff002D62)),
                            onPressed: () {
                              _speak(item['korean']!);
                            },
                          ),
                        ],
                      )
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

