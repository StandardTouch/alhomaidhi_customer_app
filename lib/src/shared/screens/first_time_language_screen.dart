import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/brands_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/language_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FirstTimeLanguageScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FirstTimeLanguageScreen> createState() =>
      _FirstTimeLanguageScreenState();
}

class _FirstTimeLanguageScreenState
    extends ConsumerState<FirstTimeLanguageScreen> {
  bool isLoading = false;
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(languageProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/alhomaidhi.png"),
              const Gap(20),
              Text(
                TranslationHelper.translation(context)!.welcomeToAlhomaidhi,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(10),
              Text(
                TranslationHelper.translation(context)!
                    .pleaseSelectYourPreferredLanguage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isArabic
                        ? Colors.blueGrey
                        : Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    ref.read(languageProvider.notifier).toggleLanguage(false);
                  },
                  child: Text(TranslationHelper.translation(context)!.english),
                ),
              ),
              const Gap(10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isArabic
                        ? Theme.of(context).colorScheme.onSecondary
                        : Colors.blueGrey,
                  ),
                  onPressed: () {
                    ref.read(languageProvider.notifier).toggleLanguage(true);
                  },
                  child: Text(TranslationHelper.translation(context)!.arabic),
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: () async {
          try {
            setState(() {
              isLoading = true;
            });
            await ref.watch(allProductsProvider.future);
            await ref.watch(brandsProvider.future);
            if (!context.mounted) {
              return;
            }
            context.go("/home");
          } catch (_) {
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                TranslationHelper.translation(context)!.done,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }
}
