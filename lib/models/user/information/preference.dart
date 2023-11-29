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
void main(){
  print(genreIndexPair.length);
  print((genreIndexPair.keys.toList())[0]);
}