class CategoriesHelpModel {
  int? id;
  String? appName;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? parentId;

  CategoriesHelpModel(
      {this.id,
      this.appName,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.parentId});

  CategoriesHelpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = json['parent_id'] ?? 0;
  }
}

class TopicsHelpModel {
  int? id;
  String? title;
  String? content;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  TopicsHelpModel(
      {this.id,
      this.title,
      this.content,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  TopicsHelpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class CategoriesTopicsHelpModel {
  final bool error;
  final List<TopicsHelpModel> topics;
  final List<CategoriesHelpModel> categories;

  CategoriesTopicsHelpModel({
    required this.error,
    required this.topics,
    required this.categories,
  });

  factory CategoriesTopicsHelpModel.fromJson(Map<String, dynamic> json) {
    var topicList = (json['topics'] as List)
        .map((i) => TopicsHelpModel.fromJson(i))
        .toList();
    var categoryList = (json['categories'] as List)
        .map((i) => CategoriesHelpModel.fromJson(i))
        .toList();

    return CategoriesTopicsHelpModel(
      error: json['error'],
      topics: topicList,
      categories: categoryList,
    );
  }
}
