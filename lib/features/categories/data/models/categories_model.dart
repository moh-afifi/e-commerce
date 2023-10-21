class CategoriesModel {
  int? statusCode;
  String? message;
  late final List<Group> groupsList;

  CategoriesModel({this.statusCode, this.message, this.groupsList = const []});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    groupsList = <Group>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        groupsList.add(Group.fromJson(v));
      });
    }
  }
}

class Group {
  String? id;
  String? label;
  String? parentItemGroup;
  String? image;
  late final List<Category> categoriesList;

  Group({
    this.id,
    this.label,
    this.parentItemGroup,
    this.image,
    this.categoriesList = const [],
  });

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    parentItemGroup = json['parent_item_group'];
    image = json['image'];
    categoriesList = <Category>[];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        categoriesList.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  String? id;
  String? label;
  String? parentItemGroup;
  String? image;
  late final List<SubCategory> subCategoriesList;

  Category({
    this.id,
    this.label,
    this.parentItemGroup,
    this.image,
    this.subCategoriesList = const [],
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    parentItemGroup = json['parent_item_group'];
    image = json['image'];
    subCategoriesList = <SubCategory>[];
    if (json['sub_categories'] != null) {
      json['sub_categories'].forEach((v) {
        subCategoriesList.add(SubCategory.fromJson(v));
      });
    }
  }
}

class SubCategory {
  String? id;
  String? label;
  String? image;

  SubCategory({this.id, this.label, this.image});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    image = json['image'];
  }
}
