// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_config.freezed.dart';

const defaultStartDateYear = 2025;
const defaultStartDateMonth = 1;
const defaultStartDateDay = 1;
const defaultEndDateYear = 2025;
const defaultEndDateMonth = 12;
const defaultEndDateDay = 31;
const defaultHandle = '';
const defaultPreviousHandles = <String>[];

@freezed
class SearchConfig with _$SearchConfig {
  const factory SearchConfig({
    required String handle,
    required List<String> previousHandles,
    required DateTime startDate,
    required DateTime endDate,
  }) = _searchConfig;
}
