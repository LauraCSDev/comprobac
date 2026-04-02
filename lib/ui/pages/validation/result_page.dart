import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app_localizations_ext.dart';
import '../../../providers/providers.dart';
import '../../widgets/widgets.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = context.localizations;
    final sinpeResult = ref.watch(sinpeMovilResultProvider);

    // Resultado SINPE Móvil
    if (sinpeResult != null) {
      final isValid = sinpeResult.isValid;
      return FullScreenTemplate(
        title: localizations.validationFormTitle,
        hasHorizontalPaddings: false,
        content: Padding(
          padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VisualInformation(
                illustration: isValid ? BacIllustrations.verifyNumber : BacIllustrations.errorResponseState,
                title: isValid ? localizations.sinpeMovilValid : sinpeResult.errorMessage,
              ),
              if (isValid) LineDetail(label: '${localizations.sinpeMovilEntityCode}:', description: sinpeResult.entityCode),
            ],
          ),
        ),
        primaryButton: BacPrimaryButton(text: localizations.goBack, onPressed: () => context.go('/home')),
      );
    }

    final transaction = ref.watch(selectedTransactionProvider);
    if (transaction != null) {
      return FullScreenTemplate(
        title: localizations.validationResultTitle,
        hasHorizontalPaddings: false,
        content: Padding(
          padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VisualInformation(illustration: BacIllustrations.verifyNumber, title: localizations.validationResultValid),
              LineDetail(label: localizations.labelReference, description: transaction.reference),
              LineDetail(label: localizations.labelAccountNumber, description: transaction.accountNumber),
              LineDetail(label: localizations.labelDate, description: transaction.date),
              LineDetail(
                label: localizations.labelAmount,
                amountTile: AmountTile(amount: transaction.amount, currency: CurrencyIsoDs.findCurrencyByIso(transaction.currency)),
              ),
              LineDetail(label: localizations.labelBeneficiary, description: transaction.beneficiaryName),
            ],
          ),
        ),
        primaryButton: BacPrimaryButton(text: localizations.goBack, onPressed: () => context.go('/home')),
      );
    }

    // No se encontró la transacción
    return FullScreenTemplate(
      title: localizations.validationResultTitle,
      hasHorizontalPaddings: false,
      content: Padding(
        padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
        child: VisualInformation(illustration: BacIllustrations.errorResponseState, title: localizations.validationResultNotFound),
      ),
      primaryButton: BacPrimaryButton(text: localizations.goBack, onPressed: () => context.go('/home')),
    );
  }
}
