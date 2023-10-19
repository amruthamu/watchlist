class WatchlistData {
  final String id;
  final String name;
  final String contacts;
  String? url;

  WatchlistData({
    required this.id,
    required this.name,
    required this.contacts,
    this.url,
  });

  factory WatchlistData.fromJson(Map<String, dynamic> json) {
    return WatchlistData(
        id: json['id'],
        name: json['name'],
        contacts: json['Contacts'],
        url: json['url']);
  }
}
