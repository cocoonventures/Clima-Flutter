import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  String r2;
  task1();
  r2 = await task2();
  task3(r2);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration three_sec = Duration(seconds: 3);
  String result;
  await Future.delayed(three_sec, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2data');
}
