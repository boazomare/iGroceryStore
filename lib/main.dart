// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onlinegrocery/consts/theme_data.dart';
import 'package:onlinegrocery/inner_screens/cat_screen.dart';
import 'package:onlinegrocery/inner_screens/feeds_screen.dart';
import 'package:onlinegrocery/inner_screens/on_sale_screen.dart';
import 'package:onlinegrocery/inner_screens/product_details.dart';
import 'package:onlinegrocery/providers/cart_provider.dart';
import 'package:onlinegrocery/providers/dark_theme_provider.dart';
import 'package:onlinegrocery/providers/orders_provider.dart';
import 'package:onlinegrocery/providers/products_provider.dart';
import 'package:onlinegrocery/providers/viewed_prod_provider.dart';
import 'package:onlinegrocery/providers/wishlist_provider.dart';
import 'package:onlinegrocery/screens/auth/forget_pass.dart';
import 'package:onlinegrocery/screens/auth/login.dart';
import 'package:onlinegrocery/screens/auth/register.dart';
import 'package:onlinegrocery/screens/btm_bar.dart';
import 'package:onlinegrocery/screens/home_screen.dart';
import 'package:onlinegrocery/screens/orders/orders_screen.dart';
import 'package:onlinegrocery/screens/viewed_recently/viewed_recently.dart';
import 'package:onlinegrocery/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const BottomBarScreen(),
          routes: {
            OnSaleScreen.routeName: (context) => const OnSaleScreen(),
            FeedsScreen.routeName: (context) => const FeedsScreen(),
            ProductDetails.routeName: (ctx) => const ProductDetails(),
            WishlistScreen.routeName: (ctx) => const WishlistScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            ViewedRecentlyScreen.routeName: (ctx) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            ForgetPasswordScreen.routeName: (ctx) =>
                const ForgetPasswordScreen(),
            CategoryScreen.routeName: (ctx) => const CategoryScreen(),
          },
        );
      }),
    );
  }
}
