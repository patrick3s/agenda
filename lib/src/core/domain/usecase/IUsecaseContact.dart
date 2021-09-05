import '../../../../src/core/domain/entity/ContactEntity.dart';
import '../../../../src/core/domain/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUsecaseContact {
  Future<Either<Failure,ContactEntity>> create(Map<String,dynamic> data);
  Future<Either<Failure,bool>> update(Map<String,dynamic> data);
  Future<Either<Failure,bool>> delete(Map<String,dynamic> data);
  Future<Either<Failure,List<ContactEntity>>> read();
}