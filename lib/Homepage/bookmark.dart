import 'package:flutter/material.dart';
import 'package:newz_app/web%20_view_of_NEWZ/news_webview.dart';

class BookmarkPage extends StatelessWidget {
  final List bookmarkedArticles;
  final Function(List) onBookmarkChanged;

  const BookmarkPage({
    super.key,
    required this.bookmarkedArticles,
    required this.onBookmarkChanged,
  });

  void toggleBookmark(BuildContext context, Map article) {
    final title = article['title'];
    final updatedBookmarks = List<Map>.from(bookmarkedArticles);

    if (updatedBookmarks.any((a) => a['title'] == title)) {
      updatedBookmarks.removeWhere((a) => a['title'] == title);
    } else {
      updatedBookmarks.add(article);
    }

    onBookmarkChanged(updatedBookmarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Articles"),
        centerTitle: true,
      ),
      body: bookmarkedArticles.isEmpty
          ? const Center(child: Text("No bookmarks yet."))
          : ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          final image = article['urlToImage'] ?? 'https://via.placeholder.com/150';
          final title = article['title'] ?? 'No Title';
          final description = article['description'] ?? 'No Description';
          final source = article['source']['name'] ?? 'Unknown Source';
          final date = article['publishedAt'] ?? 'No Date';

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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          toggleBookmark(context, article);
                        },
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
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsWebView(url: article['url']),
                        ),
                      );
                    },
                    child: Text(
                      article['url'] ?? '',
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
    );
  }
}
