import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_localizations_ext.dart';
import '../../generated/l10n.dart';

/// Onboarding con tres páginas de información antifraude.
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int counterIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return OnboardingTemplate(
      onGoBack: () {},
      onClose: () => context.pop(),
      getIndex: (value) {
        setState(() {
          counterIndex = value;
        });
      },
      counterIndex: counterIndex,
      pageController: _pageController,
      pages: [
        onboardingPage(context: context, pageController: _pageController, localizations: localizations),
        onboardingSecondPage(context: context, pageController: _pageController, localizations: localizations),
        onboardingFinalPage(context: context, pageController: _pageController, localizations: localizations),
      ],
    );
  }
}

/// Primera página del onboarding antifraude.
OnboardingPage onboardingPage({required BuildContext context, required PageController pageController, required S localizations}) {
  return OnboardingPage(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.newUser, isIllustration: true, illustrationSize: IllustrationSize.standardMedium),
    pageController: pageController,
    iconPath: BacIcons.ionIconPerson,
    title: localizations.onboardingPage1Title,
    child: Column(
      children: [
        Caption(localizations.onboardingPage1Desc1, textAlign: TextAlign.center),
        Spacing.medium16,
        Caption(localizations.onboardingPage1Desc2, textAlign: TextAlign.center),
      ],
    ),
  );
}

/// Segunda página del onboarding antifraude.
OnboardingPage onboardingSecondPage({required BuildContext context, required PageController pageController, required S localizations}) {
  return OnboardingPage(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.codeSms, isIllustration: true, illustrationSize: IllustrationSize.standardMedium),
    pageController: pageController,
    iconPath: BacIcons.messageCircle,
    title: localizations.onboardingPage2Title,
    linkText: localizations.onboardingPage2Link,
    child: Column(
      children: [
        Caption(localizations.onboardingPage2Desc1, textAlign: TextAlign.center),
        Spacing.medium16,
        Caption(localizations.onboardingPage2Desc2, textAlign: TextAlign.center),
      ],
    ),
  );
}

/// Última página del onboarding antifraude.
OnboardingPage onboardingFinalPage({required BuildContext context, required PageController pageController, required S localizations}) {
  return OnboardingPage.finalStep(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.userInfo, isIllustration: true, illustrationSize: IllustrationSize.standardLarge),
    pageController: pageController,
    iconPath: BacIcons.mailOpened,
    title: localizations.onboardingPage3Title,
    primaryActionTap: () => context.pushNamed('Home'),
    primaryActionText: localizations.onboardingAcceptButton,
    linkText: localizations.onboardingMoreInfoLink,
    child: Column(
      children: [
        Caption(localizations.onboardingPage3Desc1, textAlign: TextAlign.center),
        Spacing.medium16,
        Caption(localizations.onboardingPage3Desc2, textAlign: TextAlign.center),
      ],
    ),
  );
}
