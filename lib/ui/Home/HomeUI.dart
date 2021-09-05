import 'package:agendateste/app/app_module.dart';
import 'package:agendateste/blocs/BlocContact.dart';
import 'package:agendateste/common_widgets/ImgContact.dart';
import 'package:agendateste/src/core/domain/entity/ContactEntity.dart';
import 'package:agendateste/src/features/data/models/ContactModel.dart';
import 'package:agendateste/ui/Home/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  late final BlocContact bloc;
  late final ControllerHomeUI controller;
  @override
  void initState() {
    super.initState();
    bloc = AppModule.to<BlocContact>();
    bloc.getAllContacts();
    controller = ControllerHomeUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Agenda'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _headHome(),
            StreamBuilder<List<ContactEntity>>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    controller.addAllMemoryCache(snapshot.data !);
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  return FormField<List<ContactEntity>>(
                    key: controller.form,
                    initialValue: [],
                    builder: (state) {
                      return Column(
                        children: [
                          ...state.value
                              !.map((e) => _tileContact(e as ContactModel))
                              .toList()
                        ],
                      );
                    }
                  );
                })
          ],
        ),
      ),
    );
  }

  _headHome() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              'Contatos',
              style: TextStyle(
                fontSize: 30,
              ),
            )),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                onChanged: controller.searchContactByName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            IconButton(
                onPressed: () {
                  Modular.to.pushNamed('register');
                },
                icon: Icon(
                  Icons.add,
                  size: 35,
                )),
          ],
        )
      ],
    );
  }

  _tileContact(ContactModel contact) {
    return Container(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed('register', arguments: contact);
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                ImgContact(
                  size: 50,
                  img: contact.photoImg,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      contact.name!,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
                IconButton(
                    onPressed: () async {
                      final url = "tel:${contact.phoneCel}";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: Icon(Icons.phone))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
