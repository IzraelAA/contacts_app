import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/contacts_controller.dart';
import 'views/list_contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactsController()..loadContacts(),
      child: MaterialApp(
        title: 'Contacts App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: ListContactScreen(),
      ),
    );
  }
}
