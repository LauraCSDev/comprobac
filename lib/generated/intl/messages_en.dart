// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(reference) => "Reference: ${reference}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Comprobac"),
        "april": MessageLookupByLibrary.simpleMessage("April"),
        "august": MessageLookupByLibrary.simpleMessage("August"),
        "bacCodeLabel": MessageLookupByLibrary.simpleMessage(
          "Enter your 6-digit BAC code",
        ),
        "bacCodeLoginError": MessageLookupByLibrary.simpleMessage(
          "Login failed. Verify your BAC code.",
        ),
        "bacCodeOnlyNumbersError": MessageLookupByLibrary.simpleMessage(
          "BAC code must contain only numbers",
        ),
        "bacCodeSixDigitsError": MessageLookupByLibrary.simpleMessage(
          "BAC code must have 6 digits",
        ),
        "bacCodeTitle": MessageLookupByLibrary.simpleMessage("BAC Code"),
        "december": MessageLookupByLibrary.simpleMessage("December"),
        "february": MessageLookupByLibrary.simpleMessage("February"),
        "fieldRequired": MessageLookupByLibrary.simpleMessage(
          "This field is required",
        ),
        "homeHistoryTitle": MessageLookupByLibrary.simpleMessage(
          "Validation history",
        ),
        "homeMenuServices": MessageLookupByLibrary.simpleMessage("Services"),
        "homeMenuValidate": MessageLookupByLibrary.simpleMessage(
          "Validate transaction",
        ),
        "homeNoTransactions": MessageLookupByLibrary.simpleMessage(
          "No transactions.",
        ),
        "homeReference": m0,
        "homeWelcome": MessageLookupByLibrary.simpleMessage("Welcome!"),
        "january": MessageLookupByLibrary.simpleMessage("January"),
        "july": MessageLookupByLibrary.simpleMessage("July"),
        "june": MessageLookupByLibrary.simpleMessage("June"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Sign In"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "march": MessageLookupByLibrary.simpleMessage("March"),
        "may": MessageLookupByLibrary.simpleMessage("May"),
        "november": MessageLookupByLibrary.simpleMessage("November"),
        "october": MessageLookupByLibrary.simpleMessage("October"),
        "onboardingDesc1": MessageLookupByLibrary.simpleMessage(
          "Never share your bank details with strangers.",
        ),
        "onboardingDesc2": MessageLookupByLibrary.simpleMessage(
          "Make sure to validate the receipt before accepting a transfer.",
        ),
        "onboardingDesc3": MessageLookupByLibrary.simpleMessage(
          "If you detect anything unusual, report it to your bank immediately.",
        ),
        "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
          "Avoid bank fraud",
        ),
        "onboardingTitle2": MessageLookupByLibrary.simpleMessage(
          "Verify references",
        ),
        "onboardingTitle3": MessageLookupByLibrary.simpleMessage(
          "Report suspicious activity",
        ),
        "september": MessageLookupByLibrary.simpleMessage("September"),
        "validationFormAccount": MessageLookupByLibrary.simpleMessage(
          "Account Number to Credit",
        ),
        "validationFormButton": MessageLookupByLibrary.simpleMessage("Validate"),
        "validationFormMonth": MessageLookupByLibrary.simpleMessage("Select Month"),
        "validationFormReference": MessageLookupByLibrary.simpleMessage(
          "Receipt Number",
        ),
        "validationFormTitle": MessageLookupByLibrary.simpleMessage(
          "Validate Receipt",
        ),
        "validationResultInvalid": MessageLookupByLibrary.simpleMessage(
          "Invalid receipt",
        ),
        "validationResultValid": MessageLookupByLibrary.simpleMessage(
          "Valid receipt",
        ),
        "sinpeMovilLabel": MessageLookupByLibrary.simpleMessage(
          "Is SINPE Móvil",
        ),
        "validationFormDay": MessageLookupByLibrary.simpleMessage(
          "Select Day",
        ),
        "sinpeMovilDateInvalid": MessageLookupByLibrary.simpleMessage(
          "The first 8 digits of the receipt do not match the selected date",
        ),
        "sinpeMovilValid": MessageLookupByLibrary.simpleMessage(
          "Valid SINPE Móvil receipt: date matches",
        ),
        "sinpeMovilEntityCode": MessageLookupByLibrary.simpleMessage(
          "Financial entity code",
        ),
        "sinpeMovilMinDigits": MessageLookupByLibrary.simpleMessage(
          "SINPE Móvil receipt must have at least 11 digits",
        ),
      };
}
