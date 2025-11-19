import 'dart:convert';

List<NewsList> newsListFromJson(String str) => List<NewsList>.from(json.decode(str).map((x) => NewsList.fromJson(x)));

String newsListToJson(List<NewsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsList {
    String model;
    String pk;
    Fields fields;

    NewsList({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;
    DateTime createdAt;
    int productViews;
    int user;

    Fields({
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.createdAt,
        required this.productViews,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
        productViews: json["product_views"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "created_at": createdAt.toIso8601String(),
        "product_views": productViews,
        "user": user,
    };
}
