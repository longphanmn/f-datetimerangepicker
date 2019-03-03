import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum DateTimeRangePickerMode {
  time,
  date,
  dateAndTime,
}

class DateTimeRangePicker {
  final startText;
  final endText;
  final DateTimeRangePickerMode mode;
  final _cancelText = "Cancel";
  final _confirmText = "Done";

  DateTime startTime;
  DateTime endTime;

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final int interval;

  DateTimeRangePicker({Key key, this.onCancel, this.onConfirm, this.startText = "Start", this.endText = "End",
    this.startTime, this.endTime, this.mode = DateTimeRangePickerMode.dateAndTime, this.interval = 15});

  void showPicker(BuildContext context) {
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

    if (startTime == null){
      startTime = DateTime.now();
    }

    // Remove minutes and seconds
    startTime = startTime.subtract(Duration(minutes: startTime.minute, seconds: startTime.second));

    if (endTime == null){
      endTime = startTime.add(Duration(days: mode == DateTimeRangePickerMode.time ? 0 : 1, hours: mode == DateTimeRangePickerMode.time ? 2 : 0));
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
            child: PickerWidget(actions, 
              [
                Tab(text: startText),
                Tab(text: endText),
              ],
              startTime,
              endTime,
              interval
            ),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Widget> _actions;
  final List<Tab> _tabs;
  final DateTime _start;
  final DateTime _end;
  final int _interval;

  PickerWidget( this._actions, this._tabs, this._start, this._end, this._interval, {Key key}) : super(key: key);

  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
                    initialDateTime: tab.text == widget._tabs.first.text ? widget._start : widget._end,
                    onDateTimeChanged: (DateTime newDateTime) {},
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget._actions,
              ),
            )
          ],
        ));
  }
}
