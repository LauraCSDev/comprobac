import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app_localizations_ext.dart';
import '../../../datasources/datasources.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../widgets/widgets.dart';

// Los nombres de los meses se obtendrán desde localización en build()

/// Página de formulario para validar comprobantes de transferencia bancaria.
class FormPage extends ConsumerStatefulWidget {
  const FormPage({super.key});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  // ...existing code...
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _comprobanteController = TextEditingController();
  final TextEditingController _cuentaController = TextEditingController();
  String? _mesSeleccionado;
  void _selectMes(String key) {
    if (!mounted) return;
    setState(() {
      _mesSeleccionado = key;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _comprobanteController.dispose();
    _cuentaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    final mesesDelAnio = <String, String>{
      '01': localizations.january,
      '02': localizations.february,
      '03': localizations.march,
      '04': localizations.april,
      '05': localizations.may,
      '06': localizations.june,
      '07': localizations.july,
      '08': localizations.august,
      '09': localizations.september,
      '10': localizations.october,
      '11': localizations.november,
      '12': localizations.december,
    };

    /// Valida el formulario y navega mostrando los detalles completos si existe la transacción.
    void validateForm() async {
      if (!mounted) return;
      final isValid = _formKey.currentState?.validate() == true && _mesSeleccionado != null;
      TransactionDetailModel? transaction;
      if (isValid) {
        final reference = _comprobanteController.text.trim();
        final accountNumber = _cuentaController.text.trim();
        final date = '2025-${_mesSeleccionado ?? ''}';
        transaction = await TransactionDetailDataSource().findTransaction(
          reference: reference,
          accountNumber: accountNumber,
          date: date,
        );
      } else {
        transaction = null;
      }
      if (!mounted) return;
      ref.read(selectedTransactionProvider.notifier).state = transaction;
      context.pushNamed('ValidationResult');
    }

    return FullScreenTemplate(
      header: Header(
        title: localizations.validationFormTitle,
        color: HeaderColor.white,
        onTapLeftButton: () => context.pushNamed('Home'),
      ),
      primaryButton: BacPrimaryButton(
        text: localizations.validationFormButton,
        onPressed: validateForm,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VisualInformation(
              illustration: BacIllustrations.codeSms,
              title: localizations.validationFormTitle,
            ),
            LocalInputText(
              labelText: localizations.validationFormReference,
              controller: _comprobanteController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.fieldRequired;
                }
                return null;
              },
            ),
            Spacing.medium24,
            LocalInputText(
              labelText: localizations.validationFormAccount,
              controller: _cuentaController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.fieldRequired;
                }
                return null;
              },
            ),
            Spacing.medium24,
            Dropdown(
              label: localizations.validationFormMonth,
              text: _mesSeleccionado == null ? localizations.validationFormMonth : mesesDelAnio[_mesSeleccionado] ?? '',
              bottomSheet: BaseBottomSheet(
                title: localizations.validationFormMonth,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(4, (row) {
                    final start = row * 3;
                    final end = start + 3;
                    final entries = mesesDelAnio.entries.toList().sublist(start, end);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: entries
                          .map((entry) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(SpacingTokens.refSpacing02),
                                  child: BacActionSegmentedButton(
                                    isSelected: mesesDelAnio[_mesSeleccionado] == entry.value,
                                    title: entry.value,
                                    titleStyle: context.bacTextTheme.caption_14Regular,
                                    onTap: () => _selectMes(entry.key),
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  }),
                ),
              ),
            ),
            Spacing.medium16,
          ],
        ),
      ),
    );
  }
}
