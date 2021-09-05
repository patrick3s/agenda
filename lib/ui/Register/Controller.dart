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
  ControllerRegisterUI(this._bloc, this.contactModel) {
    if (contactModel == null){
      contactModel = ContactModel();
    }else{
      contactModel = ContactModel.fromMap(contactModel!.toMap());
    }
  }

  Future<void> getImagePickerSource({required ImageSource source}) async {
    try{
      final file = await _picker.getImage(source:source);
    if(file != null){
      final byteToEncode =await file.readAsBytes();
      final byte64 = base64Encode(byteToEncode);
      contactModel?.photoImg = byte64;
    }
    }catch(e){
     
    }
    
  }

  Future<ContactState?> create()async{
    if(form.currentState!.validate()) return await _bloc.createContact(contactModel!.toMap());
    
  }
  Future<ContactState?> update()async{
    if(form.currentState!.validate()) return await _bloc.updateContact(contactModel!.toMap());
  }
  Future<ContactState> delete()async{
    return await _bloc.deleteContact(contactModel!.toMap());
  }
  Future<ContactState> getAll()async{
    return await _bloc.getAllContacts();
  }

}
