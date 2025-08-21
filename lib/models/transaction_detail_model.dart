/// Modelo extendido de transacción bancaria para mostrar detalles completos en la validación.
class TransactionDetailModel {
  final String reference;
  final String accountNumber;
  final String date;
  final double amount;
  final String currency;
  final String beneficiaryName;

  /// Crea una transacción detallada con todos los campos relevantes.
  const TransactionDetailModel({
    required this.reference,
    required this.accountNumber,
    required this.date,
    required this.amount,
    required this.currency,
    required this.beneficiaryName,
  });

  /// Convierte la transacción detallada a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'account_number': accountNumber,
      'date': date,
      'amount': amount,
      'currency': currency,
      'beneficiary_name': beneficiaryName,
    };
  }

  /// Crea una transacción detallada a partir de un JSON.
  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
      reference: json['reference'],
      accountNumber: json['account_number'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      beneficiaryName: json['beneficiary_name'],
    );
  }
}
