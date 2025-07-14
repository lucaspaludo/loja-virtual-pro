import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/firebase_options.dart';
import 'package:loja_virtual_pro/models/admin_users_manager.dart';
import 'package:loja_virtual_pro/models/cart_manager.dart';
import 'package:loja_virtual_pro/models/home_maneger.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/models/product_manager.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/screens/base/base_screen.dart';
import 'package:loja_virtual_pro/screens/cart/cart_screen.dart';
import 'package:loja_virtual_pro/screens/edit_product/edit_product_screen.dart';
import 'package:loja_virtual_pro/screens/login/login_screen.dart';
import 'package:loja_virtual_pro/screens/product/product_screen.dart';
import 'package:loja_virtual_pro/screens/signUp/sign_up_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
        )
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
                // ignore: cast_nullable_to_non_nullable
                builder: (_) => ProductScreen(settings.arguments as Product),
              );

            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/cart':
              return MaterialPageRoute(builder: (_) => const CartScreen());

            case '/edit_product':
              final product = settings.arguments as Product?;
              // ignore: cast_nullable_to_non_nullable
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(product),
              );

            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
