class Voucher {
  final String title;
  final String description;
  final double discount;
  final String imageUrl; // Add an image property

  Voucher(
      {required this.title,
      required this.description,
      required this.discount,
      required this.imageUrl});
}
