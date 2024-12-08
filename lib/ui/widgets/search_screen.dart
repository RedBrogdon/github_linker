import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/services/local/url_launcher_service.dart';
import '../viewmodels/search_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.viewModel,
    required this.urlLauncherService,
  });

  final SearchViewModel viewModel;
  final UrlLauncherService urlLauncherService;

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _handleController = TextEditingController();

  bool _isLoading = false;

  static final _format = DateFormat.yMMMd();

  void _onLoad() {
    setState(() => _isLoading = !widget.viewModel.loadSearchConfig.completed);
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadSearchConfig.addListener(_onLoad);
    widget.viewModel.loadSearchConfig.execute();
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loadSearchConfig.removeListener(_onLoad);
    widget.viewModel.loadSearchConfig.addListener(_onLoad);
  }

  @override
  void dispose() {
    widget.viewModel.loadSearchConfig.removeListener(_onLoad);
    super.dispose();
  }

  Future<void> _checkAndOpen(BuildContext context, String url) async {
    if (widget.viewModel.handle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You need to enter a handle first!'),
      ));
    } else {
      if (!await widget.urlLauncherService.launch(url)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Could not open link! :('),
          ));
        }
      }
    }
  }

  List<Widget> _buildButtonSection(
    String title,
    BuildContext context,
    UrlBuilder buildUrl,
  ) {
    final theme = Theme.of(context);
    final startDate = widget.viewModel.startDate;
    final endDate = widget.viewModel.endDate;

    return [
      SizedBox(height: 32),
      Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
      SizedBox(height: 16),
      Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary),
            onPressed: () => _checkAndOpen(
                context, buildUrl(_handleController.text, startDate, endDate)),
            child: Text('*'),
          ),
          FilledButton(
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter')),
            child: Text('flutter/*'),
          ),
          FilledButton(
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'dart-lang')),
            child: Text('dart-lang/*'),
          ),
          OutlinedButton(
            child: Text('flutter/codelabs'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter', repo: 'codelabs')),
          ),
          OutlinedButton(
            child: Text('flutter/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter', repo: 'samples')),
          ),
          OutlinedButton(
            child: Text('flutter/flutter'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter', repo: 'flutter')),
          ),
          OutlinedButton(
            child: Text('flutter/games'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter', repo: 'games')),
          ),
          OutlinedButton(
            child: Text('flutter/website'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'flutter', repo: 'website')),
          ),
          OutlinedButton(
            child: Text('dart-lang/dart-pad'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'dart-lang', repo: 'dart-pad')),
          ),
          OutlinedButton(
            child: Text('dart-lang/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'dart-lang', repo: 'samples')),
          ),
          OutlinedButton(
            child: Text('dart-lang/sdk'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'dart-lang', repo: 'sdk')),
          ),
          OutlinedButton(
            child: Text('dart-lang/site-www'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, startDate, endDate,
                    user: 'dart-lang', repo: 'site-www')),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Search Linker'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                if (_isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your info',
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Enter a title...',
                          labelText: 'Your GitHub handle',
                        ),
                        controller: _handleController,
                        onChanged: (value) =>
                            widget.viewModel.saveHandle.execute(value),
                      ),
                    ),
                    SizedBox(height: 16),
                    Table(
                      columnWidths: {
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                        4: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Start date:',
                                style: theme.textTheme.bodyMedium?.makeBold(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    _format.format(widget.viewModel.startDate)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilledButton(
                                child: Icon(Icons.date_range),
                                onPressed: () async {
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: widget.viewModel.startDate,
                                    firstDate: DateTime(2019, 1, 1),
                                    lastDate: DateTime(2025, 1, 1),
                                  );
                                  if (newDate != null) {
                                    widget.viewModel.saveStartDate
                                        .execute(newDate);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'End date:',
                                style: theme.textTheme.bodyMedium?.makeBold(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    _format.format(widget.viewModel.endDate)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilledButton(
                                child: Icon(Icons.date_range),
                                onPressed: () async {
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: widget.viewModel.endDate,
                                    firstDate: DateTime(2018, 1, 1),
                                    lastDate:
                                        DateTime(DateTime.now().year, 12, 31),
                                  );
                                  if (newDate != null) {
                                    widget.viewModel.saveEndDate
                                        .execute(newDate);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ..._buildButtonSection(
                        'Pull requests merged', context, UrlMaker.pullsMerged),
                    ..._buildButtonSection('Pull requests reviewed', context,
                        UrlMaker.pullsReviewed),
                    ..._buildButtonSection(
                        'Issues created', context, UrlMaker.issuesCreated),
                    ..._buildButtonSection(
                        'Issues involved in', context, UrlMaker.issuesInvolved),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

typedef UrlBuilder = String Function(
  String handle,
  DateTime start,
  DateTime end, {
  String? language,
  String? user,
  String? repo,
});

class UrlMaker {
  static final _formatter = DateFormat('yyyy-MM-dd');
  static const _base = 'https://github.com';

  static String addCommonFilters(
      String url, String? language, String? user, String? repo) {
    final sb = StringBuffer(url);

    if (user != null && repo != null) {
      sb.write('repo%3A$user%2F$repo');
    } else if (user != null) {
      sb.write('user%3A$user');
    }

    if (language != null) {
      sb.write('language%3A$language+)');
    }

    return sb.toString();
  }

  static String pullsMerged(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/pulls?q=is%3Apr+author%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, language, user, repo);
  }

  static String pullsReviewed(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/pulls?q=is%3Apr+reviewed-by%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, language, user, repo);
  }

  static String issuesCreated(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/issues?q=is%3Aissue+author%3A$handle+'
        'created%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, language, user, repo);
  }

  static String issuesInvolved(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/issues?q=is%3Aissue+involves%3A$handle+'
        'updated%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, language, user, repo);
  }
}

extension BoldableTextStyle on TextStyle {
  TextStyle makeBold() {
    return copyWith(fontWeight: FontWeight.bold);
  }
}
