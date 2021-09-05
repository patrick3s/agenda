
import '../../src/core/domain/entity/ContactEntity.dart';
import 'package:flutter/widgets.dart';



class ControllerHomeUI {
  List<ContactEntity> _memoryCacheContacts = [];

  GlobalKey<FormFieldState> form = GlobalKey<FormFieldState>();
  addAllMemoryCache(List<ContactEntity> contactsList) {
    _memoryCacheContacts.clear();
    _memoryCacheContacts.addAll(contactsList);
    _orderAllContacts(_memoryCacheContacts);
  }

  searchContactByName(String nameContact){
    if(nameContact.isEmpty){
      _orderAllContacts(_memoryCacheContacts);
    }else{
      List<ContactEntity>_contacts = [];
      _contacts.addAll(_memoryCacheContacts);
      _contacts.retainWhere((contact) => contact.name!.toUpperCase().contains(nameContact.toUpperCase()));
      _orderAllContacts(_contacts);
    }
  }

  _orderAllContacts(List<ContactEntity> contactsToOrderByName ){
    Comparator<ContactEntity> comparator = (a,b) => a.name!.compareTo(b.name!);
    contactsToOrderByName.sort(comparator);
    form.currentState?.didChange(contactsToOrderByName);
  }
}