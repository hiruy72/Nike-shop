import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/screens/onboarding_screen.dart';
import 'package:shop/services/onboarding_service.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  OnboardingService? _onboardingService;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final service = await OnboardingService.create();
    if (mounted) {
      setState(() => _onboardingService = service);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_onboardingService == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }

    if (_onboardingService!.isComplete) {
      return const HomeScreen();
    }

    return OnboardingScreen(onboardingService: _onboardingService!);
  }
}
