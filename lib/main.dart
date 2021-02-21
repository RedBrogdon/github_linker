import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      home: GitHubLinksScreen(),
    ),
  );
}

class GitHubLinksScreen extends StatefulWidget {
  @override
  _GitHubLinksScreenState createState() => _GitHubLinksScreenState();
}

extension BoldableTextStyle on TextStyle {
  TextStyle makeBold() {
    return this.copyWith(fontWeight: FontWeight.bold);
  }
}

class _GitHubLinksScreenState extends State<GitHubLinksScreen> {
  DateTime _startDate = DateTime(2020, 10, 1);
  DateTime _endDate = DateTime(2021, 3, 31);
  TextEditingController _handleController = TextEditingController();

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

  Future<void> _open(String url) async {
    if (await launcher.canLaunch(url)) {
      await launcher.launch(url);
    }
  }

  List<Widget> _buildButtonSection(
      String title, TextTheme textTheme, UrlBuilder buildUrl) {
    return [
      SizedBox(height: 32),
      Text(
        title,
        style: textTheme.headline6,
      ),
      SizedBox(height: 16),
      Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          ElevatedButton(
            child: Text('*'),
            onPressed: () =>
                _open(buildUrl(_handleController.text, _startDate, _endDate)),
          ),
          ElevatedButton(
            child: Text('language:dart'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                language: 'dart')),
          ),
          ElevatedButton(
            child: Text('flutter/*'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'flutter')),
          ),
          ElevatedButton(
            child: Text('dart-lang/*'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'dart-lang')),
          ),
          ElevatedButton(
            child: Text('flutter/codelabs'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'flutter', repo: 'codelabs')),
          ),
          ElevatedButton(
            child: Text('flutter/samples'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'flutter', repo: 'samples')),
          ),
          ElevatedButton(
            child: Text('flutter/website'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'flutter', repo: 'website')),
          ),
          ElevatedButton(
            child: Text('dart-lang/dart-pad'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'dart-lang', repo: 'dart-pad')),
          ),
          ElevatedButton(
            child: Text('dart-lang/dart-services'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'dart-lang', repo: 'dart-services')),
          ),
          ElevatedButton(
            child: Text('dart-lang/samples'),
            onPressed: () => _open(buildUrl(
                _handleController.text, _startDate, _endDate,
                user: 'dart-lang', repo: 'samples')),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub linkifier'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your info',
                style: textTheme.headline6,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter a title...',
                  labelText: 'Your GitHub handle',
                ),
                controller: _handleController,
                onChanged: (value) => _saveHandle(value),
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
                          style: textTheme.bodyText2?.makeBold(),
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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                          style: textTheme.bodyText2?.makeBold(),
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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                ],
              ),
              ..._buildButtonSection(
                  'Pull requests merged', textTheme, UrlMaker.pullsMerged),
              ..._buildButtonSection(
                  'Pull requests reviewed', textTheme, UrlMaker.pullsReviewed),
              ..._buildButtonSection(
                  'Issues created', textTheme, UrlMaker.issuesCreated),
              ..._buildButtonSection(
                  'Issues involved in', textTheme, UrlMaker.issuesInvolved),
            ],
          ),
        ),
      ),
    );
  }
}

typedef String UrlBuilder(
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

  static String pullsMerged(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    String url = '$_base/pulls?q=is%3Apr+author%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';

    if (user != null && repo != null) {
      url += 'repo%3A$user%2F$repo';
    } else if (user != null) {
      url += 'user%3A$user';
    }

    if (language != null) {
      url += 'language%3A$language+';
    }

    return url;
  }

  static String pullsReviewed(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    String url = '$_base/pulls?q=is%3Apr+reviewed-by%3A$handle+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';

    if (user != null && repo != null) {
      url += 'repo%3A$user%2F$repo';
    } else if (user != null) {
      url += 'user%3A$user';
    }

    if (language != null) {
      url += 'language%3A$language+';
    }

    return url;
  }

  static String issuesCreated(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    String url = '$_base/issues?q=is%3Aissue+author%3A$handle+'
        'created%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';

    if (user != null && repo != null) {
      url += 'repo%3A$user%2F$repo';
    } else if (user != null) {
      url += 'user%3A$user';
    }

    if (language != null) {
      url += 'language%3A$language+';
    }

    return url;
  }

  static String issuesInvolved(
    String handle,
    DateTime start,
    DateTime end, {
    String? language,
    String? user,
    String? repo,
  }) {
    String url = '$_base/issues?q=is%3Aissue+involves%3A$handle+'
        'updated%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';

    if (user != null && repo != null) {
      url += 'repo%3A$user%2F$repo';
    } else if (user != null) {
      url += 'user%3A$user';
    }

    if (language != null) {
      url += 'language%3A$language+';
    }

    return url;
  }
}
