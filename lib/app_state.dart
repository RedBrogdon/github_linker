import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortType {
  newest,
  oldest,
  mostCommented,
  leastCommented,
  mostRecentlyUpdated,
  leastRecentlyUpdated,
}

class AppState extends ChangeNotifier {
  String _username = '';

  bool? _hasSeenPopup;

  SortType _sortType = SortType.newest;

  late DateTime _startDate;

  late DateTime _endDate;

  AppState() {
    SharedPreferences.getInstance().then((prefs) {
      _username = prefs.getString('username') ?? '';
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

  bool? get hasSeenPopup => _hasSeenPopup;

  String get username => _username;

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  SortType get sortType => _sortType;

  Future<void> setHasSeenPopup(bool val) async {
    _hasSeenPopup = val;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('hasSeenPopup', val);
    });
    notifyListeners();
  }

  Future<void> setUsername(String val) async {
    _username = val;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', val);
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

  Future<void> setEndDate(DateTime val) async {
    _endDate = val;
    notifyListeners();
  }
}
