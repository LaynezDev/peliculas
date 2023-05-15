// To parse this JSON data, do
//
//     final streamingResponse = streamingResponseFromJson(jsonString);

import 'dart:convert';

class StreamingResponse {
  StreamingResponse({
    required this.id,
    required this.results,
  });

  int id;
  List<Results> results;

  factory StreamingResponse.fromRawJson(String str) =>
      StreamingResponse.fromJson(json.decode(str));

  factory StreamingResponse.fromJson(Map<String, dynamic> json) =>
      StreamingResponse(
        id: json["id"],
        results: List<Results>.from(json["results"]),
      );
}

class Results {
  Results({
    required this.gt,
  });

  List<GtStreaming> gt;

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        gt: List<GtStreaming>.from(
            json["results"]["GT"].map((x) => GtStreaming.fromJson(x))),
      );
  // factory Results.fromJson(Map<String, dynamic> json) => Results(
  //       gt: List<GtStreaming>.from(json["results"]["GT"]),
  //     );
}

class GtStreaming {
  GtStreaming({
    required this.link,
    required this.flatrate,
  });

  String link;
  List<Flatrate> flatrate;

  factory GtStreaming.fromRawJson(String str) =>
      GtStreaming.fromJson(json.decode(str));

  factory GtStreaming.fromJson(Map<String, dynamic> json) => GtStreaming(
        link: (json['results']['GT'] == null)
            ? ""
            : json['results']?['GT']?["link"],
        flatrate: List<Flatrate>.from((json['results']['GT'] == null ||
                    json['results']['GT']["flatrate"] == null
                ? []
                : json['results']['GT']["flatrate"])
            .map((x) => Flatrate.fromJson(x))),
      );
}

class Flatrate {
  Flatrate({
    required this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  String logoPath;
  int providerId;
  String providerName;
  int displayPriority;

  get fullPathStreaming {
    if (logoPath != null) return 'https://image.tmdb.org/t/p/w200$logoPath';
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Flatrate.fromRawJson(String str) =>
      Flatrate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Flatrate.fromJson(Map<String, dynamic> json) => Flatrate(
        logoPath: json["logo_path"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
        displayPriority: json["display_priority"],
      );

  Map<String, dynamic> toJson() => {
        "logo_path": logoPath,
        "provider_id": providerId,
        "provider_name": providerName,
        "display_priority": displayPriority,
      };
}
