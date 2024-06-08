import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  final List<Map<String, String>> koreanNumbers = [
    {'number': '0', 'korean': '영', 'meaning': 'យ៉ង់'},
    {'number': '1', 'korean': '일', 'meaning': 'អ៊ីល'},
    {'number': '2', 'korean': '이', 'meaning': 'អ៊ី'},
    {'number': '3', 'korean': '삼', 'meaning': 'សាំម'},
    {'number': '4', 'korean': '사', 'meaning': 'សា'},
    {'number': '5', 'korean': '오', 'meaning': 'យ៉ូ'},
    {'number': '6', 'korean': '육', 'meaning': 'យូក'},
    {'number': '7', 'korean': '칠', 'meaning': 'ឈីល'},
    {'number': '8', 'korean': '팔', 'meaning': 'ផាល'},
    {'number': '9', 'korean': '구', 'meaning': 'ឃូ'},
    {'number': '10', 'korean': '십', 'meaning': 'ស៊ីប'},
  ];

  bool _showFirstGroup = true;
  FlutterTts flutterTts =FlutterTts();

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, String>> get firstGroup {
    return koreanNumbers.sublist(0, 11);
  }

  List<Map<String, String>> get secondGroup {
    return koreanNumbers.sublist(0, 11);
  }

  void _toggleGroup() {
    setState(() {
      _showFirstGroup = !_showFirstGroup;
    });
  }

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("ko-KR");
      await flutterTts.setSpeechRate(0.5);  // You can adjust this value as needed
      await flutterTts.setVolume(1.0);      // Set volume
      await flutterTts.setPitch(0.5);       // Set pitch
      await flutterTts.speak(text);
      print("Speaking: $text");
    } catch (e) {
      print("Error: $e");
    }
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
        title: Text('លេខ', style: TextStyle(color: Colors.white)),
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
                        'លេខចិន',
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
                        'លេខកូរ៉េ',
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
                            '${item['number']} ',
                            style: TextStyle(
                              color: Color.fromARGB(113, 0, 46, 98),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10,),
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
                            '${item['meaning']}',
                            style: TextStyle(
                              color: Color(0xff002D62),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10,),
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
