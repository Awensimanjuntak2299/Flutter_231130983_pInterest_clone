import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../utils/constants.dart';

class ApiService {
  // GET all posts
  static Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // POST create a new post
  static Future<bool> addPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': post.title,
        'description': post.description,
        'imageUrl': post.imageUrl,
        'userId': post.userId, // optional jika kamu ingin pakai user
      }),
    );

    return response.statusCode == 201;
  }

  // PUT update a post
  static Future<bool> updatePost(PostModel post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': post.title,
        'description': post.description,
        'imageUrl': post.imageUrl,
        'userId': post.userId,
      }),
    );

    return response.statusCode == 200;
  }

  // DELETE a post
  static Future<bool> deletePost(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    return response.statusCode == 200;
  }

  // PATCH alias editPost (bisa langsung pakai updatePost juga)
  static Future<void> editPost(PostModel post) async {
    final success = await updatePost(post);
    if (!success) {
      throw Exception('Gagal memperbarui post');
    }
  }

  // LOGIN
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    return response.statusCode == 200;
  }

  // REGISTER
  static Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    return response.statusCode == 201;
  }
}
