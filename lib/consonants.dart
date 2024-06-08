import 'package:flutter/material.dart';
import 'package:rean_korean/Widget/buildContainer.dart';
import 'package:rean_korean/Service/audioController.dart';

class Consonants extends StatefulWidget {
  @override
  _ConsonantsState createState() => _ConsonantsState();
}

class _ConsonantsState extends State<Consonants> {
  final List<Map<String, String>> consonants = [
    {'korean': 'ㄱ', 'korean_name': 'ឃីយ៉ក', 'khmer': 'ខ , ក , ក'},
    {'korean': 'ㄴ', 'korean_name': 'នីអ៉ីន', 'khmer': 'ន , ន , ន'},
    {'korean': 'ㄷ', 'korean_name': 'ដីក្រ', 'khmer': 'ថ , ថ ត ដ , ត '},
    {'korean': 'ㄹ', 'korean_name': 'រីអ៉ីល', 'khmer': 'រ,រល,ល'},
    {'korean': 'ㅁ', 'korean_name': 'មីអ៉ីម', 'khmer': 'ម,ម,ម'},
    {'korean': 'ㅂ', 'korean_name': 'ផីអ៉ីប', 'khmer': 'ផ,ប៉,ប'},
    {'korean': 'ㅅ', 'korean_name': 'សីអ៉ីត', 'khmer': 'ស,ស,ត'},
    {'korean': 'ㅇ', 'korean_name': 'អ៉ីអ៉ីង', 'khmer': '-,-,ង'},
    {'korean': 'ㅈ', 'korean_name': 'ឈីអ៉ីន', 'khmer': 'ឆ,ច,ត'},
    {'korean': 'ㅊ', 'korean_name': 'ឈីអ៉ីធ', 'khmer': 'ឆ,ឆ,ត'},
    {'korean': 'ㅋ', 'korean_name': 'ឃីអ៉ីក', 'khmer': 'ខ,ខ,ក'},
    {'korean': 'ㅌ', 'korean_name': 'តីអ៉ី', 'khmer': 'ថ,ថ,ត'},
    {'korean': 'ㅍ', 'korean_name': 'ផីអ៉ី', 'khmer': 'ផ,ផ,ប'},
    {'korean': 'ㅎ', 'korean_name': 'ហីអ៉ី', 'khmer': 'ហ,ហ,ត'},
    {'korean': 'ㄲ', 'korean_name': 'សាំងឃីអ៉ីក', 'khmer': 'ក,ក,ក'},
    {'korean': 'ㄸ', 'korean_name': 'សាំងតីអ៉ី', 'khmer': 'ត,ត,ត'},
    {'korean': 'ㅃ', 'korean_name': 'សាំងប៉ីអ៉ី', 'khmer': 'ប៉,ប៉,ប៉'},
    {'korean': 'ㅆ', 'korean_name': 'សាំងសីអ៉ីត', 'khmer': 'ស,ស,ត'},
    {'korean': 'ㅉ', 'korean_name': 'សាំងចីអ៉ីធ', 'khmer': 'ច,ច,ច'},
  ];

  bool _showFirstGroup = true;
  int _selectedItemIndex = -1;
  bool showTranslate = true;
  bool showPinyin = true;
  bool showKorean = true;

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
  void dispose() {
    AudioController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> groupToShow = _showFirstGroup ? firstGroup : secondGroup;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('ព្យញ្ជនៈ 자음', style: TextStyle(color: Colors.white)),
        actions: [
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
              SizedBox(width: 8),
              Expanded(
                child: _buildGroupButton('ព្យញ្ជនៈទោល', !_showFirstGroup),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildGroupButton('ព្យញ្ជនៈផ្សំ', _showFirstGroup),
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
              }, showKorean: showKorean,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupButton(String text, bool isSelected) {
    return Ink(
      child: InkWell(
        onTap: () {
          if (isSelected) {
            _toggleGroup();
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? Colors.white : Color(0xff002D62),
            border: Border.all(color: Color(0xff002D62)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Color(0xff002D62) : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
