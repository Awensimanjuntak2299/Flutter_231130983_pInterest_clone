import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Memuat semua post dari server
  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await ApiService.getPosts();
      _posts = fetched;
    } catch (e) {
      _error = 'Gagal memuat data: $e';
      _posts = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Memaksa refresh ulang data
  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  /// Menambahkan post baru ke awal list
  void addPost(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  /// Menghapus post berdasarkan ID
  void removePost(String id) {
    _posts.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  /// Memperbarui post yang ada di list
  void updatePost(PostModel updatedPost) {
    final index = _posts.indexWhere((p) => p.id == updatedPost.id);
    if (index != -1) {
      _posts[index] = updatedPost;
      notifyListeners();
    }
  }
}
