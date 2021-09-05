import '../../../src/features/data/datasource/local/DatasourceContact.dart';
import '../../../src/features/domain/repositories/RepositoryContact.dart';
import '../../../src/features/domain/usecase/UsecaseContact.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $UsecaseContacts = BindInject(
  (i) => UsecaseContact(RepositoryContact(DatasourceContact()))
);