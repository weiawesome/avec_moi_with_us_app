Map<int,String> genreIndexPair= {
    12:"冒險",
    14:"奇幻",
    16:"動畫",
    18:"劇情",
    27:"恐怖",
    28:"動作",
    35:"喜劇",
    36:"歷史",
    37:"西部",
    53:"驚悚",
    80:"犯罪",
    99:"紀錄",
    878:"科幻",
    9648:"懸疑",
    10402:"音樂",
    10749:"愛情",
    10751:"家庭",
    10752:"戰爭",
};

class PreferencePair {
    String value;
    int id;

    PreferencePair({required this.value, required this.id});

    factory PreferencePair.fromJson(Map<String, dynamic> json) {
        return PreferencePair(
            value: json['value'],
            id: json['id'],
        );
    }
}

class ResponsePreference {
    List<PreferencePair> pairs;

    ResponsePreference({required this.pairs});

    factory ResponsePreference.fromJson(Map<String, dynamic> json) {
        if (json["pairs"]==null){
            return ResponsePreference(pairs: []);
        }
        List<dynamic> jsonPairs = json['pairs'];
        List<PreferencePair> pairs = jsonPairs.map((pair) => PreferencePair.fromJson(pair)).toList();
        return ResponsePreference(pairs: pairs);
    }
}

class RequestPreference{
    List<int> genres;

    RequestPreference({required this.genres});

    Map<String,dynamic> formatJson(){
        return {
            "genres":genres
        };
    }
}



