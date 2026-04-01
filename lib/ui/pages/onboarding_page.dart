import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onboardingPage(context: context, pageController: _pageController),
        onboardingSecondPage(context: context, pageController: _pageController),
        onboardingFinalPage(context: context, pageController: _pageController),
      ],
    );
  }
}

/// Primera página del onboarding antifraude.
OnboardingPage onboardingPage({required BuildContext context, required PageController pageController}) {
  return OnboardingPage(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.newUser, isIllustration: true, illustrationSize: IllustrationSize.standardMedium),
    pageController: pageController,
    iconPath: BacIcons.ionIconPerson,
    title: 'Verifica siempre el destinatario',
    child: const Column(
      children: [
        Caption(
          'Antes de realizar una transferencia, asegúrate de que el número de cuenta y el nombre del destinatario sean correctos.',
          textAlign: TextAlign.center,
        ),
        Spacing.medium16,
        Caption('No compartas tus datos bancarios con desconocidos.', textAlign: TextAlign.center),
      ],
    ),
  );
}

/// Segunda página del onboarding antifraude.
OnboardingPage onboardingSecondPage({required BuildContext context, required PageController pageController}) {
  return OnboardingPage(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.codeSms, isIllustration: true, illustrationSize: IllustrationSize.standardMedium),
    pageController: pageController,
    iconPath: BacIcons.messageCircle,
    title: 'Desconfía de mensajes sospechosos',
    linkText: '¿Cómo identificar fraudes?',
    child: const Column(
      children: [
        Caption('No respondas a correos, llamadas o mensajes que soliciten información personal o códigos de verificación. ', textAlign: TextAlign.center),
        Spacing.medium16,
        Caption('Los bancos nunca piden estos datos por estos medios.', textAlign: TextAlign.center),
      ],
    ),
  );
}

/// Última página del onboarding antifraude.
OnboardingPage onboardingFinalPage({required BuildContext context, required PageController pageController}) {
  return OnboardingPage.finalStep(
    illustration: const BacSvgIcon(assetIcon: BacIllustrations.userInfo, isIllustration: true, illustrationSize: IllustrationSize.standardLarge),
    pageController: pageController,
    iconPath: BacIcons.mailOpened,
    title: 'Utiliza canales oficiales',
    primaryActionTap: () => context.pushNamed('Home'),
    primaryActionText: 'Aceptar',
    linkText: 'Más información',
    child: const Column(
      children: [
        Caption('Realiza tus transacciones únicamente desde la app o web oficial de tu banco.', textAlign: TextAlign.center),
        Spacing.medium16,
        Caption('Evita acceder a enlaces enviados por terceros.', textAlign: TextAlign.center),
      ],
    ),
  );
}
