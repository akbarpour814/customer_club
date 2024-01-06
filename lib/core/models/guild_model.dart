class GuildModel {
  int? id;
  String? name;
  String? slug;
  String? icon;

  GuildModel({this.id, this.name, this.slug, this.icon});

  factory GuildModel.fromJson(Map<String, dynamic> json) => GuildModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'icon': icon,
      };
}
