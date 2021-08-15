import 'dart:math';
import 'package:intl/intl.dart';
import 'package:github_linker/app_state.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (index) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );

typedef UrlBuilder = String Function(
    String username,
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

  static String issuesCreated(
      String username,
      DateTime start,
      DateTime end,
      SortType sortType, {
        String? language,
        String? user,
        String? repo,
      }) {
    var url = '$_base/issues?q=is%3Aissue+author%3A$username+'
        'created%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String issuesInvolved(
      String username,
      DateTime start,
      DateTime end,
      SortType sortType, {
        String? language,
        String? user,
        String? repo,
      }) {
    var url = '$_base/issues?q=is%3Aissue+involves%3A$username+'
        'updated%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String pullsMerged(
      String username,
      DateTime start,
      DateTime end,
      SortType sortType, {
        String? language,
        String? user,
        String? repo,
      }) {
    var url = '$_base/pulls?q=is%3Apr+author%3A$username+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, sortType, language, user, repo);
  }

  static String pullsReviewed(
      String username,
      DateTime start,
      DateTime end,
      SortType sortType, {
        String? language,
        String? user,
        String? repo,
      }) {
    var url = '$_base/pulls?q=is%3Apr+reviewed-by%3A$username+'
        'merged%3A${_formatter.format(start)}..'
        '${_formatter.format(end)}+is%3Aclosed+';
    return addCommonFilters(url, sortType, language, user, repo);
  }
}
