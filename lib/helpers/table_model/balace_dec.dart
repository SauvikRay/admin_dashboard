import 'dart:convert';

BalanceRecord balanceRecordFromJson(String str) =>
    BalanceRecord.fromJson(json.decode(str));

String balanceRecordToJson(BalanceRecord data) => json.encode(data.toJson());

class BalanceRecord {
  BalanceRecord({
    required this.date,
    required this.previousBalance,
    required this.type,
    required this.change,
    required this.currentBalance,
  });

  String date;
  String previousBalance;
  int type;
  String change;
  String currentBalance;

  factory BalanceRecord.fromJson(Map<String, dynamic> json) => BalanceRecord(
        date: json["date"] == null ? null : json["date"],
        previousBalance:
            json["previous_balance"] == null ? null : json["previous_balance"],
        type: json["type"] == null ? null : json["type"],
        change: json["change"] == null ? null : json["change"],
        currentBalance:
            json["current_balance"] == null ? null : json["current_balance"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "previous_balance": previousBalance == null ? null : previousBalance,
        "type": type == null ? null : type,
        "change": change == null ? null : change,
        "current_balance": currentBalance == null ? null : currentBalance,
      };
}
