// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_config.freezed.dart';

enum TimeOfDay {
  any,
  morning,
  afternoon,
  evening,
  night,
}

@freezed
class SearchConfig with _$SearchConfig {
  const factory SearchConfig({
    required String handle,
    required List<String> previousHandles,
    required DateTime startDate,
    required DateTime endDate,
  }) = _searchConfig;
}
