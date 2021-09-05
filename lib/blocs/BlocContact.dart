import 'package:agendateste/src/core/domain/entity/ContactEntity.dart';
import 'package:agendateste/src/core/domain/error/Failure.dart';
import 'package:agendateste/src/features/domain/usecase/UsecaseContact.dart';
import 'package:rxdart/subjects.dart';

abstract class ContactState {}
class LoadingContactState  extends ContactState{}
class IdleContactState  extends ContactState{}
class SuccessContactState  extends ContactState{}
class ErrorContactState  extends ContactState{
  final Failure fail;
  ErrorContactState(this.fail);
}

class BlocContact {
  final UsecaseContact usecase;
  final BehaviorSubject<ContactState> _controllerState= BehaviorSubject.seeded(IdleContactState());
  final BehaviorSubject<List<ContactEntity>> _controllerStream = BehaviorSubject.seeded([]);
  BlocContact(this.usecase);
  Stream<ContactState> get state => _controllerState.stream;
  Stream<List<ContactEntity>> get stream => _controllerStream.stream;

  Future<ContactState> createContact(Map<String,dynamic> data)async{
    print(data);
    _controllerState.add(LoadingContactState());
    final result = await usecase.create(data);
    return result.fold((l) {
      print(l.message);
      final _state = ErrorContactState(l);
      _controllerState.add(_state);
      return _state;
    }, (r) {
      final _state = SuccessContactState();
      _controllerState.add(_state);
      return _state;
    });
  }

   Future<ContactState> updateContact(Map<String,dynamic> data)async{
    _controllerState.add(LoadingContactState());
    final result = await usecase.update(data);
    return result.fold((l) {
      final _state = ErrorContactState(l);
      _controllerState.add(_state);
      return _state;
    }, (r) {
      final _state = SuccessContactState();
      _controllerState.add(_state);
      return _state;
    });
  }

   Future<ContactState> deleteContact(Map<String,dynamic> data)async{
    _controllerState.add(LoadingContactState());
    final result = await usecase.delete(data);
    return result.fold((l) {
      final _state = ErrorContactState(l);
      _controllerState.add(_state);
      return _state;
    }, (r) {
      final _state = SuccessContactState();
      _controllerState.add(_state);
      return _state;
    });
  }

   getAllContacts()async{
    _controllerState.add(LoadingContactState());
    final result = await usecase.read();
     return result.fold((l) {
      final _state = ErrorContactState(l);
      _controllerState.add(_state);
      return _state;
    }, (r) {
      final _state = SuccessContactState();
      _controllerState.add(_state);
      _controllerStream.add(r);
      return _state;
    });
  }

  dispose(){
    _controllerState.close();
    _controllerStream.close();
  }
  
}