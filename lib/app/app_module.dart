import 'package:agendateste/blocs/BlocContact.dart';
import 'package:agendateste/src/features/injection/InjectionContactions.dart';
import 'package:agendateste/ui/Register/RegisterUI.dart';

import '../ui/Home/HomeUI.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds =>  [
    $UsecaseContacts,
    Bind((i) => BlocContact(i()))
  ];
  @override
  List<ModularRoute> get routes =>  [
    ChildRoute('/', child: (_,args) => HomeUI()),
    ChildRoute('/register', child: (_,args) => RegisterUI(contact:args.data))
  ];

  static Inject get to => Inject<AppModule>();
}