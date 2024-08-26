import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final plainText = '$year$month$day$hour$minute$version';
    final key = Key.fromUtf8('G6gsiPgCycXjgS3iLDec5Si57rpW02YP');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // should be XXXX_XXXX
    final secretCode =
        '${encrypted.base64.substring(0, 4)}_${encrypted.base64.substring(4, 8)}';
    state = secretCode;
  }

  checkIfValid(String? code) {
    return state == code;
  }
}
