import 'package:dart_example/time.dart';

void main() async {
  final time = TimeApi();

  await time.currentTime().forEach((value) {
    print("\x1B[2J\x1B[0;0H");
    print(
        'Rust says it has been ${commafy(value.toString())} seconds since January 1, 1970');
  });
}

String commafy(String value) {
  var input = value.codeUnits.reversed.toList();
  List<int> chunks = [];
  int chunkSize = 3;
  for (var i = 0; i < input.length; i += chunkSize) {
    chunks.addAll(input.sublist(
        i, i + chunkSize > input.length ? input.length : i + chunkSize));
    chunks.add(','.codeUnits[0]);
  }
  return String.fromCharCodes(chunks.reversed).replaceFirst(',', '');
}
