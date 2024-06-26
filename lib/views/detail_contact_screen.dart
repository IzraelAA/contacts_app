import 'package:contacts_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/contacts_controller.dart';
import '../models/contact.dart';

enum DetailContentType { edit, create }

class DetailContactScreen extends StatefulWidget {
  final Contact contact;
  final int index;
  final DetailContentType contentType;

  const DetailContactScreen({
    super.key,
    required this.contact,
    required this.index,
    required this.contentType,
  });

  @override
  DetailContactScreenState createState() => DetailContactScreenState();
}

class DetailContactScreenState extends State<DetailContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.contact.firstName);
    _lastNameController = TextEditingController(text: widget.contact.lastName);
    _emailController = TextEditingController(text: widget.contact.email);
    _dobController = TextEditingController(text: widget.contact.dob);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsController =
        Provider.of<ContactsController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.contentType == DetailContentType.edit ? 'Edit' : 'Create'} Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.primary),
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedContact = Contact(
                        id: widget.contact.id,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        dob: _dobController.text,
                      );
                      if (widget.contentType == DetailContentType.edit) {
                        contactsController.updateContact(
                            widget.index, updatedContact);
                        Navigator.pop(context);
                      } else {
                        contactsController.addContact(updatedContact);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
