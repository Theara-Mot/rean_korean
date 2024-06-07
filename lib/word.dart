import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class WordScreen extends StatefulWidget {
  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _translations = [];
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _refreshTranslations();
  }

  void _refreshTranslations() async {
    final data = await dbHelper.getTranslations();
    setState(() {
      _translations = data;
    });
  }

  void _filterTranslations() {
    if (_startDate == null || _endDate == null) return;

    final filteredData = _translations.where((translation) {
      final translationDate = DateFormat('dd-MM-yyyy').parse(translation['date']);
      return translationDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
          translationDate.isBefore(_endDate!.add(Duration(days: 1)));
    }).toList();

    setState(() {
      _translations = filteredData;
    });
  }

  void _showForm(int? id) async {
    TextEditingController koreanController = TextEditingController();
    TextEditingController khmerController = TextEditingController();

    if (id != null) {
      final existingData = _translations.firstWhere((element) => element['id'] == id);
      koreanController.text = existingData['korean'];
      khmerController.text = existingData['khmer'];
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: koreanController, decoration: InputDecoration(labelText: 'Korean')),
                TextField(controller: khmerController, decoration: InputDecoration(labelText: 'Khmer')),
                SizedBox(height: 20),
                Ink(
                  child: InkWell(
                    onTap: () async {
                      final data = {
                        'korean': koreanController.text,
                        'khmer': khmerController.text,
                        'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      };
                      if (id == null) {
                        await dbHelper.insertTranslation(data);
                      } else {
                        data['id'] = id.toString();
                        await dbHelper.updateTranslation(data);
                      }
                      Navigator.of(context).pop();
                      _refreshTranslations();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff002D62),
                      ),
                      child: Text(id == null ? 'Create' : 'Update', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDeleteTranslation(int id) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.of(context).pop();
                await dbHelper.deleteTranslation(id);
                _refreshTranslations();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _filterTranslations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xff002D62),
        title: Text('ពាក្យ 어휘', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showDateRangePicker,
          ),
          InkWell(
            onTap: () => _showForm(null),
            child: Icon(Icons.add_box, color: Colors.white, size: 30),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: _translations.length,
        itemBuilder: (context, index) {
          final item = _translations[index];
          return Ink(
            child: InkWell(
              onTap: () => _showForm(item['id']),
              onLongPress: () => _confirmDeleteTranslation(item['id']),
              child: Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          item['korean'],
                          style: TextStyle(
                            color: Color(0xff002D62),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(item['korean'], style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['khmer'],
                          style: TextStyle(
                            color: Color(0xff002D62),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(item['date'], style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
