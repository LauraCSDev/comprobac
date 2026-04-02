import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app_localizations_ext.dart';
import '../../datasources/transaction_detail_datasource.dart';
import '../../models/transaction_detail_model.dart';
import '../../providers/transaction_detail_provider.dart';
import '../widgets/full_screen_template.dart';

/// Página principal con acceso al validador de transacciones.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<List<TransactionDetailModel>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = TransactionDetailDataSource().fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final bacColors = context.bacColorTokens;
    final localizations = context.localizations;
    return Consumer(
      builder: (context, ref, _) {
        return FullScreenTemplate(
          hasHorizontalPaddings: false,
          alignTop: true,
          title: localizations.appTitle,
          content: Column(
            children: [
              H3(localizations.homeWelcome),
              Spacing.medium16,
              BacNavigationWidgetOption(
                widgetOptionItems: [
                  BacAtomContainmentWidgetOptions.forGroup(
                    iconPath: BacIcons.checkCircle,
                    subtitle: localizations.homeMenuValidate,
                    alertMessage: localizations.homeMenuValidate,
                    onTap: () {
                      context.pushNamed('Validate');
                    },
                  ),
                  BacAtomContainmentWidgetOptions.forGroup(
                    iconPath: BacIcons.checkCircle,
                    subtitle: localizations.homeMenuServices,
                    onTap: () {
                      debugPrint('Servicios tapped');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingTokens.refSpacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText.medium(localizations.homeHistoryTitle),
                    Spacing.medium16,
                    FutureBuilder<List<TransactionDetailModel>>(
                      future: _transactionsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return BodyText(localizations.homeNoTransactions);
                        }
                        final transactions = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: SpacingTokens.refSpacing08),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return CardList(
                              widgetLeft: BacSvgIcon(
                                assetIcon: index % 2 == 0 ? BacIcons.moneySend : BacIcons.ionIconMoneyBring,
                                color: bacColors.sysColorSecondaryIconActionDefault,
                              ),
                              titleLeft: localizations.homeReference(transaction.reference),
                              subTextLeft: transaction.date,
                              onTap: () {
                                ref.read(sinpeMovilResultProvider.notifier).state = null;
                                ref.read(selectedTransactionProvider.notifier).state = transaction;
                                context.pushNamed('ValidationResult');
                              },
                              titleRight: AmountTile(
                                amount: transaction.amount,
                                currency: CurrencyIsoDs.CRC,
                                textColor: index % 2 == 0 ? bacColors.sysColorPositiveText : bacColors.sysColorNeutralTextSemiStrong,
                              ),
                              widgetRight: BacSvgIcon(assetIcon: BacIcons.chevronRight, color: bacColors.sysColorSecondaryIconActionDefault),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
