import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newz_app/web%20_view_of_NEWZ/news_webview.dart';

class NewsFeed extends StatefulWidget {
  final Function(List)? onBookmarkChanged;
  final List bookmarkedArticles;

  const NewsFeed({
    super.key,
    this.onBookmarkChanged,
    required this.bookmarkedArticles,
  });

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List _articles = [];
  late Set<String> _bookmarkedTitles;
  late List _bookmarkedArticles;

  Future<void> fetchNews() async {
    const url =
        "https://newsapi.org/v2/everything?q=tesla&from=2025-05-06&sortBy=publishedAt&apiKey=4116e231b60844af8b76bf20725678ef";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    setState(() {
      _articles = json["articles"];
    });
  }

  @override
  void initState() {
    super.initState();
    _bookmarkedArticles = List.from(widget.bookmarkedArticles);
    _bookmarkedTitles = _bookmarkedArticles
        .map<String>((article) => article['title'].toString())
        .toSet();
    fetchNews();
  }

  void toggleBookmark(Map article) {
    final title = article['title'];
    setState(() {
      if (_bookmarkedTitles.contains(title)) {
        _bookmarkedTitles.remove(title);
        _bookmarkedArticles.removeWhere((item) => item['title'] == title);
      } else {
        _bookmarkedTitles.add(title);
        _bookmarkedArticles.add(article);
      }
    });
    widget.onBookmarkChanged?.call(_bookmarkedArticles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NEWS",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        centerTitle: true,
      ),
      body: _articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchNews,
        child: ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            final news = _articles[index];
            final image = news['urlToImage'] ?? 'https://via.placeholder.com/150';
            final title = news['title'] ?? 'No Title';
            final description = news['description'] ?? 'No Description';
            final source = news['source']['name'] ?? 'Unknown Source';
            final date = news['publishedAt'] ?? 'No Date';
            final url = news['url'] ?? 'https://newsapi.org';

            final isBookmarked = _bookmarkedTitles.contains(title);

            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://via.placeholder.com/300x200?text=No+Image',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () => toggleBookmark(news),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(description),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Source: $source | Published at: $date",
                      style:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsWebView(url: url),
                          ),
                        );
                      },
                      child: Text(
                        url,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
