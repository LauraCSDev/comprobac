import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app_localizations_ext.dart';
import '../../providers/session_provider.dart';
import '../../resources/resources.dart';
import '../widgets/full_screen_template.dart';

/// Página de login para autenticación de usuario.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController codigoBacController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  @override
  void dispose() {
    codigoBacController.dispose();
    super.dispose();
  }

  String? validateBacCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es requerido';
    }
    if (value.trim().length != 6) {
      return 'El código BAC debe tener 6 dígitos';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'El código BAC solo debe contener números';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    try {
      final localizations = context.localizations;

      return FullScreenTemplate(
        content: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Image.asset(
                      Logo.logo,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Spacing.medium40,
                H3(
                  localizations.bacCodeTitle,
                ),
                Spacing.medium16,
                InputToken(
                  length: 6,
                  controller: codigoBacController,
                  label: localizations.bacCodeLabel,
                  errorText: errorText,
                  showIconButton: false,
                  onChanged: (value) {
                    setState(() {
                      errorText = validateBacCode(value);
                    });
                  },
                ),
                Spacing.medium32,
                BacPrimaryButton(
                  onPressed: () async {
                    if (!mounted) return;
                    FocusScope.of(context).unfocus();
                    // Validate the BAC code before proceeding
                    final validation = validateBacCode(codigoBacController.text);
                    if (validation != null) {
                      setState(() {
                        errorText = validation;
                      });
                      return;
                    }

                    if (!mounted) return;
                    setState(() => isLoading = true);

                    try {
                      final success = await ref.read(sessionProvider.notifier).loginWithBacCode(
                            codigoBac: codigoBacController.text.trim(),
                          );
                      if (!mounted) return;
                      setState(() => isLoading = false);

                      if (success == true) {
                        if (mounted) {
                          context.pushReplacementNamed('Onboarding');
                        }
                      } else {
                        if (mounted) {
                          BacSnackbarUtils.showSnackbar(
                            snackbar: BacSnackbar.error(
                              message: localizations.bacCodeLoginError,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (!mounted) return;
                      setState(() => isLoading = false);
                      if (mounted) {
                        BacSnackbarUtils.showSnackbar(
                          snackbar: const BacSnackbar.error(
                            message: 'Error de conexión. Inténtalo de nuevo.',
                          ),
                        );
                      }
                    }
                  },
                  text: localizations.loginButton,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      // Fallback UI with hardcoded Spanish text
      return FullScreenTemplate(
        content: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Image.asset(
                      Logo.logo,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Spacing.medium40,
                const H3('Código BAC'),
                Spacing.medium16,
                InputToken(
                  length: 6,
                  controller: codigoBacController,
                  label: 'Ingrese su código BAC de 6 dígitos',
                  errorText: errorText,
                  showIconButton: false,
                  onChanged: (value) {
                    setState(() {
                      errorText = validateBacCode(value);
                    });
                  },
                ),
                Spacing.medium32,
                BacPrimaryButton(
                  onPressed: () async {
                    try {
                      if (!mounted) return;
                      FocusScope.of(context).unfocus();
                      final validation = validateBacCode(codigoBacController.text);
                      if (validation != null) {
                        if (mounted) {
                          setState(() {
                            errorText = validation;
                          });
                        }
                        return;
                      }

                      if (!mounted) return;
                      setState(() => isLoading = true);
                      final pushReplacementNamed = context.pushReplacementNamed;

                      final success = await ref.read(sessionProvider.notifier).loginWithBacCode(
                            codigoBac: codigoBacController.text.trim(),
                          );
                      if (!mounted) return;
                      setState(() => isLoading = false);
                      if (success == true) {
                        pushReplacementNamed('Onboarding');
                      } else {
                        if (mounted) {
                          BacSnackbarUtils.showSnackbar(
                            snackbar: const BacSnackbar.error(
                              message: 'Login fallido. Verifica tu código BAC.',
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (!mounted) return;
                      setState(() => isLoading = false);
                      if (mounted) {
                        BacSnackbarUtils.showSnackbar(
                          snackbar: const BacSnackbar.error(
                            message: 'Error de conexión. Inténtalo de nuevo.',
                          ),
                        );
                      }
                    }
                  },
                  text: 'Entrar',
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
