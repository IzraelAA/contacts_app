import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/contact.dart';

class ContactsController with ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  List<Contact> get contacts => _filteredContacts;

  Future<void> loadContacts() async {
    final String response = await rootBundle.loadString('assets/json/data.json');
    final data = await json.decode(response) as List;
    _contacts = data.map((contact) => Contact.fromJson(contact)).toList();
    _filteredContacts = _contacts;
    notifyListeners();
  }

  void updateContact(int index, Contact updatedContact) {
    _contacts[index] = updatedContact;
    _filteredContacts = _contacts;
    notifyListeners();
  }

  void addContact(Contact newContact) {
    _contacts.add(newContact);
    _filteredContacts = _contacts;
    notifyListeners();
  }

  void filterContacts(String query) {
    if (query.isEmpty) {
      _filteredContacts = _contacts;
    } else {
      _filteredContacts = _contacts
          .where((contact) =>
      contact.firstName.toLowerCase().contains(query.toLowerCase()) ||
          contact.lastName.toLowerCase().contains(query.toLowerCase()) ||
          (contact.email.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    }
    notifyListeners();
  }
}
