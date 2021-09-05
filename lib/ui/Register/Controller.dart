import 'dart:convert';

import '../../blocs/BlocContact.dart';
import '../../src/features/data/models/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ControllerRegisterUI {
  final BlocContact _bloc;
  ContactModel? contactModel;
  final form = GlobalKey<FormState>();
  final _picker = ImagePicker();
  Map<String,dynamic> contact = {};
  ControllerRegisterUI(this._bloc, this.contactModel) {
    if (contactModel != null){
      contact.addAll(contactModel!.toMap());
    }
    print(contact);
  }

  Future<void> getImagePickerSource({required ImageSource source}) async {
    try{
      final file = await _picker.getImage(source:source);
      print(file);
    if(file != null){
      try{
        final byteToEncode =await file.readAsBytes();
      final byte64 = base64Encode(byteToEncode);
      contact["photoImg"] = byte64;
      }catch(e){
        print(e);
      }
      
    }
    }catch(e){
     print(e);
    }
    
  }

  Future<ContactState?> create()async{
    if(form.currentState!.validate()) return await _bloc.createContact(contact);
    
  }
  Future<ContactState?> update()async{
    if(form.currentState!.validate()) return await _bloc.updateContact(contact);
  }
  Future<ContactState> delete()async{
    return await _bloc.deleteContact(contact);
  }
  Future<ContactState> getAll()async{
    return await _bloc.getAllContacts();
  }

}
