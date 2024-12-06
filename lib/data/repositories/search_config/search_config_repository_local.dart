// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../../utils/result.dart';
import '../../../domain/models/search_config.dart';
import '../../services/local/shared_preferences_service.dart';
import 'search_config_repository.dart';

/// Local implementation of SearchConfigRepository. Uses shared preferences.
class SearchConfigRepositoryLocal implements SearchConfigRepository {
  SearchConfigRepositoryLocal({
    required SharedPreferencesService service,
  }) : _service = service;

  final SharedPreferencesService _service;

  @override
  Future<Result<SearchConfig?>> getSearchConfig() async {
    try {
      final endDate = (await _service.fetchEndDate()).asOk.value;
      final startDate = (await _service.fetchStartDate()).asOk.value;
      final handle = (await _service.fetchHandle()).asOk.value;
      final previousHandles =
          (await _service.fetchPreviousHandles()).asOk.value;

      final config = SearchConfig(
        endDate: endDate ??
            DateTime(
                defaultEndDateYear, defaultEndDateMonth, defaultEndDateDay),
        startDate: startDate ??
            DateTime(defaultStartDateYear, defaultStartDateMonth,
                defaultStartDateDay),
        handle: handle ?? defaultHandle,
        previousHandles: previousHandles ?? defaultPreviousHandles,
      );

      return Result.ok(config);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> setSearchConfig(SearchConfig? config) async {
    try {
      await _service.saveEndDate(config?.endDate);
      await _service.saveStartDate(config?.startDate);
      await _service.saveHandle(config?.handle);
      await _service.savePreviousHandles(config?.previousHandles);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
