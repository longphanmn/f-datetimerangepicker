import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef PickerConfirmCallback = void Function(
    DateTime start, DateTime end);

enum DateTimeRangePickerMode {
  time,
  date,
  dateAndTime,
}

class DateTimeRangePicker {
  final startText;
  final endText;
  final DateTimeRangePickerMode mode;

  DateTime initialStartTime;
  DateTime initialEndTime;

  final VoidCallback onCancel;
  final PickerConfirmCallback onConfirm;

  final int interval;

  DateTimeRangePicker({Key key, this.onCancel, this.onConfirm, this.startText = "Start", this.endText = "End",
    this.initialStartTime, this.initialEndTime, this.mode = DateTimeRangePickerMode.dateAndTime, this.interval = 15});

  void showPicker(BuildContext context) {
  

    if (initialStartTime == null){
      initialStartTime = DateTime.now();
    }

    // Remove minutes and seconds
    initialStartTime = initialStartTime.subtract(Duration(minutes: initialStartTime.minute, seconds: initialStartTime.second));

    if (initialEndTime == null){
      initialEndTime = initialStartTime.add(Duration(days: mode == DateTimeRangePickerMode.time ? 0 : 1, hours: mode == DateTimeRangePickerMode.time ? 2 : 0));
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: height * 0.25,
                bottom: height * 0.25,
                left: width * 0.1,
                right: width * 0.1),
            child: PickerWidget(
              [
                Tab(text: startText),
                Tab(text: endText),
              ],
              initialStartTime,
              initialEndTime,
              interval,
              this.onCancel,
              this.onConfirm,
            ),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final int _interval;
  final VoidCallback _onCancel;
  final PickerConfirmCallback _onConfirm;

  final DateTime _initStart;
  final DateTime _initEnd;

  PickerWidget(this._tabs, this._initStart, this._initEnd, this._interval, this._onCancel, this._onConfirm, {Key key}) : super(key: key);

  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTime start;
  DateTime end;

  @override
  void initState() {
    super.initState();
    start = widget._initStart;
    end = widget._initEnd;
    _tabController = TabController(vsync: this, length: widget._tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            child: TabBar(
              controller: _tabController,
              tabs: widget._tabs,
              labelColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 320,
              alignment: Alignment.topCenter,
              child: TabBarView(
                controller: _tabController,
                children: widget._tabs.map((Tab tab) {
                  return CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    minuteInterval: widget._interval,
                    initialDateTime: tab.text == widget._tabs.first.text ? start : end,
                    onDateTimeChanged: (DateTime newDateTime) {
                      if (tab.text == widget._tabs.first.text){
                        setState(() {
                          start = newDateTime;
                        });
                      } else {
                        setState(() {
                          end = newDateTime;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      if (widget._onCancel != null){
                        widget._onCancel();
                      }
                    },
                    child: Text("Cancel"),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      if (widget._onConfirm != null){
                        widget._onConfirm(start, end);
                      }
                    },
                    child: Text("Done"),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
