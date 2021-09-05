import '../../../src/core/domain/entity/ContactEntity.dart';

abstract class IDatasourceContact {
  Future<ContactEntity> create(Map<String,dynamic> data);
  Future<bool> update(Map<String,dynamic> data);
  Future<bool> delete(Map<String,dynamic> data);
  Future<List<ContactEntity>> read();
}