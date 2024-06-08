import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rean_korean/Service/audioController.dart';
import 'package:rean_korean/Widget/buildContainer.dart';

class SrakPage extends StatefulWidget {
  @override
  _SrakPageState createState() => _SrakPageState();
}

class _SrakPageState extends State<SrakPage> {
  final List<Map<String, String>> vowels = [
    {'korean': '아', 'korean_name': 'អា', 'khmer': ''},
    {'korean': '야', 'korean_name': 'យ៉ា', 'khmer': ''},
    {'korean': '어', 'korean_name': 'អ', 'khmer': ''},
    {'korean': '여', 'korean_name': 'យ៉', 'khmer': ''},
    {'korean': '오', 'korean_name': 'អូ', 'khmer': ''},
    {'korean': '요', 'korean_name': 'យូ', 'khmer': ''},
    {'korean': '우', 'korean_name': 'អូ', 'khmer': ''},
    {'korean': '유', 'korean_name': 'យូ', 'khmer': ''},
    {'korean': '으', 'korean_name': 'អឺ', 'khmer': ''},
    {'korean': '이', 'korean_name': 'អ៊ី', 'khmer': ''},
    {'korean': '애', 'korean_name': 'អែ', 'khmer': ''},
    {'korean': '얘', 'korean_name': 'យែ', 'khmer': ''},
    {'korean': '에', 'korean_name': 'អេ', 'khmer': ''},
    {'korean': '예', 'korean_name': 'យ៉េ', 'khmer': ''},
    {'korean': '와', 'korean_name': 'វ៉ា', 'khmer': ''},
    {'korean': '왜', 'korean_name': 'វ៉ែ', 'khmer': ''},
    {'korean': '외', 'korean_name': 'វេ', 'khmer': ''},
    {'korean': '워', 'korean_name': 'វ៉', 'khmer': ''},
    {'korean': '웨', 'korean_name': 'វ៉េ', 'khmer': ''},
    {'korean': '위', 'korean_name': 'វី', 'khmer': ''},
    {'korean': '의', 'korean_name': 'អ៊ើយ', 'khmer': ''}
  ];


  bool _showFirstGroup = true;
  int _selectedItemIndex = -1;
  bool showTranslate = true;
  bool showPinyin = true;
  bool showKorean = true;
  FlutterTts flutterTts = FlutterTts();

  List<Map<String, String>> get firstGroup => vowels.sublist(0, 10);

  List<Map<String, String>> get secondGroup => vowels.sublist(10, 21);

  void _toggleGroup() {
    setState(() {
      _showFirstGroup = !_showFirstGroup;
    });
  }

  @override
  void dispose() {
    AudioController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> groupToShow =
    _showFirstGroup ? firstGroup : secondGroup;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('ស្រះ 모음', style: TextStyle(color: Colors.white)),
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
          SizedBox(width: 10)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
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
                      color: _showFirstGroup ? Color(0xff002D62) : Colors.white,
                    ),
                    child: Text(
                      'ស្រះទោល',
                      style: TextStyle(
                        color:
                        _showFirstGroup ? Colors.white : Color(0xff002D62),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
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
                      color: !_showFirstGroup ? Color(0xff002D62) : Colors.white,
                    ),
                    child: Text(
                      'ស្រះទោល',
                      style: TextStyle(
                        color: !_showFirstGroup ? Colors.white : Color(0xff002D62),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
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
              }, showKorean: showKorean,
            ),
          ),
        ],
      ),
    );
  }
}
