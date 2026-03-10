import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print("Fetching data...");

  final result = await fetchData();
  print("result: $result");

  // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  // try {
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "User-Agent":
  //           "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
  //       "Accept": "application/json",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List posts = jsonDecode(response.body);

  //     print("\n--- Success! Fetched ${posts.length} posts. Top 3: ---");
  //     for (var i = 0; i < 3; i++) {
  //       print("${i + 1}. ${posts[i]['title']}");
  //     }
  //   } else {
  //     print("Request failed with status: ${response.statusCode}");
  //     print("Error Message: ${response.body}");
  //   }
  // } catch (e) {
  //   print("An error occurred: $e");
  // }
}

Future<String> fetchData() async {
  final res = await Future.delayed(const Duration(milliseconds: 3000));
  print(res);
  return "Data fetched successfully";
}
