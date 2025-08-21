// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Validation history`
  String get homeHistoryTitle {
    return Intl.message(
      'Validation history',
      name: 'homeHistoryTitle',
      desc: 'Title for the validation history section on the home page',
      args: [],
    );
  }

  /// `No transactions.`
  String get homeNoTransactions {
    return Intl.message(
      'No transactions.',
      name: 'homeNoTransactions',
      desc: 'Message when there are no transactions in the list',
      args: [],
    );
  }

  /// `Reference: {reference}`
  String homeReference(String reference) {
    return Intl.message(
      'Reference: $reference',
      name: 'homeReference',
      desc:
          'Label for transaction reference in the list, with variable {reference}',
      args: [reference],
    );
  }

  /// `Comprobac`
  String get appTitle {
    return Intl.message(
      'Comprobac',
      name: 'appTitle',
      desc: 'App title',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      desc: 'Login page title',
      args: [],
    );
  }

  /// `Sign In`
  String get loginButton {
    return Intl.message(
      'Sign In',
      name: 'loginButton',
      desc: 'Login button text',
      args: [],
    );
  }

  /// `Avoid bank fraud`
  String get onboardingTitle1 {
    return Intl.message(
      'Avoid bank fraud',
      name: 'onboardingTitle1',
      desc: 'Onboarding page 1 title',
      args: [],
    );
  }

  /// `Never share your bank details with strangers.`
  String get onboardingDesc1 {
    return Intl.message(
      'Never share your bank details with strangers.',
      name: 'onboardingDesc1',
      desc: 'Onboarding page 1 description',
      args: [],
    );
  }

  /// `Verify references`
  String get onboardingTitle2 {
    return Intl.message(
      'Verify references',
      name: 'onboardingTitle2',
      desc: 'Onboarding page 2 title',
      args: [],
    );
  }

  /// `Make sure to validate the receipt before accepting a transfer.`
  String get onboardingDesc2 {
    return Intl.message(
      'Make sure to validate the receipt before accepting a transfer.',
      name: 'onboardingDesc2',
      desc: 'Onboarding page 2 description',
      args: [],
    );
  }

  /// `Report suspicious activity`
  String get onboardingTitle3 {
    return Intl.message(
      'Report suspicious activity',
      name: 'onboardingTitle3',
      desc: 'Onboarding page 3 title',
      args: [],
    );
  }

  /// `If you detect anything unusual, report it to your bank immediately.`
  String get onboardingDesc3 {
    return Intl.message(
      'If you detect anything unusual, report it to your bank immediately.',
      name: 'onboardingDesc3',
      desc: 'Onboarding page 3 description',
      args: [],
    );
  }

  /// `Validate transaction`
  String get homeMenuValidate {
    return Intl.message(
      'Validate transaction',
      name: 'homeMenuValidate',
      desc: 'Home menu validate transaction option',
      args: [],
    );
  }

  /// `Validate Receipt`
  String get validationFormTitle {
    return Intl.message(
      'Validate Receipt',
      name: 'validationFormTitle',
      desc: 'Validation form title',
      args: [],
    );
  }

  /// `Receipt Number`
  String get validationFormReference {
    return Intl.message(
      'Receipt Number',
      name: 'validationFormReference',
      desc: 'Validation form reference number label',
      args: [],
    );
  }

  /// `Account Number to Credit`
  String get validationFormAccount {
    return Intl.message(
      'Account Number to Credit',
      name: 'validationFormAccount',
      desc: 'Validation form account number label',
      args: [],
    );
  }

  /// `Select Month`
  String get validationFormMonth {
    return Intl.message(
      'Select Month',
      name: 'validationFormMonth',
      desc: 'Validation form select month label',
      args: [],
    );
  }

  /// `Validate`
  String get validationFormButton {
    return Intl.message(
      'Validate',
      name: 'validationFormButton',
      desc: 'Validation form button text',
      args: [],
    );
  }

  /// `Valid receipt`
  String get validationResultValid {
    return Intl.message(
      'Valid receipt',
      name: 'validationResultValid',
      desc: 'Validation result valid message',
      args: [],
    );
  }

  /// `Invalid receipt`
  String get validationResultInvalid {
    return Intl.message(
      'Invalid receipt',
      name: 'validationResultInvalid',
      desc: 'Validation result invalid message',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Logout button text',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: 'Month January',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: 'Month February',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message('March', name: 'march', desc: 'Month March', args: []);
  }

  /// `April`
  String get april {
    return Intl.message('April', name: 'april', desc: 'Month April', args: []);
  }

  /// `May`
  String get may {
    return Intl.message('May', name: 'may', desc: 'Month May', args: []);
  }

  /// `June`
  String get june {
    return Intl.message('June', name: 'june', desc: 'Month June', args: []);
  }

  /// `July`
  String get july {
    return Intl.message('July', name: 'july', desc: 'Month July', args: []);
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: 'Month August',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: 'Month September',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: 'Month October',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: 'Month November',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: 'Month December',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: 'Field required validation message',
      args: [],
    );
  }

  /// `Welcome!`
  String get homeWelcome {
    return Intl.message(
      'Welcome!',
      name: 'homeWelcome',
      desc: 'Welcome message on the home page',
      args: [],
    );
  }

  /// `Services`
  String get homeMenuServices {
    return Intl.message(
      'Services',
      name: 'homeMenuServices',
      desc: 'Menu option for services on the home page',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
