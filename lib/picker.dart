
import 'package:flutter/src/material/dialog.dart' as Dialog;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeRangePicker {
  final _cancelText = "Cancel";
  final _confirmText = "Done";
  final _title = "Picker";

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  DateTimeRangePicker({Key key, this.onCancel, this.onConfirm});

  void showDialog(BuildContext context) {
    List<Widget> actions = [];

    if (_cancelText != null && _cancelText != "") {
      actions.add(new FlatButton(
          onPressed: () {
            Navigator.pop(context);
            if (onCancel != null) onCancel();
          },
          child: new Text(_cancelText)));
    }

    if (_confirmText != null && _confirmText != "") {
      actions.add(new FlatButton(
          onPressed: () {
            Navigator.pop(context);
            if (onConfirm != null) onConfirm();
          },
          child: new Text(_confirmText)));
    }

    Dialog.showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(_title),
            actions: actions,
            content: makePicker(),
          );
        });
  }

  Widget makePicker() {
    return PickerWidget();
  }
}

class PickerWidget extends StatefulWidget {
  final Widget child;

  PickerWidget({Key key, this.child}) : super(key: key);

  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'From'),
    Tab(text: 'To'),
  ];

  TabController _tabController;

  final fromDate = DateTime.now();
  final toDate = DateTime.now().add(Duration(days: 30));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(toDate);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tab.text == "From" ? fromDate : toDate,
                onDateTimeChanged: (DateTime newDateTime) {

                },
              );
        }).toList(),
      ),
    );
  }
}
