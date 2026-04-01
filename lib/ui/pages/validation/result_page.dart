import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:comprobac/ui/widgets/full_screen_template.dart';
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
        header: Header(
          title: localizations.validationFormTitle,
          color: HeaderColor.white,
        ),
        hasHorizontalPaddings: false,
        content: Padding(
          padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VisualInformation(
                illustration: isValid ? BacIllustrations.verifyNumber : BacIllustrations.errorResponseState,
                title: isValid ? localizations.sinpeMovilValid : localizations.sinpeMovilDateInvalid,
              ),
              if (isValid)
                LineDetail(
                  label: '${localizations.sinpeMovilEntityCode}:',
                  description: sinpeResult.entityCode,
                ),
            ],
          ),
        ),
        primaryButton: BacPrimaryButton(
          text: 'Volver',
          onPressed: () => context.pushNamed('Home'),
        ),
      );
    }

    final transaction = ref.watch(selectedTransactionProvider);
    if (transaction != null) {
      return FullScreenTemplate(
        header: const Header(
          title: 'Resultado de Validación',
          color: HeaderColor.white,
        ),
        hasHorizontalPaddings: false,
        content: Padding(
          padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VisualInformation(
                illustration: BacIllustrations.verifyNumber,
                title: 'Comprobante válido',
              ),
              LineDetail(
                label: 'Referencia:',
                description: transaction.reference,
              ),
              LineDetail(
                label: 'Número de cuenta:',
                description: transaction.accountNumber,
              ),
              LineDetail(
                label: 'Fecha:',
                description: transaction.date,
              ),
              LineDetail(
                label: 'Monto:',
                amountTile: AmountTile(
                  amount: transaction.amount,
                  currency: CurrencyIsoDs.findCurrencyByIso(transaction.currency),
                ),
              ),
              LineDetail(
                label: 'Beneficiario:',
                description: transaction.beneficiaryName,
              ),
            ],
          ),
        ),
        primaryButton: BacPrimaryButton(
          text: 'Volver',
          onPressed: () => context.pushNamed('Home'),
        ),
      );
    } else {
      // Modo Riverpod: obtener el resultado desde el provider
      return _ValidationResultFromProvider();
    }
  }
}

class _ValidationResultFromProvider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync = ref.watch(transactionDetailProvider);
    return transactionAsync.when(
      data: (transaction) {
        final isValid = transaction != null;
        return FullScreenTemplate(
          header: const Header(
            title: 'Resultado de Validación',
            color: HeaderColor.white,
          ),
          hasHorizontalPaddings: false,
          content: Padding(
            padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VisualInformation(
                  illustration: isValid ? BacIllustrations.verifyNumber : BacIllustrations.errorResponseState,
                  title: isValid ? 'Comprobante válido' : 'Comprobante no encontrado o inválido',
                ),
                if (isValid) ...[
                  LineDetail(
                    label: 'Referencia:',
                    description: transaction.reference,
                  ),
                  LineDetail(
                    label: 'Número de cuenta:',
                    description: transaction.accountNumber,
                  ),
                  LineDetail(
                    label: 'Fecha:',
                    description: transaction.date,
                  ),
                  LineDetail(
                    label: 'Monto:',
                    amountTile: AmountTile(
                      amount: transaction.amount,
                      currency: CurrencyIsoDs.findCurrencyByIso(transaction.currency),
                    ),
                  ),
                  LineDetail(
                    label: 'Beneficiario:',
                    description: transaction.beneficiaryName,
                  ),
                ],
              ],
            ),
          ),
          primaryButton: BacPrimaryButton(
            text: 'Volver',
            onPressed: () => context.pushNamed('Home'),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => FullScreenTemplate(
        header: const Header(
          title: 'Resultado de Validación',
          color: HeaderColor.white,
        ),
        hasHorizontalPaddings: false,
        content: const Padding(
          padding: EdgeInsets.all(SpacingTokens.refSpacing16),
          child: VisualInformation(
            illustration: BacIllustrations.errorResponseState,
            title: 'Error al validar comprobante.',
          ),
        ),
        primaryButton: BacPrimaryButton(
          text: 'Volver',
          onPressed: () => context.pushNamed('Home'),
        ),
      ),
    );
  }
}
