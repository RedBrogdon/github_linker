import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'theme.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'GitHub search linker',
      home: GitHubLinksScreen(),
      theme: ThemeData(colorScheme: CustomMaterialTheme.lightScheme()),
    ),
  );
}

class GitHubLinksScreen extends StatefulWidget {
  const GitHubLinksScreen({super.key});

  @override
  GitHubLinksScreenState createState() => GitHubLinksScreenState();
}

extension BoldableTextStyle on TextStyle {
  TextStyle makeBold() {
    return copyWith(fontWeight: FontWeight.bold);
  }
}

class GitHubLinksScreenState extends State<GitHubLinksScreen> {
  DateTime _startDate = DateTime(2020, 10, 1);
  DateTime _endDate = DateTime(2021, 3, 31);
  final TextEditingController _handleController = TextEditingController();

  static final _format = DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      final handle = prefs.getString('handle') ?? '';
      _handleController.text = handle;
    });
  }

  Future<void> _saveHandle(String handle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('handle', handle);
  }

  Future<void> _checkAndOpen(BuildContext context, String url) async {
    if (_handleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You need to enter a handle first!'),
      ));
    } else {
      if (await launcher.canLaunchUrl(Uri.parse(url))) {
        await launcher.launchUrl(Uri.parse(url));
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Could not open link! :('),
          ));
        }
      }
    }
  }

  List<Widget> _buildButtonSection(
      String title, BuildContext context, UrlBuilder buildUrl) {
    final theme = Theme.of(context);

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
            onPressed: () => _checkAndOpen(context,
                buildUrl(_handleController.text, _startDate, _endDate)),
            child: Text('*'),
          ),
          FilledButton(
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter')),
            child: Text('flutter/*'),
          ),
          FilledButton(
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'dart-lang')),
            child: Text('dart-lang/*'),
          ),
          OutlinedButton(
            child: Text('flutter/codelabs'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter', repo: 'codelabs')),
          ),
          OutlinedButton(
            child: Text('flutter/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter', repo: 'samples')),
          ),
          OutlinedButton(
            child: Text('flutter/flutter'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter', repo: 'flutter')),
          ),
          OutlinedButton(
            child: Text('flutter/games'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter', repo: 'games')),
          ),
          OutlinedButton(
            child: Text('flutter/website'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'flutter', repo: 'website')),
          ),
          OutlinedButton(
            child: Text('dart-lang/dart-pad'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'dart-lang', repo: 'dart-pad')),
          ),
          OutlinedButton(
            child: Text('dart-lang/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'dart-lang', repo: 'samples')),
          ),
          OutlinedButton(
            child: Text('dart-lang/sdk'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
                    user: 'dart-lang', repo: 'sdk')),
          ),
          OutlinedButton(
            child: Text('dart-lang/site-www'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_handleController.text, _startDate, _endDate,
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
            child: Column(
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
                    onChanged: (value) => _saveHandle(value),
                  ),
                ),
                SizedBox(height: 16),
                Table(
                  columnWidths: {
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
                            style: theme.textTheme.bodyMedium?.makeBold(),
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
                          child: FilledButton(
                            child: Icon(Icons.date_range),
                            onPressed: () async {
                              final newDate = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(2019, 1, 1),
                                lastDate: DateTime(2025, 1, 1),
                              );
                              setState(
                                  () => _startDate = newDate ?? _startDate);
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
                            style: theme.textTheme.bodyMedium?.makeBold(),
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
                          child: FilledButton(
                            child: Icon(Icons.date_range),
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
