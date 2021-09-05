import 'package:agendateste/src/core/domain/error/MessageError.dart';

import '../../../../src/core/domain/error/Failure.dart';
import '../../../../src/core/domain/entity/ContactEntity.dart';
import '../../../../src/core/domain/repositories/IRepositoryContact.dart';
import '../../../../src/core/domain/usecase/IUsecaseContact.dart';
import 'package:dartz/dartz.dart';

class UsecaseContact extends IUsecaseContact {
  final IRepositoryContact _repository;

  UsecaseContact(this._repository);
  @override
  Future<Either<Failure, ContactEntity>> create(Map<String, dynamic> data) async{
    if(!data.containsKey('name') || !data.containsKey('phoneCel')){
      return Left(Failure(MessageError.errorParam));
    }
    return await _repository.create(data);
  }

  @override
  Future<Either<Failure, bool>> delete(Map<String, dynamic> data) async{
    if(!data.containsKey('id')){
      return Left(Failure(MessageError.errorParam));
    }
    return await _repository.delete(data);
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> read() async{
    return await _repository.read();
  }

  @override
  Future<Either<Failure, bool>> update(Map<String, dynamic> data) async{
    if(!data.containsKey('id') || !data.containsKey('name') || !data.containsKey('phoneCel')){
      return Left(Failure(MessageError.errorParam));
    }
    return await _repository.update(data);
  }

}