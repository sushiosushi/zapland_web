import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

final MAX_SEC = 30; // need to be divisible 60

final remainingSecProvider = StateNotifierProvider<RemainingSecController, int>(
    (_) => RemainingSecController());

class RemainingSecController extends StateNotifier<int> {
  RemainingSecController() : super(0) {
    update();

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      update();
    });
  }

  void update() {
    final countdown60 = 60 - DateTime.now().toUtc().second; // 1 ~ 60

    var curRemainingSec = countdown60 % MAX_SEC; // 1 ~ 30
    if (curRemainingSec == 0) {
      curRemainingSec = MAX_SEC;
    }
    state = curRemainingSec;
  }
}

final secretCodeProvider = StateNotifierProvider<SecretCodeController, String>(
    (_) => SecretCodeController());

class SecretCodeController extends StateNotifier<String> {
  SecretCodeController() : super('') {
    final version = DateTime.now().toUtc().second ~/ MAX_SEC;
    generate(version);

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (DateTime.now().toUtc().second % MAX_SEC == 0) {
        final version = DateTime.now().toUtc().second ~/ MAX_SEC;
        generate(version);
      }
    });
  }

  generate(int version) {
    final year = DateTime.now().toUtc().year;
    final month = DateTime.now().toUtc().month;
    final day = DateTime.now().toUtc().day;
    final hour = DateTime.now().toUtc().hour;
    final minute = DateTime.now().toUtc().minute;

    final sum = ((year + month * day) + hour * minute) + version * 683;

    var nums = <int>[];

    nums = [
      (sum + 239) * 157 ~/ 811 % 36,
      (sum - 661) * 719 * 919 % 36,
      ((sum ~/ 571) + 353) * 101 % 36,
      ((sum * 409) ~/ 199 + 829) % 36,
      ((sum % 457) * 431 ~/ 67) % 36,
      ((sum ~/ 5) - 307) * 557 % 36,
      pow(sum, 7).toInt() ~/ 181 % 36,
      ((sum * 59 ~/ 71) + 967) % 36,

      // 9~16
      (sum + 653) * 139 ~/ 577 % 36,
      (sum - 877) * 233 * 461 % 36,
      ((sum ~/ 167) + 283) * 409 % 36,
      ((sum * 547) ~/ 619 + 233) % 36,
      ((sum % 701) * 859 ~/ 787) % 36,
      ((sum ~/ 709) - 151) * 911 % 36,
      pow(sum, 11).toInt() ~/ 773 % 36,
      ((sum * 73 ~/ 41) + 383) % 36,
    ];

    // nums.add(first);

    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final code = nums.map((e) => alphabet[e]).join();

    // should be XXXX_XXXX
    final secretCode = '${code.substring(0, 8)}_${code.substring(8)}';
    state = secretCode;
  }

  checkIfValid(String? code) {
    // print('code: $code state: $state');
    return state == code;
  }
}

final fakeSecretCodeProvider =
    StateNotifierProvider<FakeSecretCodeController, String>(
        (_) => FakeSecretCodeController());

class FakeSecretCodeController extends StateNotifier<String> {
  FakeSecretCodeController() : super('') {
    final version = DateTime.now().toUtc().second ~/ MAX_SEC;
    generate(version);

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (DateTime.now().toUtc().second % MAX_SEC == 0) {
        final version = DateTime.now().toUtc().second ~/ MAX_SEC;
        generate(version);
      }
    });
  }

  generate(int version) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    // random alphabet (6 length)
    final fakeSecretCode =
        List.generate(6, (index) => alphabet[Random().nextInt(26)]).join();

    state = fakeSecretCode;
  }
}
