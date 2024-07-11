import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'category.dart';

class TransactionModel {
  const TransactionModel({
    required this.amount,
    required this.category,
    required this.createdOn,
    required this.name,
    required this.uid,
    this.note,
  });

  TransactionModel.fromJson(Map<String, Object?> json)
      : this(
          amount: (int.tryParse(
                    json['amount_cents'].toString(),
                  ) ??
                  -1) /
              100,
          category: EnumToString.fromString(
                Category.values,
                json['category'].toString(),
              ) ??
              Category.miscellaneous,
          createdOn: (json['created_on']! as Timestamp).toDate(),
          name: json['name'].toString(),
          uid: json['uid'].toString(),
          note: json['note']?.toString(),
        );

  final double amount;
  final Category category;
  final DateTime createdOn;
  final String name;
  final String uid;
  final String? note;

  Map<String, Object?> toJson() => <String, Object?>{
        'amount_cents': (amount * 100).round(),
        'category': EnumToString.convertToString(category),
        'created_on': Timestamp.fromDate(createdOn),
        'name': name,
        'uid': uid,
        'note': note,
      };
}
