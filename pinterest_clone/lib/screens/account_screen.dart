import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> boards = const [
    {"title": "Papan 1", "pinCount": 13, "time": "1 mgg"},
    {"title": "Papan 2", "pinCount": 6, "time": "1 bulan"},
    {"title": "Papan 3", "pinCount": 4, "time": "1 bulan"},
    {"title": "Papan 4", "pinCount": 14, "time": "5 bulan"},
    {"title": "Papan 5", "pinCount": 168, "time": "2 bulan"},
    {"title": "Papan 6", "pinCount": 5, "time": "9 bulan"},
    {"title": "Papan 7", "pinCount": 42, "time": "3 bulan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ide tersimpan Anda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pin  |  Papan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: boards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  final board = boards[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[400],
                            ),
                            child: const Center(
                              child: Icon(Icons.image, size: 40, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          board["title"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${board["pinCount"]} Pin • ${board["time"]}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
