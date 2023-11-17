import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/carManager.dart';
import 'package:loja_virtual_pro/models/productManager.dart';
import 'package:loja_virtual_pro/models/userManager.dart';
import 'package:loja_virtual_pro/screens/base/baseScreen.dart';
import 'package:loja_virtual_pro/screens/cart/cartScreen.dart';
import 'package:loja_virtual_pro/screens/login/loginScreen.dart';
import 'package:loja_virtual_pro/screens/product/productScreen.dart';
import 'package:loja_virtual_pro/screens/signUp/signUpScreen.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => 
            cartManager!..updateUser(userManager),
          ),
      ],
      child: MaterialApp(
        title: 'Loja do Lucas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());

            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));

            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());

            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());

            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());

            
          }
        },
      ),
    );
  }
}
