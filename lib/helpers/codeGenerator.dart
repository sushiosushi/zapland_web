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

    // make random code by using year, month, day, hour, minute
    // final plainText = '$year$month$day$hour$minute$version';
    // final key = Key.fromUtf8('G6gsiPgCycXjgS3iLDec5Si57rpW02YP');

    // final iv = IV.fromLength(8);
    // final encrypter = Encrypter(Salsa20(key));

    // final encrypted = encrypter.encrypt(plainText, iv: iv);

    // print('plainText: ${plainText} eccrypted: ${encrypted.base64}');

    final sum = ((year + month * day) + hour * minute) + version * 683;

    var nums = <int>[];

    final first = (sum + 239) * 157 ~/ 811 % 26;
    final second = (sum - 661) * 719 * 919 % 26;
    final third = ((sum ~/ 571) + 353) * 101 % 26;
    final fourth = ((sum * 409) ~/ 199 + 829) % 26;
    final fifth = ((sum % 457) * 431 ~/ 67) % 26;
    final sixth = ((sum ~/ 5) - 307) * 557 % 26;
    final seventh = pow(sum, 7).toInt() ~/ 181 % 26;
    final eighth = ((sum * 59 ~/ 71) + 967) % 26;

    nums.add(first);
    nums.add(second);
    nums.add(third);
    nums.add(fourth);
    nums.add(fifth);
    nums.add(sixth);
    nums.add(seventh);
    nums.add(eighth);

    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final code = nums.map((e) => alphabet[e]).join();

    // should be XXXX_XXXX
    final secretCode = '${code.substring(0, 4)}_${code.substring(4)}';
    state = secretCode;
  }

  checkIfValid(String? code) {
    // print('code: $code state: $state');
    return state == code;
  }
}
