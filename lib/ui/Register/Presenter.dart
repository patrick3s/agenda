import 'package:agendateste/blocs/BlocContact.dart';
import 'package:agendateste/ui/Register/Controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

abstract class ContractRegisterUI {
  refresh();
  success();
  fail(String text);
}

class PresenterRegisterUI {
  final ControllerRegisterUI _controller;
  final ContractRegisterUI _contract;
  PresenterRegisterUI(this._controller, this._contract);
  Future<void> getImagePickerSource({required ImageSource source})async {
    await _controller.getImagePickerSource(source:source);
    _contract.refresh();
  }

  createContact() async{
    final result  = await _controller.create();
    if(result is SuccessContactState) {
      Modular.to.popUntil((route) => route.isFirst);
      _contract.success();
      _controller.getAll();
    }
    if(result is ErrorContactState) _contract.fail(result.fail.message);
  }
   updateContact() async{
    final result  = await _controller.update();
    if(result is SuccessContactState) {
      Modular.to.popUntil((route) => route.isFirst);
      _contract.success();
      _controller.getAll();
    }
    if(result is ErrorContactState) _contract.fail(result.fail.message);
  }

   deleteContact() async{
    final result  = await _controller.delete();
    if(result is SuccessContactState) {
      Modular.to.pop();
      _contract.success();
      _controller.getAll();
      
    }
    if(result is ErrorContactState) _contract.fail(result.fail.message);
  }
}