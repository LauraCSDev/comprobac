import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app_localizations_ext.dart';
import '../../../datasources/datasources.dart';
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
  String? _diaSeleccionado;
  bool _isSinpeMovil = false;

  void _selectMes(String key) {
    if (!mounted) return;
    setState(() {
      _mesSeleccionado = key;
    });
    Navigator.of(context).pop();
  }

  void _selectDia(String key) {
    if (!mounted) return;
    setState(() {
      _diaSeleccionado = key;
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

    // Genera los días del 1 al 31
    final diasDelMes = <String, String>{for (int i = 1; i <= 31; i++) i.toString().padLeft(2, '0'): i.toString()};

    /// Valida un comprobante SINPE Móvil.
    /// Los primeros 8 dígitos deben corresponder a YYYYMMDD de la fecha seleccionada.
    /// Los siguientes 3 dígitos son el código de la entidad financiera.
    String? validateSinpeMovil(String reference) {
      final digitsOnly = reference.replaceAll(RegExp(r'[^0-9]'), '');
      if (digitsOnly.length < 11) {
        return localizations.sinpeMovilMinDigits;
      }
      final datePrefix = digitsOnly.substring(0, 8);
      final year = DateTime.now().year;
      final expectedDate = '$year${_mesSeleccionado ?? ''}${_diaSeleccionado ?? ''}';
      if (datePrefix != expectedDate) {
        return localizations.sinpeMovilDateInvalid;
      }
      return null; // válido
    }

    /// Valida el formulario y navega mostrando los detalles completos si existe la transacción.
    void validateForm() async {
      if (!mounted) return;

      final formValid = _formKey.currentState?.validate() == true;
      if (!formValid) return;

      // Validar selección de mes
      if (_mesSeleccionado == null) {
        BacSnackbarUtils.showSnackbar(snackbar: BacSnackbar.error(message: localizations.monthRequired));
        return;
      }

      // Validar selección de día (solo SINPE Móvil)
      if (_isSinpeMovil && _diaSeleccionado == null) {
        BacSnackbarUtils.showSnackbar(snackbar: BacSnackbar.error(message: localizations.dayRequired));
        return;
      }

      if (_isSinpeMovil) {
        final reference = _comprobanteController.text.trim();
        final sinpeError = validateSinpeMovil(reference);
        if (sinpeError != null) {
          // Mostrar resultado inválido para SINPE Móvil con el error específico
          ref.read(sinpeMovilResultProvider.notifier).state = (isValid: false, entityCode: '', errorMessage: sinpeError);
          ref.read(selectedTransactionProvider.notifier).state = null;
          context.pushNamed('ValidationResult');
          return;
        }
        // SINPE Móvil válido: los primeros 8 dígitos coinciden con la fecha
        final entityCode = reference.replaceAll(RegExp(r'[^0-9]'), '').substring(8, 11);
        ref.read(sinpeMovilResultProvider.notifier).state = (isValid: true, entityCode: entityCode, errorMessage: '');
        ref.read(selectedTransactionProvider.notifier).state = null;
        context.pushNamed('ValidationResult');
        return;
      }

      // Flujo estándar
      final reference = _comprobanteController.text.trim();
      final accountNumber = _cuentaController.text.trim();
      final year = DateTime.now().year;
      final date = '$year-$_mesSeleccionado';
      final transaction = await TransactionDetailDataSource().findTransaction(reference: reference, accountNumber: accountNumber, date: date);
      if (!mounted) return;
      ref.read(sinpeMovilResultProvider.notifier).state = null;
      ref.read(selectedTransactionProvider.notifier).state = transaction;
      context.pushNamed('ValidationResult');
    }

    return FullScreenTemplate(
      title: localizations.validationFormTitle,
      primaryButton: BacPrimaryButton(text: localizations.validationFormButton, onPressed: validateForm),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VisualInformation(illustration: BacIllustrations.codeSms, title: localizations.validationFormTitle),
            // Toggle SINPE Móvil
            SwitchListTile(
              title: BodyText(localizations.sinpeMovilLabel),
              value: _isSinpeMovil,
              onChanged: (value) {
                if (!mounted) return;
                setState(() {
                  _isSinpeMovil = value;
                  if (!value) {
                    _diaSeleccionado = null;
                  }
                });
              },
            ),
            Spacing.medium24,
            InputText(
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
            if (!_isSinpeMovil) ...[
              Spacing.medium24,
              InputText(
                labelText: localizations.validationFormAccount,
                controller: _cuentaController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (_isSinpeMovil) return null;
                  if (value == null || value.trim().isEmpty) {
                    return localizations.fieldRequired;
                  }
                  return null;
                },
              ),
            ],
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
                          .map(
                            (entry) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(SpacingTokens.refSpacing02),
                                child: BacActionSegmentedButton(
                                  isSelected: mesesDelAnio[_mesSeleccionado] == entry.value,
                                  title: entry.value,
                                  titleStyle: context.bacTextTheme.caption_Regular,
                                  onTap: () => _selectMes(entry.key),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }),
                ),
              ),
            ),
            // Selector de día (solo visible para SINPE Móvil)
            if (_isSinpeMovil) ...[
              Spacing.medium24,
              Dropdown(
                label: localizations.validationFormDay,
                text: _diaSeleccionado == null ? localizations.validationFormDay : _diaSeleccionado!,
                bottomSheet: BaseBottomSheet(
                  title: localizations.validationFormDay,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(7, (row) {
                      final start = row * 5;
                      final end = (start + 5).clamp(0, 31);
                      if (start >= 31) return const SizedBox.shrink();
                      final entries = diasDelMes.entries.toList().sublist(start, end);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: entries
                            .map(
                              (entry) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(SpacingTokens.refSpacing02),
                                  child: BacActionSegmentedButton(
                                    isSelected: _diaSeleccionado == entry.key,
                                    title: entry.value,
                                    titleStyle: context.bacTextTheme.caption_Regular,
                                    onTap: () => _selectDia(entry.key),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ),
                ),
              ),
            ],
            Spacing.medium16,
          ],
        ),
      ),
    );
  }
}
