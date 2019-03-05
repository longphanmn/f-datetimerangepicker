# F-DateTimeRangePicker
Date and Time Range Picker for Flutter

![](/screenshots/sc1.png)

How to install:

~~~~
dependencies:
  f_datetimerangepicker: ^0.0.5
~~~~
    
How to use:
~~~~
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';

DateTimeRangePicker(
    startText: "From",
    endText: "To",
    interval: 5,
    initialStartTime: DateTime.now(),
    initialEndTime: DateTime.now().add(Duration(days: 20)),
    mode: DateTimeRangePickerMode.time,
    onConfirm: (start, end) {
        
    }).showPicker(context);
~~~~
