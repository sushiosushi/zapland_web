import 'dart:convert';
import 'dart:html' as html; // ← これが Web の localStorage に必要
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final String functionUrl =
    'https://us-central1-zapland-web.cloudfunctions.net/issue_code';

final secretCodeProvider = StateNotifierProvider<SecretCodeController, String>(
    (_) => SecretCodeController());

class SecretCodeController extends StateNotifier<String> {
  SecretCodeController() : super('') {
    loadOrIssueCode();
  }

  /// localStorage から読み込み、なければ Cloud Functions から取得
  Future<void> loadOrIssueCode() async {
    final storedCode = html.window.localStorage['secretCode'];

    if (storedCode != null && storedCode.isNotEmpty) {
      state = storedCode;
      return;
    }

    await issueCodeAndStore();
  }

  /// Cloud Functions から取得して localStorage に保存
  Future<void> issueCodeAndStore() async {
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();

    if (idToken == null) {
      print('No user token available');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(functionUrl),
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final code = data['code'];

        state = code;
        html.window.localStorage['secretCode'] = code;
      } else {
        print('Failed to load secret code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
