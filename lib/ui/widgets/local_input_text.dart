import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';

/// Wrapper seguro para InputText que previene setState después de dispose.
class LocalInputText extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;

  const LocalInputText({
    super.key,
    required this.labelText,
    required this.controller,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<LocalInputText> createState() => _LocalInputTextState();
}

class _LocalInputTextState extends State<LocalInputText> {
  void _onChanged(String value) {
    if (!mounted) return;
    widget.onChanged?.call(value);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputText(
      labelText: widget.labelText,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      obscureText: widget.obscureText,
      onChanged: _onChanged,
    );
  }
}
