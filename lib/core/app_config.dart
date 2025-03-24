import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { prod ,staging ,dev}

class AppConfig {

  static const AppFlavor dev = AppFlavor.dev;
  static const AppFlavor staging = AppFlavor.staging;
  static const AppFlavor prod = AppFlavor.prod;

  static AppFlavor _environment = dev;
  static AppFlavor get environment => _environment;

  static Future<void> initializeEnvironment(AppFlavor env) async {
    _environment = env;

    String fileName;
    switch (env) {
      case dev:
        fileName = 'lib/env/.env.dev';
        break;
      case staging:
        fileName = 'lib/env/.env.staging';
        break;
      case prod:
        fileName = 'lib/env/.env';
        break;
      default:
        fileName = 'lib/env/.env.dev';
    }

    await dotenv.load(fileName: fileName);
  }


  static String? getEnvironmentValue(String key) {
    return dotenv.env[key];
  }

  static bool get isDev => _environment == dev;

  static bool get isStaging => _environment == staging;

  static bool get isProd => _environment == prod;
}