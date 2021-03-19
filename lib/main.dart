import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/pages/loading_page.dart';
import 'package:happy_postcode_flutter/pages/main_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'components/app_theme.dart';

void main() async {
  await DotEnv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new ThemeChanger(2),
        ),
        ChangeNotifierProvider(
          create: (_) => new AddressProvider(),
        ),
      ],
      child: FlexDeliveryApp(),
    ),
  );
}

class FlexDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Delivery',
      home: LoadingPage(),
      routes: {
        'home': (_) => MainPage(),
        'loading': (_) => LoadingPage(),
      },
      theme: currentTheme,
    );
  }
}
