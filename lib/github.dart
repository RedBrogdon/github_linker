import 'dart:math';

const clientId = '9363563ad96b15ac61b8';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (index) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
