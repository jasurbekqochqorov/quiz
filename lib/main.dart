import 'package:flutter/material.dart';

import 'App/app.dart';
import 'data/local/local.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.init();
  runApp(const App());
}
