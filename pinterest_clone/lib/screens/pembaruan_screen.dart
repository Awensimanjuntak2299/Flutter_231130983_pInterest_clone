import 'package:flutter/material.dart';

class PembaruanScreen extends StatelessWidget {
  const PembaruanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembaruan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Dilihat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildUpdateItem('Navia Genshin', 'Masih mencari? Jelajahi ide yang terkait dengan Navia'),
          _buildUpdateItem('Raiden Ei', 'Raiden Ei untuk Anda'),
          _buildUpdateItem('Gaya cocok', 'Gaya ini cocok banget sama kamu'),
          // Tambahkan item lainnya jika diperlukan
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String title, String subtitle) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.image_not_supported, size: 24, color: Colors.grey),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Text('3 jam', style: TextStyle(color: Colors.grey)),
    );
  }
}
