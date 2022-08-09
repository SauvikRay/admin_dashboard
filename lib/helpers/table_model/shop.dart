class Shop {
  int id;
  String name;
  String slug;
  String balance;
  int restaurantGroupId;
  int userId;
  String adminCommission;
  int status;
  String featuredImage;

  Shop({
    required this.id,
    required this.name,
    required this.slug,
    required this.balance,
    required this.restaurantGroupId,
    required this.userId,
    required this.adminCommission,
    required this.status,
    required this.featuredImage,
  });
}
