import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageNotifier extends StateNotifier<bool> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  LanguageNotifier() : super(false) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final String language = await _storage.read(key: 'language') ?? 'en';
    state = language == 'ar';
  }

  void toggleLanguage(bool newValue) {
    state = newValue;
    _storage.write(key: 'language', value: state ? 'ar' : 'en');
  }
}

final languageProvider =
    StateNotifierProvider<LanguageNotifier, bool>((ref) => LanguageNotifier());
