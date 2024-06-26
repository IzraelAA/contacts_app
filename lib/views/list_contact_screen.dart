import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/utils/app_color.dart';
import 'package:contacts_app/views/detail_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/contacts_controller.dart';

class ListContactScreen extends StatelessWidget {
  const ListContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsController = Provider.of<ContactsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColor.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailContactScreen(
                    contact: Contact(id: "", firstName: "", lastName: ""),
                    contentType: DetailContentType.create,
                    index: 0,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                contactsController.filterContacts(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: contactsController.loadContacts,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 4.0, // Horizontal space between items
                  mainAxisSpacing: 4.0, // Vertical space between items
                  childAspectRatio: 1, // Ratio to make items rectangular (adjust as needed)
                ),
                itemCount: contactsController.contacts.length,
                itemBuilder: (context, index) {
                  final contact = contactsController.contacts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailContactScreen(
                            contact: contact,
                            contentType: DetailContentType.edit,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: AppColor.primary,
                            ),
                            Text(
                              '${contact.firstName} ${contact.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (contact.email.isNotEmpty)
                              Text(
                                contact.email,
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
