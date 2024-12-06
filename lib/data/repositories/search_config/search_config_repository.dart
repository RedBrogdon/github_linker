// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../utils/result.dart';
import '../../../domain/models/search_config.dart';

abstract class SearchConfigRepository {
  Future<Result<SearchConfig?>> getSearchConfig();
  Future<Result<void>> setSearchConfig(SearchConfig? handle);
}
