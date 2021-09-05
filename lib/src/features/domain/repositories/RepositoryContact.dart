import '../../../../src/core/datasource/IDatasourceContact.dart';

import '../../../../src/core/domain/error/Failure.dart';
import '../../../../src/core/domain/entity/ContactEntity.dart';
import '../../../../src/core/domain/repositories/IRepositoryContact.dart';
import 'package:dartz/dartz.dart';

class RepositoryContact extends IRepositoryContact {
  final IDatasourceContact _datasource;

  RepositoryContact(this._datasource);
  @override
  Future<Either<Failure, ContactEntity>> create(Map<String, dynamic> data) async{
    try{
      return Right(await _datasource.create(data));
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(Map<String, dynamic> data) async{
   try{
      return Right(await _datasource.delete(data));
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> read() async{
    try{
      return Right(await _datasource.read());
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> update(Map<String, dynamic> data) async{
    try{
      return Right(await _datasource.update(data));
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }
}