import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:encrypt/encrypt.dart';

final box = GetStorage();

// secure-random
// D58wKnwDfgp06OdWleUhEzYz9AMt8yMLAWaRVrJjITg
class AutoLogin {
  static String tokenKeyKey = "tokenKey";
  static String rememberMeKey = "rememberMe";

  String tokenKey;
  bool rememberMe;
  AutoLogin({
    required this.tokenKey,
    required this.rememberMe,
  });

  Future setUser() async {
    print(tokenKey);

    print(rememberMe);
    await box.write(tokenKeyKey,  tokenKey);
    await box.write(rememberMeKey, rememberMe);
  }

  static AutoLogin getUser() {

    return AutoLogin(
        tokenKey: box.read(tokenKeyKey) ?? '',
        rememberMe: box.read(rememberMeKey) ?? false);
  }

//Todo: encrypter and decrypter password
  static final key = Key.fromLength(32);
  static final iv = IV.fromLength(8);
  static final encrypter = Encrypter(Salsa20(key));

  static String encryptPassword({required String plainText}) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptPassword({required String encryptText}) {
    final decrypted = encrypter.decrypt64(encryptText, iv: iv);
    return decrypted;
  }
}
