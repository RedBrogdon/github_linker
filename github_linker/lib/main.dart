import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_linker/app_state.dart';
import 'package:github_linker/github.dart';
import 'package:github_linker/keys.dart';
import 'package:github_linker/styles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();

  print(Uri.base.toString());

  // This code determines if the app has loaded as the result of an OAuth2
  // callback from GitHub. If so, the access code is used to get an API token.
  if (Uri.base.toString().startsWith('http://localhost:8080/callback')) {
    appState.setGithubTokenRequestInProgress(true);
    final code = Uri.base.queryParameters['code']!;
    print(code);
    const requestUrl = 'https://github.com/login/oauth/access_token';
    final response = await http.post(
      Uri.parse(requestUrl),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'client_id': GithubKeys.clientId,
        'client_secret': GithubKeys.clientSecret,
        'code': code,
      }),
    );
    print(response.statusCode);
    print(response.body);
  }

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const MaterialApp(
        title: 'GitHub search linker',
        home: GitHubLinksScreen(),
      ),
    ),
  );
}

class AlertPopup extends StatelessWidget {
  final String title;
  final String message;

  const AlertPopup({
    this.title = '',
    this.message = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: [
        TextButton(
          child: const Text('Got it'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class GitHubLinksScreen extends StatefulWidget {
  const GitHubLinksScreen({Key? key}) : super(key: key);

  @override
  _GitHubLinksScreenState createState() => _GitHubLinksScreenState();
}

class _GitHubLinksScreenState extends State<GitHubLinksScreen> {
  static final _format = DateFormat.yMMMd();

  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = Provider.of<AppState>(context);

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
              Align(
                alignment: Alignment.centerRight,
                child: Consumer<AppState>(
                  builder: (context, state, child) {
                    if (state.githubApiKey != null) {
                      return const Text('Signed in!');
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 8, 6),
                              child: Icon(FontAwesomeIcons.github),
                            ),
                            Text('Sign in'),
                          ],
                        ),
                        onPressed: () => _launchOAuth(),
                      );
                    }
                  },
                ),
              ),
              Text(
                'Your info',
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Enter a title...',
                  labelText: 'Your GitHub username',
                ),
                controller: _usernameController,
                onChanged: (value) {
                  appState.setUsername(value);
                },
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
                          child: Text(_format.format(appState.startDate)),
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
                              initialDate: appState.startDate,
                              firstDate: DateTime(2019, 1, 1),
                              lastDate: DateTime(2025, 1, 1),
                            );
                            if (newDate != null) {
                              appState.setStartDate(newDate);
                            }
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
                          child: Text(_format.format(appState.endDate)),
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
                              initialDate: appState.endDate,
                              firstDate: DateTime(2019, 1, 1),
                              lastDate: DateTime(2025, 0, 1),
                            );
                            if (newDate != null) {
                              appState.setEndDate(newDate);
                            }
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
                          value: appState.sortType,
                          onChanged: (val) {
                            if (val != null) {
                              appState.setSortType(val);
                            }
                          },
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  )
                ],
              ),
              ..._buildButtonSection(
                'Pull requests merged',
                appState.startDate,
                appState.endDate,
                appState.sortType,
                context,
                UrlMaker.pullsMerged,
              ),
              ..._buildButtonSection(
                'Pull requests reviewed',
                appState.startDate,
                appState.endDate,
                appState.sortType,
                context,
                UrlMaker.pullsReviewed,
              ),
              ..._buildButtonSection(
                'Issues created',
                appState.startDate,
                appState.endDate,
                appState.sortType,
                context,
                UrlMaker.issuesCreated,
              ),
              ..._buildButtonSection(
                'Issues involved in',
                appState.startDate,
                appState.endDate,
                appState.sortType,
                context,
                UrlMaker.issuesInvolved,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context);

    if (_usernameController.text != appState.username) {
      _usernameController.text = appState.username;
    }

    if (appState.hasSeenPopup == false) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AlertPopup(
              title: 'A word about GitHub',
              message: 'The search API used by this tool requires that you '
                  'be logged into GitHub. If you\'re not, you\'ll see a 404 '
                  'page instead of proper search results.',
            );
          },
        ).then((result) {
          appState.setHasSeenPopup(true);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildButtonSection(
    String title,
    DateTime startDate,
    DateTime endDate,
    SortType sortType,
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
                    _usernameController.text, startDate, endDate, sortType)),
          ),
          ElevatedButton(
            child: const Text('language:dart'),
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    language: 'dart')),
          ),
          ElevatedButton(
            child: const Text('flutter/*'),
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'flutter')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/*'),
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang')),
          ),
          ElevatedButton(
            child: const Text('flutter/codelabs'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'flutter', repo: 'codelabs')),
          ),
          ElevatedButton(
            child: const Text('flutter/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'flutter', repo: 'samples')),
          ),
          ElevatedButton(
            child: const Text('flutter/flutter'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'flutter', repo: 'flutter')),
          ),
          ElevatedButton(
            child: const Text('flutter/website'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'flutter', repo: 'website')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/dart-pad'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang', repo: 'dart-pad')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/dart-services'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang', repo: 'dart-services')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/samples'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang', repo: 'samples')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/sdk'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang', repo: 'sdk')),
          ),
          ElevatedButton(
            child: const Text('dart-lang/site-www'),
            onPressed: () => _checkAndOpen(
                context,
                buildUrl(_usernameController.text, startDate, endDate, sortType,
                    user: 'dart-lang', repo: 'site-www')),
          ),
        ],
      ),
    ];
  }

  Future<void> _checkAndOpen(BuildContext context, String url) async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You need to enter a username first!'),
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

  Future<void> _launchOAuth() async {
    final url = 'https://github.com/login/oauth/authorize?'
        'client_id=${GithubKeys.clientId}'
        '&redirect_uri=${Uri.encodeComponent('http://localhost:55827/')}'
        '&state=${getRandomString(20)}';

    if (await launcher.canLaunch(url)) {
      launcher.launch(url);
    }
  }
}
