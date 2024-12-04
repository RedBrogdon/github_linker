// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/result.dart';

class SharedPreferencesService {
  static const _endDateKey = 'END_DATE';
  static const _startDateKey = 'START_DATE';
  static const _handleKey = 'HANDLE';
  static const _previousHandlesKey = 'PREVIOUS_HANDLES';
  final _log = Logger('SharedPreferencesService');

  Future<Result<DateTime?>> fetchEndDate() async {
    return _fetchDateTime(_endDateKey);
  }

  Future<Result<void>> saveEndDate(String? endDate) async {
    return _saveDateTime(_endDateKey, endDate);
  }

  Future<Result<DateTime?>> fetchStartDate() async {
    return _fetchDateTime(_startDateKey);
  }

  Future<Result<void>> saveStartDate(String? startDate) async {
    return _saveDateTime(_startDateKey, startDate);
  }

  Future<Result<String?>> fetchHandle() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final handle = sharedPreferences.getString(_handleKey);
      _log.finer('Got handle from SharedPreferences');
      return Result.ok(handle);
    } on Exception catch (e) {
      _log.warning('Failed to get handle', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveHandle(String? handle) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (handle == null) {
        _log.finer('Removed handle');
        await sharedPreferences.remove(_handleKey);
      } else {
        _log.finer('Replaced handle');
        await sharedPreferences.setString(_handleKey, handle);
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set handle', e);
      return Result.error(e);
    }
  }

  Future<Result<List<String>?>> fetchPreviousHandles() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final previousHandles =
          sharedPreferences.getStringList(_previousHandlesKey);
      _log.finer('Got previousHandles from SharedPreferences');
      return Result.ok(previousHandles);
    } on Exception catch (e) {
      _log.warning('Failed to get previousHandles', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> savePreviousHandles(
      List<String>? previousHandles) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (previousHandles == null) {
        _log.finer('Removed previousHandles');
        await sharedPreferences.remove(_previousHandlesKey);
      } else {
        _log.finer('Replaced previousHandles');
        await sharedPreferences.setStringList(
            _previousHandlesKey, previousHandles);
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set previousHandles', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> _saveDateTime(String key, String? dateTime) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (dateTime == null) {
        _log.finer('Removed $key');
        await sharedPreferences.remove(key);
      } else {
        _log.finer('Replaced $key');
        await sharedPreferences.setString(key, dateTime);
      }
      return Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set $key', e);
      return Result.error(e);
    }
  }

  Future<Result<DateTime?>> _fetchDateTime(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final value = sharedPreferences.getString(key);
      final dateTime = value == null ? null : DateTime.parse(value);
      _log.finer('Got $key from SharedPreferences');
      return Result.ok(dateTime);
    } on Exception catch (e) {
      _log.warning('Failed to get $key', e);
      return Result.error(e);
    }
  }
}
