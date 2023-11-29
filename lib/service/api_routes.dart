class ApiRoutes{
  static const String apiBaseUrl="http://127.0.0.1:8080/api/v1/";

  static const String userInformationUrl="${apiBaseUrl}user";
  static const String signupUrl="${apiBaseUrl}user/signup";
  static const String loginUrl="${apiBaseUrl}user/login";
  static const String editInformationUrl="${apiBaseUrl}user/edit_info";
  static const String editPasswordUrl="${apiBaseUrl}user/edit_password";
  static const String logoutUrl="${apiBaseUrl}user/logout";
  static const String preferenceUrl="${apiBaseUrl}user/preference";
  static const String preferenceTypeUrl="${apiBaseUrl}user/preference/type";

  static const String movieUrl="${apiBaseUrl}/movie";
  static const String recentlyHotUrl="${apiBaseUrl}/movie/recently_hot";
  static const String recentlyViewUrl="${apiBaseUrl}/movie/recently_view";
  static const String recommendUrl="${apiBaseUrl}/movie/recommend";
  static const String likeUrl="${apiBaseUrl}/movie/like";
  static const String searchUrl="${apiBaseUrl}/movie/search";
}