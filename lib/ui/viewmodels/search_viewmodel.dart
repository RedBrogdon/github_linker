// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: unused_element

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../data/repositories/search_config/search_config_repository.dart';
import '../../domain/models/search_config.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel({
    required SearchConfigRepository searchConfigRepository,
  }) : _searchConfigRepository = searchConfigRepository {
    loadSearchConfig = Command0(_loadSearchConfig)..execute();
    saveHandle = Command1(_saveHandle);
    savePreviousHandles = Command1(_savePreviousHandles);
    saveStartDate = Command1(_saveStartDate);
    saveEndDate = Command1(_saveEndDate);
    _searchConfig = SearchConfig(
        handle: '',
        previousHandles: [],
        startDate: DateTime.now(),
        endDate: DateTime.now());
  }

  final _log = Logger('ActivitiesViewModel');
  final SearchConfigRepository _searchConfigRepository;

  late SearchConfig _searchConfig;

  String get handle => _searchConfig.handle;
  List<String> get previousHandles => _searchConfig.previousHandles;
  DateTime get startDate => _searchConfig.startDate;
  DateTime get endDate => _searchConfig.endDate;

  /// Load the current search configuration.
  late final Command0 loadSearchConfig;

  /// Save the current search configuration.
  late final Command1<void, String> saveHandle;
  late final Command1<void, List<String>> savePreviousHandles;
  late final Command1<void, DateTime> saveStartDate;
  late final Command1<void, DateTime> saveEndDate;

  Future<Result<void>> _loadSearchConfig() async {
    final result = await _searchConfigRepository.getSearchConfig();

    switch (result) {
      case Error():
        _log.warning(
          'Failed to load stored SearchConfig',
          result.asError.error,
        );
        return result;
      case Ok():
        _log.fine('SearchConfig loaded.');
        if (result.value != null) {
          _searchConfig = result.value!;
        }
        notifyListeners();
        return result;
    }
  }

  Future<Result<void>> _saveHandle(String handle) async {
    _searchConfig = _searchConfig.copyWith(handle: handle);
    notifyListeners();
    return await _saveSearchConfig();
  }

  Future<Result<void>> _savePreviousHandles(
      List<String> previousHandles) async {
    _searchConfig = _searchConfig.copyWith(previousHandles: previousHandles);
    notifyListeners();
    return await _saveSearchConfig();
  }

  Future<Result<void>> _saveStartDate(DateTime startDate) async {
    _searchConfig = _searchConfig.copyWith(startDate: startDate);
    notifyListeners();
    return await _saveSearchConfig();
  }

  Future<Result<void>> _saveEndDate(DateTime endDate) async {
    _searchConfig = _searchConfig.copyWith(endDate: endDate);
    notifyListeners();
    return await _saveSearchConfig();
  }

  Future<Result<void>> _saveSearchConfig() async {
    final result = await _searchConfigRepository.setSearchConfig(_searchConfig);
    if (result is Error) {
      _log.warning(
        'Failed to store SearchConfig',
        result.asError.error,
      );
    }
    return result;
  }
}
