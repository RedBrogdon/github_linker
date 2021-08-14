import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'github.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'GitHub search linker',
      home: GitHubLinksScreen(),
    ),
  );
}

class GitHubLinksScreen extends StatefulWidget {
  const GitHubLinksScreen({Key? key}) : super(key: key);

  @override
  _GitHubLinksScreenState createState() => _GitHubLinksScreenState();
}

extension BoldableTextStyle on TextStyle {
  TextStyle makeBold() {
    return copyWith(fontWeight: FontWeight.bold);
  }
}

class _GitHubLinksScreenState extends State<GitHubLinksScreen> {
  DateTime _startDate = DateTime(2020, 10, 1);
  DateTime _endDate = DateTime(2021, 3, 31);
  final _handleController = TextEditingController();
  SortType _sortType = SortType.newest;

  static final _format = DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) async {
      final handle = prefs.getString('handle') ?? '';
      _handleController.text = handle;
    });

    final now = DateTime.now();

    if (now.month < 4) {
      _startDate = DateTime(now.year - 1, 10, 1);
      _endDate = DateTime(now.year, 3, 31);
    } else if (now.month < 10) {
      _startDate = DateTime(now.year, 4, 1);
      _endDate = DateTime(now.year, 9, 30);
    } else {
      _startDate = DateTime(now.year, 10, 1);
      _endDate = DateTime(now.year + 1, 3, 31);
    }
  }

  Future<void> _saveHandle(String handle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('handle', handle);
  }

  Future<void> _checkAndOpen(BuildContext context, String url) async {
    if (_handleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You need to enter a handle first!'),
      ));
    } else {
      if (await launcher.canLaunch(url)) {
        await launcher.launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not open link! :('),
        ));
      }
    }
  }

  List<Widget> _buildButtonSection(
    String title,
    BuildContext context,
    UrlBuilder buildUrl,
  ) {
    final theme = Theme.of(context);

    return [
      const SizedBox(height: 32),
      Text(
        title,
        style: theme.textTheme.headline6,
      ),
      const SizedBox(height: 16),
      Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          ElevatedButton(
            child: const Text('*'),
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType)),
          ),
          ElevatedButton(
            child: const Text('language:dart'),
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    language: 'dart')),
          ),
          ElevatedButton(
            child: const Text('flutter/*'),
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'flutter')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/*'),
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'dart-lang')),
          ),
          ElevatedButton(
            child: const Text('flutter/codelabs'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'flutter', repo: 'codelabs')),
          ),
          ElevatedButton(
            child: const Text('flutter/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'flutter', repo: 'samples')),
          ),
          ElevatedButton(
            child: const Text('flutter/flutter'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'flutter', repo: 'flutter')),
          ),
          ElevatedButton(
            child: const Text('flutter/website'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'flutter', repo: 'website')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/dart-pad'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'dart-lang', repo: 'dart-pad')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/dart-services'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'dart-lang', repo: 'dart-services')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'dart-lang', repo: 'samples')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/sdk'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
                    user: 'dart-lang', repo: 'sdk')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/site-www'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(
                    _handleController.text, _startDate, _endDate, _sortType,
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
        title: const Text('GitHub Search Linker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your info',
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Enter a title...',
                  labelText: 'Your GitHub handle',
                ),
                controller: _handleController,
                onChanged: (value) => _saveHandle(value),
              ),
              const SizedBox(height: 16),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: IntrinsicColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Start date for perf:',
                          style: theme.textTheme.bodyText2?.makeBold(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(_format.format(_startDate)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.date_range),
                          ),
                          onPressed: () async {
                            final newDate = await showDatePicker(
                              context: context,
                              initialDate: _startDate,
                              firstDate: DateTime(2019, 1, 1),
                              lastDate: DateTime(2025, 1, 1),
                            );
                            setState(() => _startDate = newDate ?? _startDate);
                          },
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'End date for perf:',
                          style: theme.textTheme.bodyText2?.makeBold(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(_format.format(_endDate)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.date_range),
                          ),
                          onPressed: () async {
                            final newDate = await showDatePicker(
                              context: context,
                              initialDate: _endDate,
                              firstDate: DateTime(2019, 1, 1),
                              lastDate: DateTime(2025, 0, 1),
                            );
                            setState(() => _endDate = newDate ?? _endDate);
                          },
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sort by:',
                          style: theme.textTheme.bodyText2?.makeBold(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<SortType>(
                          items: const [
                            DropdownMenuItem(
                              value: SortType.newest,
                              child: Text('Newest'),
                            ),
                            DropdownMenuItem(
                              value: SortType.oldest,
                              child: Text('Oldest'),
                            ),
                            DropdownMenuItem(
                              value: SortType.mostCommented,
                              child: Text('Most Commented'),
                            ),
                            DropdownMenuItem(
                              value: SortType.leastCommented,
                              child: Text('Least Commented'),
                            ),
                            DropdownMenuItem(
                              value: SortType.mostRecentlyUpdated,
                              child: Text('Most recently updated'),
                            ),
                            DropdownMenuItem(
                              value: SortType.leastRecentlyUpdated,
                              child: Text('Least recently updated'),
                            ),
                          ],
                          value: _sortType,
                          onChanged: (val) => setState(() => _sortType = val!),
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  )
                ],
              ),
              ..._buildButtonSection(
                  'Pull requests merged', context, UrlMaker.pullsMerged),
              ..._buildButtonSection(
                  'Pull requests reviewed', context, UrlMaker.pullsReviewed),
              ..._buildButtonSection(
                  'Issues created', context, UrlMaker.issuesCreated),
              ..._buildButtonSection(
                  'Issues involved in', context, UrlMaker.issuesInvolved),
            ],
          ),
        ),
      ),
    );
  }
}

typedef UrlBuilder = String Function(
  String handle,
  DateTime start,
  DateTime end,
  SortType sortType, {
  String? language,
  String? user,
  String? repo,
});

class UrlMaker {
  static final _formatter = DateFormat('yyyy-MM-dd');
  static const _base = 'https://github.com';

  static String addCommonFilters(String url, SortType sortType,
      String? language, String? user, String? repo) {
    final sb = StringBuffer(url);

    switch (sortType) {
      case SortType.newest:
        sb.write('sort%3Acreated-desc+');
        break;
      case SortType.oldest:
        sb.write('sort%3Acreated-asc+');
        break;
      case SortType.mostCommented:
        sb.write('sort%3Acomments-desc+');
        break;
      case SortType.leastCommented:
        sb.write('sort%3Acomments-asc+');
        break;
      case SortType.mostRecentlyUpdated:
        sb.write('sort%3Aupdated-desc+');
        break;
      case SortType.leastRecentlyUpdated:
        sb.write('sort%3Aupdated-asc+');
        break;
    }

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
    DateTime end,
    SortType sortType, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/pulls?q=is%3Apr+author%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String pullsReviewed(
    String handle,
    DateTime start,
    DateTime end,
    SortType sortType, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/pulls?q=is%3Apr+reviewed-by%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String issuesCreated(
    String handle,
    DateTime start,
    DateTime end,
    SortType sortType, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/issues?q=is%3Aissue+author%3A$handle+'
        'created%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String issuesInvolved(
    String handle,
    DateTime start,
    DateTime end,
    SortType sortType, {
    String? language,
    String? user,
    String? repo,
  }) {
    var url = '$_base/issues?q=is%3Aissue+involves%3A$handle+'
        'updated%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, sortType, language, user, repo);
  }
}
