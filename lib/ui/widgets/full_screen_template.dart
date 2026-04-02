import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';

/// Plantilla de pantalla completa reutilizable para las páginas principales.
class FullScreenTemplate extends StatefulWidget {
  final Widget content;
  final String? title;
  final BacPrimaryButton? primaryButton;
  final BacSecondaryButton? secondaryButton;
  final BacGhostButton? ghostButton;
  final BacLink? linkButton;
  final Color? backgroundColor;
  final bool hasHorizontalPaddings;
  final bool alignTop;
  final bool showHeader;

  /// Crea una plantilla de pantalla completa con [content] y botones opcionales.
  const FullScreenTemplate({
    super.key,
    this.title,
    required this.content,
    this.primaryButton,
    this.secondaryButton,
    this.ghostButton,
    this.linkButton,
    this.backgroundColor,
    this.hasHorizontalPaddings = true,
    this.alignTop = false, // Default value for alignTop
    this.showHeader = true, // Default value for showHeader
  }) : assert(showHeader == false || title != null, 'El título no puede ser nulo si showHeader es verdadero');

  @override
  State<FullScreenTemplate> createState() => _FullScreenTemplateState();
}

/// Estado para [FullScreenTemplate].
class _FullScreenTemplateState extends State<FullScreenTemplate> {
  final GlobalKey _contentKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isScrollable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateScrollable();
      }
    });
    _scrollController.addListener(_updateScrollable);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollable);
    _scrollController.dispose();
    super.dispose();
  }

  /// Actualiza si el contenido requiere scroll.
  void _updateScrollable() {
    if (!mounted) return;
    final bool scrollable = _scrollController.hasClients && _scrollController.position.maxScrollExtent > 0;
    if (scrollable != _isScrollable) {
      setState(() {
        _isScrollable = scrollable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasButtonPanel = widget.primaryButton != null || widget.secondaryButton != null || widget.ghostButton != null || widget.linkButton != null;

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? context.bacColorTokens.sysColorWhiteBackground,
      appBar: Header(color: HeaderColor.surface, title: widget.title),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _updateScrollable();
              }
            });
            return SingleChildScrollView(
              key: _contentKey,
              controller: _scrollController,
              padding: widget.hasHorizontalPaddings ? const EdgeInsets.all(SpacingTokens.refSpacing16) : EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: widget.alignTop ? MainAxisAlignment.start : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [widget.content],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: hasButtonPanel
          ? _isScrollable
                ? ButtonPanel.onScroll(
                    primaryButton: widget.primaryButton,
                    secondaryButton: widget.secondaryButton,
                    ghostButton: widget.ghostButton,
                    link: widget.linkButton,
                  )
                : ButtonPanel(
                    primaryButton: widget.primaryButton,
                    secondaryButton: widget.secondaryButton,
                    ghostButton: widget.ghostButton,
                    link: widget.linkButton,
                  )
          : const SizedBox.shrink(),
    );
  }
}
