import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../widgets/post_card.dart';
import 'add_post_screen.dart';
import 'edit_post_screen.dart';
import 'discover_screen.dart';
import 'pembaruan_screen.dart';
import 'chat_screen.dart';
import 'account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostModel>> futurePosts;
  List<PostModel> _filteredPosts = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    futurePosts = ApiService.getPosts();
    final posts = await futurePosts;
    setState(() {
      _filteredPosts = posts;
    });
  }

  void refreshPosts() async {
    final posts = await ApiService.getPosts();
    setState(() {
      _filteredPosts = posts;
    });
  }

  void deletePost(String id) async {
    final success = await ApiService.deletePost(id);
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post berhasil dihapus')),
      );
      refreshPosts();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus post')),
      );
    }
  }

  void _onSearchChanged(String query, List<PostModel> allPosts) {
    final results = allPosts
        .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredPosts = results;
    });
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return FutureBuilder<List<PostModel>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (_filteredPosts.isEmpty) {
              return const Center(child: Text('Belum ada post.'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return PostCard(
                  post: post,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPostScreen(post: post),
                      ),
                    ).then((_) => refreshPosts());
                  },
                  onDelete: () {
                    if (post.id != null && post.id!.isNotEmpty) {
                      deletePost(post.id!);
                    }
                  },
                );
              },
            );
          },
        );

      case 1:
        return const DiscoverScreen();
      case 2:
        return const PembaruanScreen();
      case 3:
        return const ChatScreen();
      case 4:
        return const AccountScreen();
      default:
        return const Center(child: Text('Halaman tidak ditemukan'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        titleSpacing: 0,
        title: Row(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/0/08/Pinterest-logo.png',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'Pinterest Clone',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: _selectedIndex == 0
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                      ),
                      onChanged: (value) async {
                        final allPosts = await futurePosts;
                        _onSearchChanged(value, allPosts);
                      },
                    ),
                  ),
                ),
              ]
            : null,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _buildBody(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPostScreen()),
                ).then((_) => refreshPosts());
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.grey[100],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Pembaruan'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Akun'),
        ],
      ),
    );
  }
}
