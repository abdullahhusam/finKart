// app_router.dart
import 'package:finkart/features/auth/views/login_screen.dart';
import 'package:finkart/features/auth/views/sign_up_screen.dart';
import 'package:finkart/features/orders/views/order_details_screen.dart';
import 'package:finkart/features/shared/entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Define route paths
const String loginPath = '/login';
const String signUpPath = '/signUp';
const String entryPath = '/entry';
const String orderDetailsPath = '/orderDetails';

// Function to create a GoRouter instance based on the login status
GoRouter createRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: isLoggedIn ? entryPath : loginPath,
    routes: [
      GoRoute(
        path: loginPath,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: signUpPath,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: entryPath,
        builder: (context, state) => EntryScreen(),
      ),
      GoRoute(
        path: orderDetailsPath,
        builder: (context, state) => OrderDetailsScreen(),
      ),
    ],
  );
}
