import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'Widget/buildContainer.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  final List<Map<String, String>> koreanNumbers = [
    {'khmer': '0', 'korean': '영', 'korean_name': 'យ៉ង់'},
    {'khmer': '1', 'korean': '일', 'korean_name': 'អ៊ីល'},
    {'khmer': '2', 'korean': '이', 'korean_name': 'អ៊ី'},
    {'khmer': '3', 'korean': '삼', 'korean_name': 'សាំម'},
    {'khmer': '4', 'korean': '사', 'korean_name': 'សា'},
    {'khmer': '5', 'korean': '오', 'korean_name': 'យ៉ូ'},
    {'khmer': '6', 'korean': '육', 'korean_name': 'យូក'},
    {'khmer': '7', 'korean': '칠', 'korean_name': 'ឈីល'},
    {'khmer': '8', 'korean': '팔', 'korean_name': 'ផាល'},
    {'khmer': '9', 'korean': '구', 'korean_name': 'ឃូ'},
    {'khmer': '10', 'korean': '십', 'korean_name': 'ស៊ីប'},
  ];
  bool _showFirstGroup = true;
  int _selectedItemIndex = -1;
  bool showTranslate = true;
  bool showPinyin = true;
  bool showKorean = true;
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
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                showKorean = !showKorean;
              });
            },
            child: Icon(
              !showKorean ? Icons.check_box_outline_blank_outlined : Icons.check_box,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                showPinyin = !showPinyin;
              });
            },
            child: Icon(
              !showPinyin ? Icons.check_box_outline_blank_outlined : Icons.check_box,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                showTranslate = !showTranslate;
              });
            },
            child: Icon(
              !showTranslate ? Icons.check_box_outline_blank_outlined : Icons.check_box,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(width: 10)
        ],
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
          SizedBox(height: 10),
          Expanded(
            child: BuildContainer(
              groupToShow: groupToShow,
              selectedItemIndex: _selectedItemIndex,
              showPinyin: showPinyin,
              showTranslate: showTranslate,
              onTap: (index) {
                setState(() {
                  _selectedItemIndex = index;
                });
              }, showKorean:showKorean,
            ),
          ),
        ],
      ),
    );
  }
}
