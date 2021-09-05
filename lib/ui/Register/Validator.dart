import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ValidatorsRegister {
  
  static var phoneNumberMask = new MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  static String? mandatory(String? value){
    if(value == null){
      return "Campo obrigátorio";
    }
    if(value.isEmpty == true){
      return "Campo obrigátorio";
    }
    return null;
  }


  static String? phoneNumber(String? value){
    if(value?.isEmpty == true){
      return "Campo obrigátorio";
    }
    if(value!.length < 15){
      return "Celular invalido";
    }
    return null;
  }


}