Example:

~~~~
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';

DateTimeRangePicker(
                    startText: "From",
                    endText: "To",
                    doneText: "Yes",
                    cancelText: "Cancel",
                    interval: 5,
                    initialStartTime: DateTime.now(),
                    initialEndTime: DateTime.now().add(Duration(days: 20)),
                    mode: DateTimeRangePickerMode.dateAndTime,
                    minimumTime: DateTime.now().subtract(Duration(days: 5)),
                    maximumTime: DateTime.now().add(Duration(days: 25)),
                    use24hFormat: true,
                    onConfirm: (start, end) {
                      print(start);
                      print(end);
                    }).showPicker(context);
~~~~
