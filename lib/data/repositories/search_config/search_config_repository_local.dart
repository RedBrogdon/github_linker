// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../../utils/result.dart';
import '../../../domain/models/search_config.dart';
import '../../services/local/shared_preferences_service.dart';
import 'search_config_repository.dart';

/// Local implementation of SearchConfigRepository. Uses shared preferences.
class SearchConfigRepositoryLocal implements SearchConfigRepository {
  static const _endDateKey = 'END_DATE';
  static const _startDateKey = 'START_DATE';
  static const _handleKey = 'HANDLE';
  static const _previousHandlesKey = 'PREVIOUS_HANDLES';

  SearchConfigRepositoryLocal({
    required SharedPreferencesService service,
  }) : _service = service;

  final SharedPreferencesService _service;

  @override
  Future<Result<SearchConfig?>> getSearchConfig() async {
    try {
      final endDate = switch (await _service.fetchDateTime(_endDateKey)) {
        Ok<DateTime?> o when o.value != null => o.value!,
        _ =>
          DateTime(DateTime.now().year, defaultEndDateMonth, defaultEndDateDay),
      };

      final startDate = switch (await _service.fetchDateTime(_startDateKey)) {
        Ok<DateTime?> o when o.value != null => o.value!,
        _ => DateTime(
            DateTime.now().year, defaultStartDateMonth, defaultStartDateDay),
      };

      final handle = switch (await _service.fetchString(_handleKey)) {
        Ok<String?> o when o.value != null => o.value!,
        _ => defaultHandle,
      };

      final previousHandles =
          switch (await _service.fetchStringList(_previousHandlesKey)) {
        Ok<List<String>?> o when o.value != null => o.value!,
        _ => defaultPreviousHandles,
      };

      final config = SearchConfig(
        endDate: endDate,
        startDate: startDate,
        handle: handle,
        previousHandles: previousHandles,
      );

      return Result.ok(config);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> setSearchConfig(SearchConfig config) async {
    try {
      await _service.saveDateTime(_endDateKey, config.endDate);
      await _service.saveDateTime(_startDateKey, config.startDate);
      await _service.saveString(_handleKey, config.handle);
      await _service.saveStringList(
          _previousHandlesKey, config.previousHandles);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
