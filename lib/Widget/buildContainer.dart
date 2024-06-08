import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rean_korean/Service/audioController.dart';

class BuildContainer extends StatelessWidget {
  final List<Map<String, String>> groupToShow;
  final int selectedItemIndex;
  final bool showTranslate;
  final bool showPinyin;
  final bool showKorean; // New property
  final Function(int) onTap;

  const BuildContainer({
    required this.groupToShow,
    required this.selectedItemIndex,
    required this.showTranslate,
    required this.showPinyin,
    required this.showKorean, // Updated constructor
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupToShow.length,
      itemBuilder: (context, index) {
        final item = groupToShow[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                AudioController.play(item['korean']!);
                onTap(index);
              },
              splashColor: Color(0xff002D62),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: selectedItemIndex == index ? Color(0xff002D62) : Colors.white,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showKorean ? item['korean']! : '', // Conditional display
                          style: TextStyle(
                            color: Color(0xff002D62),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          showPinyin ? item['korean_name']! : '',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          showTranslate ? item['khmer']! : '',
                          style: TextStyle(
                            color: Color(0xff002D62),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.slowmo,
                            color: Color(0xff002D62),
                          ),
                          onPressed: () {
                            AudioController.playSlow(item['korean']!);
                            onTap(index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
