class AppConfigModel {
  String? websitePathAddress;
  String? appPathHome;
  String? appNameEn;
  String? appNameFa;
  String? appEmailContact;
  String? appFavicon;
  String? appLogo;
  String? appVersionCompile;
  String? appFontContent;
  String? appFontSizeTitle;
  String? colorMasterApp;
  String? colorClientApp;

  AppConfigModel({
    this.websitePathAddress,
    this.appPathHome,
    this.appNameEn,
    this.appNameFa,
    this.appEmailContact,
    this.appFavicon,
    this.appLogo,
    this.appVersionCompile,
    this.appFontContent,
    this.appFontSizeTitle,
    this.colorMasterApp,
    this.colorClientApp,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      websitePathAddress: json['website_path_address'] as String?,
      appPathHome: json['app_path_home'] as String?,
      appNameEn: json['app_name_en'] as String?,
      appNameFa: json['app_name_fa'] as String?,
      appEmailContact: json['app_email_contact'] as String?,
      appFavicon: json['app_favicon'] as String?,
      appLogo: json['app_logo'] as String?,
      appVersionCompile: json['app_version_compile'] as String?,
      appFontContent: json['app_font_content'] as String?,
      appFontSizeTitle: json['app_font_size_title'] as String?,
      colorMasterApp: json['color_master_app'] as String?,
      colorClientApp: json['color_client_app'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'website_path_address': websitePathAddress,
        'app_path_home': appPathHome,
        'app_name_en': appNameEn,
        'app_name_fa': appNameFa,
        'app_email_contact': appEmailContact,
        'app_favicon': appFavicon,
        'app_logo': appLogo,
        'app_version_compile': appVersionCompile,
        'app_font_content': appFontContent,
        'app_font_size_title': appFontSizeTitle,
        'color_master_app': colorMasterApp,
        'color_client_app': colorClientApp,
      };
}
