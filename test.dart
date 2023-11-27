import 'package:intl/intl.dart';

main() {
  DateTime now = new DateTime.now();

  
  print(now.toIso8601String());

final d = dummy(date:DateTime.now());
  final d1 = dummy(date:DateTime.now().subtract(Duration(days: 1)));
  final d2 = dummy(date:DateTime.now().subtract(Duration(days: 2)));

  List<dummy> list = [d,d1,d2];
  list.sort((a,b)=>b.date!.compareTo(a.date!));
  print(list);
}


class dummy {
  DateTime? date;
  dummy({this.date});
  @override
  String toString() {
    return '${date!.year}-${date!.month}-${date!.day}';
  }
}