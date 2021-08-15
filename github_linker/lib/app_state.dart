import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _username = '';

  bool? _hasSeenPopup;

  SortType _sortType = SortType.newest;

  late DateTime _startDate;

  late DateTime _endDate;

  String? _githubApiKey;

  bool _githubTokenRequestInProgress = false;

  AppState() {
    SharedPreferences.getInstance().then((prefs) {
      _username = prefs.getString('username') ?? '';
      _githubApiKey = prefs.getString('githubApiKey');
      _hasSeenPopup = prefs.getBool('hasSeenPopup') ?? false;
      final sortTypeIndex = prefs.getInt('sortType') ?? 0;
      sortTypeIndex.clamp(0, SortType.values.length - 1);
      _sortType = SortType.values[sortTypeIndex];
      notifyListeners();
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

  DateTime get endDate => _endDate;

  String? get githubApiKey => _githubApiKey;

  bool get githubTokenRequestInProgress => _githubTokenRequestInProgress;

  bool? get hasSeenPopup => _hasSeenPopup;

  SortType get sortType => _sortType;

  DateTime get startDate => _startDate;

  String get username => _username;

  Future<void> setEndDate(DateTime val) async {
    _endDate = val;
    notifyListeners();
  }

  Future<void> setGithubApiKey(String? val) async {
    _githubApiKey = val;
    SharedPreferences.getInstance().then((prefs) {
      if (val == null) {
        prefs.remove('githubApiKey');
      } else {
        prefs.setString('githubApiKey', val);
      }
    });
    notifyListeners();
  }

  Future<void> setGithubTokenRequestInProgress(bool val) async {
    _githubTokenRequestInProgress = val;
    notifyListeners();
  }

  Future<void> setHasSeenPopup(bool val) async {
    _hasSeenPopup = val;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('hasSeenPopup', val);
    });
    notifyListeners();
  }

  Future<void> setSortType(SortType val) async {
    _sortType = val;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('sortType', val.index);
    });
    notifyListeners();
  }

  Future<void> setStartDate(DateTime val) async {
    _startDate = val;
    notifyListeners();
  }

  Future<void> setUsername(String val) async {
    _username = val;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', val);
    });
    notifyListeners();
  }
}

enum SortType {
  newest,
  oldest,
  mostCommented,
  leastCommented,
  mostRecentlyUpdated,
  leastRecentlyUpdated,
}
