import 'package:flutter_test/flutter_test.dart';
import 'package:zomato_roulette/cubit/getRestCubit.dart';

void main() {
  test('Web scrape test', () async {
    String? tag = await getRestURL("Pai Vihar");
    assert(tag != null);
    assert(tag?.isNotEmpty ?? false);
    assert(tag?.contains("http") ?? false);
  });
}
