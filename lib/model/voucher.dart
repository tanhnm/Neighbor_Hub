class Voucher {
  final int voucherId;
  final String code;
  final String description;
  final double discount;
  final String imageUrl; // Add an image property
  final String expiryDate; // Add an image property

  Voucher(
      {required this.voucherId,
      required this.code,
      required this.description,
      required this.discount,
      required this.imageUrl,
      required this.expiryDate});
}
