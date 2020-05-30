# F-DateTimeRangePicker
Date and Time Range Picker for Flutter

![](https://raw.githubusercontent.com/longphanmn/f-datetimerangepicker/master/screenshots/sc1.png?token=AUGo18Ndj6dQk9mfcaIq5Cj0FfUS5_Pkks5cfn0JwA%3D%3D)

Installing:

~~~~
dependencies:
  f_datetimerangepicker: ^0.1.4
~~~~
    
Using:

~~~~
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';

 DateTimeRangePicker(
                    startText: "From",
                    endText: "To",
                    doneText: "Yes",
                    cancelText: "Cancel",
                    interval: 5,
                    initialStartTime: now,
                    initialEndTime: now.add(Duration(days: 20)),
                    mode: DateTimeRangePickerMode.dateAndTime,
                    minimumTime: now.subtract(Duration(days: 5)),
                    maximumTime: now.add(Duration(days: 25)),
                    onConfirm: (start, end) {
                      print(start);
                      print(end);
                    }).showPicker(context);
              
~~~~
