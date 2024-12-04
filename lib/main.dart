import 'package:finkart/features/auth/models/user_model.dart';
import 'package:finkart/features/orders/view_models/order_details_view_model.dart';
import 'package:finkart/features/orders/views/orders_screen.dart';
import 'package:finkart/features/shared/entry_screen.dart';
import 'package:finkart/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart' as provider;
import 'package:sizer/sizer.dart';
import 'features/orders/repo/order_repo.dart';
import 'features/orders/view_models/orders_view_model.dart';
import 'features/shared/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open necessary boxes
  await Hive.openBox('authBox');
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<String>('sessionBox');
  final userBox = await Hive.openBox<User>('userBox');

  // Check if user is logged in
  final loggedInEmail = Hive.box<String>('sessionBox').get('loggedInEmail');
  final isLoggedIn =
      loggedInEmail != null && userBox.containsKey(loggedInEmail);

  print('User logged in: $isLoggedIn');

  // Run the app
  runApp(
    ProviderScope(
      child: MyApp(
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
          create: (_) => OrdersViewModel(OrdersRepository()),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => OrderDetailsViewModel(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          title: 'Gappy App',
          theme: ThemeData(
            fontFamily: 'Wavehaus',

            scaffoldBackgroundColor: screenBackgroundColor,
            // useMaterial3: true,
          ),
          // home: isLoggedIn ? Entry() : LoginPage(),
          routerConfig: createRouter(isLoggedIn),
        );
      }),
    );
  }
}
