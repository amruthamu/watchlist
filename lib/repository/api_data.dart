import 'dart:convert';
import 'package:http/http.dart';
import 'package:watchlist/repository/api_mapper_class.dart';
import 'package:watchlist/constant/constants.dart';


class FetchApi {
  String url = Constants.apiUrl;
  Future<List<WatchlistData>> getDataList() async {
    Response resp = await get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final List result = jsonDecode(resp.body);
      return result.map((e) => WatchlistData.fromJson(e)).toList();
    } else {
      throw Exception(resp.reasonPhrase);
    }
  }
}
