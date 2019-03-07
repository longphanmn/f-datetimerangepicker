# F-DateTimeRangePicker
Date and Time Range Picker for Flutter

![](https://raw.githubusercontent.com/longphanmn/f-datetimerangepicker/master/screenshots/sc1.png?token=AUGo18Ndj6dQk9mfcaIq5Cj0FfUS5_Pkks5cfn0JwA%3D%3D)

Installing:

~~~~
dependencies:
  f_datetimerangepicker: ^0.1.0
~~~~
    
Using:

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
