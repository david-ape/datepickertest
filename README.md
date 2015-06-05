# datepickertest
Program to test popping up a date picker (to demonstrate that UIDatePicker seems to be leaking memory on IOS 8.3).

When I run this in the xcode 6.3.2 Leaks profiler I see the following:

1) On IOS7: no memory leaks.

2) On IOS8.3: Approx 5K in multiple memory leaks every time the date picker is popped up and then dismissed. The leaked object is NSDateComponents, and the responsible frame is [_UIDatePickerMode _yearlessYearForMonth:].


