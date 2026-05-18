import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  OnboardingService(this._prefs);

  static const _key = 'onboarding_complete';

  final SharedPreferences _prefs;

  static Future<OnboardingService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return OnboardingService(prefs);
  }

  bool get isComplete => _prefs.getBool(_key) ?? false;

  Future<void> setComplete() => _prefs.setBool(_key, true);
}
