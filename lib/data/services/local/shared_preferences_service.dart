// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/result.dart';

class SharedPreferencesService {
  final _log = Logger('SharedPreferencesService');

  Future<Result<String?>> fetchString(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final value = sharedPreferences.getString(key);
      _log.finer('Got String value for $key from SharedPreferences');
      return Result.ok(value);
    } on Exception catch (e) {
      _log.warning(
          'Failed to get String value for $key from SharedPreferences', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveString(String key, String? value) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (value == null) {
        _log.finer('Removed String value for $key from SharedPreferences');
        await sharedPreferences.remove(key);
      } else {
        _log.finer('Replaced String value for $key from SharedPreferences');
        await sharedPreferences.setString(key, value);
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning(
          'Failed to set String value for $key from SharedPreferences', e);
      return Result.error(e);
    }
  }

  Future<Result<List<String>?>> fetchStringList(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final value = sharedPreferences.getStringList(key);
      _log.finer('Got List<String> value for $key from SharedPreferences');
      return Result.ok(value);
    } on Exception catch (e) {
      _log.warning(
          'Failed to get List<String> value for $key from SharedPreferences',
          e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveStringList(String key, List<String>? value) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (value == null) {
        _log.finer(
            'Removed List<String> value for $key from SharedPreferences');
        await sharedPreferences.remove(key);
      } else {
        _log.finer(
            'Replaced List<String> value for $key from SharedPreferences');
        await sharedPreferences.setStringList(key, value);
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning(
          'Failed to set List<String> value for $key from SharedPreferences',
          e);
      return Result.error(e);
    }
  }

  Future<Result<DateTime?>> fetchDateTime(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final value = sharedPreferences.getString(key);
      final dateTime = value == null ? null : DateTime.parse(value);
      _log.finer('Got DateTime value for $key from SharedPreferences');
      return Result.ok(dateTime);
    } on Exception catch (e) {
      _log.warning(
          'Failed to get DateTime value for $key from SharedPreferences', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveDateTime(String key, DateTime? date) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (date == null) {
        _log.finer('Removed DateTime value for $key from SharedPreferences');
        await sharedPreferences.remove(key);
      } else {
        _log.finer('Replaced DateTime value for $key from SharedPreferences');
        await sharedPreferences.setString(
            key, '${date.year}-${date.month}-${date.day}');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning(
          'Failed to set DateTime value for $key from SharedPreferences', e);
      return Result.error(e);
    }
  }
}
