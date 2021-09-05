


import 'package:flutter/services.dart';

import '../../../app/app_module.dart';
import '../../../blocs/BlocContact.dart';
import '../../common_widgets/ImgContact.dart';
import '../../src/features/data/models/ContactModel.dart';
import '../../ui/Register/Controller.dart';
import '../../ui/Register/Presenter.dart';
import '../../ui/Register/Validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class RegisterUI extends StatefulWidget {
  final ContactModel? contact;
   RegisterUI({ Key? key, this.contact }) : super(key: key);

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> implements ContractRegisterUI{
  late final bool update;
  
  late final BlocContact bloc;
  late final ControllerRegisterUI controller;
  late final PresenterRegisterUI presenter;
  @override
  void initState() {
    super.initState();
    bloc = AppModule.to<BlocContact>();
    controller = ControllerRegisterUI(bloc,widget.contact);
    presenter = PresenterRegisterUI(controller,this);
    update = widget.contact != null;
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text( update ? "Atualizar Contato" : 'Novo contato'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.form,
              child: Column(
                  children: [
                    ImgContact(size: size.height * .2, img: controller.contact['photoImg'],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _button('Camera', Colors.green, () async{
                          await presenter.getImagePickerSource(source: ImageSource.camera);
                          
                        }, Icons.camera),
                        _button('Galeria', Colors.green, () async{
                          await presenter.getImagePickerSource(source: ImageSource.gallery);
                        }, Icons.photo)
                      ],
                    ),
                   _inputField(
                     labelText: 'Nome',
                     initialText: controller.contact['name'],
                     validator: ValidatorsRegister.mandatory,
                     onChanged: (value){
                       controller.contact['name'] =value;
                     }
                   ),
                   
                   
                   _inputField(
                     labelText: 'Celular',
                     initialText: controller.contact['phoneCel'],
                      mask: [ValidatorsRegister.phoneNumberMask],
                     keyboardType: TextInputType.number,
                     validator: ValidatorsRegister.phoneNumber,
                     onChanged: (value){
                       controller.contact['phoneCel'] =value;
                     }
                   ),
                   StreamBuilder<ContactState>(
                     stream: bloc.state,
                     builder: (context, snapshot) {
                       if(snapshot.data is LoadingContactState) return Center(
                         child: CircularProgressIndicator(),
                       );

                       return Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           update ? _button('Deletar',
                            Colors.green, (){
                              presenter.deleteContact();
                            }, Icons.delete):Container(),
                   
                            _button(update ? "Atualizar" : "Salvar",
                             Colors.green, () {
                               if(update){
                                 presenter.updateContact();
                               }else{
                                 presenter.createContact();
                               }
                             },
                              Icons.save)
                         ],
                       );
                     }
                   )
                  ],
                    ),
            ),
          ),
        )),
    );
  }

 

  _inputField({
    String? labelText,
    String? hintText, 
    String? initialText,
     TextInputType? keyboardType,
      List<TextInputFormatter>? mask,
    String? Function(String?)? validator,
     Function(String?)? onChanged
    }){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onChanged,
        validator: validator,
        inputFormatters: mask ?? [],
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

_button(String label, Color color, Function() onTap, IconData icon){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 45,
      child: ElevatedButton.icon(onPressed: onTap,
       icon: Icon(icon),
       style: ElevatedButton.styleFrom(
         primary: color
       ),
        label: Text(label)),
    ),
  );
}

  @override
  fail(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ))
    );
  }

  @override
  refresh() {
   setState(() {
     
   });
  }

  @override
  success() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Ação realizada com sucesso',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ))
    );
  }
}