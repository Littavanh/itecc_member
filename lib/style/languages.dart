import 'package:get/get.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'ເຂົ້າສູ່ລະບົບ': 'Login',
        },
        'lo': {
          'ເຂົ້າສູ່ລະບົບ': 'ເຂົ້າສູ່ລະບົບ',
        },
      };
}
class Language {
  final int id;
  final String name;
  final String flag;

  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', 'assets/images/usa2.png', 'en'),
      Language(2, 'Lao', 'assets/images/lao3.jpg', 'lo'),
    ];
  }
}

