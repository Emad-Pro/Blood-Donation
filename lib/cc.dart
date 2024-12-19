import 'dart:io';

void main() {
  print('يرجى إدخال تاريخ ميلادك ميلادك:');
  int yearOfBirth = int.parse(stdin.readLineSync()!);

  int age = DateTime.now().year - yearOfBirth;

  if (age > 10) {
    print('عمرك هو $age سنوات، يمكنك لعب لعبة الرياضيات السحرية.');
  } else {
    print('عمرك هو $age سنوات، لا يمكن لعب لعبة الرياضيات السحرية.');
  }
}
