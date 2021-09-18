
import 'package:agendateste/src/core/domain/entity/ContactEntity.dart';
import 'package:agendateste/src/core/domain/error/Failure.dart';
import 'package:agendateste/src/core/domain/error/MessageError.dart';
import 'package:agendateste/src/core/domain/repositories/IRepositoryContact.dart';
import 'package:agendateste/src/core/domain/usecase/IUsecaseContact.dart';
import 'package:agendateste/src/features/data/models/ContactModel.dart';
import 'package:agendateste/src/features/domain/usecase/UsecaseContact.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepositoryContact extends Mock implements IRepositoryContact {}
main() {
  late IRepositoryContact repository;
  late IUsecaseContact usecase;
  setUp((){
   
    repository = MockRepositoryContact();
    usecase = UsecaseContact(repository);
  });

  var data ={
      'id': 10,
      'photoImg': "photoImg",
      'name': "name",
      'lastName': "lastName",
      'phoneCel': "phoneCel",
      'phoneFix': "phoneFix",
    };

  final contact = ContactModel.fromMap(data);
  final error = Failure(MessageError.errorParam);
  test('test return list all contacts', ()async{
    //arrange
    when(()=> repository.read()).thenAnswer((_) async => Right(<ContactEntity>[]));
    //acts
    final result = await usecase.read();
    //asserts
    expect(result.fold(id, id), isA<List<ContactEntity>>());
  });

  test('test create contact', ()async{
    //arrange
    when(()=>repository.create(data)).thenAnswer((_) async => Right(contact));
    //acts
    final result = await usecase.create(data);
    //asserts
    expect(result.fold(id,id), contact);
  });

  test('test update contact', ()async{
    //arrange
    when(()=>repository.update(data)).thenAnswer((_) async => Right(true));
    //acts
    final result = await usecase.update(data);
    //asserts
    expect(result.fold(id,id), true);
  });

  test('test delete contact', ()async{
    //arrange
    when(()=>repository.delete(data)).thenAnswer((_) async => Right(true));
    //acts
    final result = await usecase.delete(data);
    //asserts
    expect(result.fold(id,id), true);
  });

  test('test error list all contacts', ()async{
    //arrange
    when(()=> repository.read()).thenAnswer((_) async => Left(error));
    //acts
    final result = await usecase.read();
    //asserts
    expect(result.fold(id, id), isA<Failure>());
  });

  test('test error create contact', ()async{
    //arrange
    when(()=>repository.create({})).thenAnswer((_) async => Left(error));
    //acts
    final result = await usecase.create({});
    //asserts
    expect(result.fold(id,id), isA<Failure>());
  });

  test('test error update contact', ()async{
    //arrange
    when(()=>repository.update({})).thenAnswer((_) async => Left(error));
    //acts
    final result = await usecase.update({});
    //asserts
    expect(result.fold(id,id), isA<Failure>());
  });

  test('test error delete contact', ()async{
    //arrange
    when(()=>repository.delete({})).thenAnswer((_) async => Left(error));
    //acts
    final result = await usecase.delete({});
    //asserts
    expect(result.fold(id,id), isA<Failure>());
  });

    test('test return map', ()async{
      final contact = ContactModel.fromMap(data);


      final result = contact.toMap();

      expect(result, isA<Map<String,dynamic>>());
    });
     test('test return json', ()async{
      final contact = ContactModel.fromMap(data);


      final result = contact.toJson();

      expect(result, isA<String>());
    });

     test('test return Contact', ()async{
      final contact = ContactModel.fromMap(data);


      final result = ContactModel.fromJson(contact.toJson());

      expect(result, isA<ContactModel>());
    });
}