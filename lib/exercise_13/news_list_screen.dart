import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:my_exercise/exercise_13/models/article_model.dart';
import 'package:my_exercise/exercise_13/article_detail_screen.dart';
const String _placeholderImageUrl = 'https://images.pexels.com/photos/2882552/pexels-photo-2882552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<Article> _articles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    const String apiKey = '063d0b2921b2488c85b529f6acf5d854';
    const String country = 'us';
    const String category = 'technology';
    final String apiUrl = 'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        if (result['status'] == 'ok') {
          final List<dynamic> rawArticles = result['articles'];
          final List<Article> fetchedArticles = rawArticles
              .map((data) => Article.fromJson(data as Map<String, dynamic>))
              .where((article) => article.title != '[Removed]')
              .toList();
          setState(() {
            _articles = fetchedArticles;
            _isLoading = false;
          });
        } else {
          throw Exception('Lỗi từ API: ${result['message']}');
        }
      } else {
        throw Exception('Lỗi kết nối đến máy chủ: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }


  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Tin tức Công nghệ'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _isLoading ? null : _fetchNews,
          tooltip: 'Làm mới',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          appBar: _buildAppBar(scaffoldContext),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, color: Colors.redAccent, size: 60),
              const SizedBox(height: 16),
              const Text('Tải dữ liệu thất bại',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_error!, textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: _fetchNews,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Thử lại'))
            ],
          ),
        ),
      );
    }

    if (_articles.isEmpty) {
      return const Center(child: Text('Không tìm thấy bài viết nào.'));
    }

    return RefreshIndicator(
      onRefresh: _fetchNews,
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: _articles[index]);
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    String formattedDate = article.publishedAt != null
        ? DateFormat('dd/MM/yyyy, HH:mm').format(article.publishedAt!)
        : 'Không có ngày';

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ArticleDetailScreen.routeName,
            arguments: article,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.imageUrl ?? _placeholderImageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  _placeholderImageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            // --- KẾT THÚC THAY ĐỔI ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.sourceName, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700)),
                  const SizedBox(height: 8),
                  Text(article.title, style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text(formattedDate, style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}