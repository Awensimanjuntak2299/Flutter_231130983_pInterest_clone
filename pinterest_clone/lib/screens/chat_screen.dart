import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> users = const [
    {'name': 'User 1', 'username': '@user1'},
    {'name': 'User 2', 'username': '@user2'},
    {'name': 'User 3', 'username': '@user3'},
    {'name': 'User 4', 'username': '@user4'},
    {'name': 'User 5', 'username': '@user5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.edit, color: Colors.red),
            title: Text('Pesan baru', style: TextStyle(color: Colors.red)),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Pesan', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('S')),
            title: const Text('Shido'),
            subtitle: const Text('📌 Mengirim Pin'),
            trailing: const Text('1 thn'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Disarankan', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...users.map((user) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(user['name']!),
                subtitle: Text(user['username']!),
              )),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person_add_alt)),
            title: const Text('Undang teman-teman Anda'),
            subtitle: const Text('Hubungkan untuk mulai mengobrol'),
          )
        ],
      ),
    );
  }
}
