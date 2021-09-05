

import 'dart:convert';

import '../../../../src/core/domain/entity/ContactEntity.dart';

class ContactModel extends ContactEntity {
    String? id;
  String? photoImg;
   String? name;
   String? phoneCel;
  ContactModel({
    this.id,
    this.photoImg,
    this.name,
    this.phoneCel,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': int.parse(id ?? '0'),
      'photoImg': photoImg ?? '',
      'name': name,
      'phoneCel': phoneCel,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'].toString(),
      photoImg: map['photoImg'] != null ? map['photoImg'].toString().isEmpty ? null : map['photoImg'] : null,
      name: map['name'],
      phoneCel: map['phoneCel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));
}
