import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String customer;
  final String dateTime;
  final List<Map<String, dynamic>> products;
  final double totalPrice;
  final String serviceOption;
  final String? address; // Alamat opsional jika serviceOption == 'Delivery'
  final String status; // Status pesanan tambahan

  Order({
    required this.customer,
    required this.dateTime,
    required this.products,
    required this.totalPrice,
    required this.serviceOption,
    this.address,
    required this.status,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Order(
      customer: data['customer'] ?? '',
      dateTime: data['dateTime'] ?? '',
      products: List<Map<String, dynamic>>.from(data['products'] ?? []),
      totalPrice: data['totalPrice'] ?? 0.0,
      serviceOption: data['serviceOption'] ?? '',
      address: data['address'],
      status: data['status'] ?? 'N/A', // Mengambil status dari Firestore
    );
  }
}
