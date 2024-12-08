import 'package:flutter/material.dart';

import 'data/repositories/search_config/search_config_repository_local.dart';
import 'data/services/local/shared_preferences_service.dart';
import 'data/services/local/url_launcher_service.dart';
import 'ui/theme.dart';
import 'ui/viewmodels/search_viewmodel.dart';
import 'ui/widgets/search_screen.dart';

void main() {
  final repository =
      SearchConfigRepositoryLocal(service: SharedPreferencesService());
  final viewModel = SearchViewModel(searchConfigRepository: repository);
  final urlLauncherService = UrlLauncherService();

  runApp(
    MaterialApp(
      title: 'GitHub search linker',
      home: SearchScreen(
        viewModel: viewModel,
        urlLauncherService: urlLauncherService,
      ),
      theme: ThemeData(colorScheme: CustomMaterialTheme.lightScheme()),
    ),
  );
}
