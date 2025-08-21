import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              InputText(
                labelText: 'Username',
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Este campo es requerido';
                  }
                  return null;
                },
              ),
              Spacing.medium16,
              InputText(
                labelText: 'Password',
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  }
                  return null;
                },
              ),
              Spacing.medium32,
              BacPrimaryButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!formKey.currentState!.validate()) return;
                  if (!mounted) return;
                  setState(() => isLoading = true);
                  final pushReplacementNamed = GoRouter.of(context).pushReplacementNamed;
                  Future.microtask(() async {
                    final success = await ref.read(sessionProvider.notifier).login(
                          username: usernameController.text.trim(),
                          password: passwordController.text,
                        );
                    if (!mounted) return;
                    setState(() => isLoading = false);
                    if (success == true) {
                      pushReplacementNamed('Onboarding');
                    } else {
                      BacSnackbarUtils.showSnackbar(
                        snackbar: const BacSnackbar.error(
                          message: 'Login fallido. Verifica tus credenciales.',
                        ),
                      );
                    }
                  });
                },
                text: 'Login',
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
