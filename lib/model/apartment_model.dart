class ApartmentModel {
  final int id;
  final String? city;
  final String? governorate;
  final int? rentPrice;
  final int? apartmentSpace;
  final int? rooms;
  final int? floor;
  final int? bathrooms;
  final String? apartmentImage;

  ApartmentModel({
    required this.id,
    required this.city,
    required this.governorate,
    required this.rentPrice,
    required this.apartmentSpace,
    required this.rooms,
    required this.floor,
    required this.bathrooms,
    required this.apartmentImage,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    final apartment = json;
    return ApartmentModel(
      id: apartment['id'],
      city: apartment['city'],
      governorate: apartment['Governorate'],
      rentPrice: apartment['rent_price'],
      apartmentSpace: apartment['apartment_space'],
      rooms: apartment['rooms'],
      floor: apartment['floor'],
      bathrooms: apartment['bathrooms'],
      apartmentImage: apartment['apartment_image'],
    );
  }
}
