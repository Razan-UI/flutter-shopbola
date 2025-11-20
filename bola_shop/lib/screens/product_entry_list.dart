import 'package:flutter/material.dart';
import 'package:bola_shop/models/product_entry.dart';
import 'package:bola_shop/widgets/left_drawer.dart';
import 'package:bola_shop/screens/product_detail.dart';
import 'package:bola_shop/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  bool _showMyProductsOnly = false;
  late Future<int> _currentUserIdFuture;  

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    _currentUserIdFuture = _getCurrentUserId(request);
  }

  Future<int> _getCurrentUserId(CookieRequest request) async {
    try {
      final response = await request.get('http://127.0.0.1:8000/auth/whoami/');
      
      print('User info: $response');  
      
      if (response['is_authenticated']) {
        return response['user_id'];  
      }
      return -1;  
    } catch (e) {
      print('Error getting current user ID: $e');
      return -1;
    }
  }

  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    try {
      final response = await request.get('http://127.0.0.1:8000/json/');

      print('Response: $response');

      List<ProductEntry> listProduct = [];
      
      if (response is List) {
        for (var d in response) {
          if (d != null) {
            listProduct.add(ProductEntry.fromJson(d));
          }
        }
      }
      
      return listProduct;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showMyProductsOnly = !_showMyProductsOnly;
                  });
                  print('Filter toggled: $_showMyProductsOnly');
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: _showMyProductsOnly 
                      ? Colors.transparent
                      : Colors.transparent,
                    
                    border: Border.all(
                      color: const Color.fromARGB(179, 0, 0, 0),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _showMyProductsOnly ? Icons.people : Icons.person,
                        color: _showMyProductsOnly ? const Color.fromARGB(255, 0, 147, 233) : const Color.fromARGB(255, 21, 186, 6),
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _showMyProductsOnly ? 'All Products' : 'My Products',
                        style: TextStyle(
                          color: _showMyProductsOnly ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<int>(
        future: _currentUserIdFuture,
        builder: (context, userIdSnapshot) {
          if (userIdSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userIdSnapshot.hasError || !userIdSnapshot.hasData) {
            return const Center(child: Text('Error loading user info'));
          }

          int currentUserId = userIdSnapshot.data!;
          print('Current user ID: $currentUserId');

          return FutureBuilder<List<ProductEntry>>(
            future: fetchProduct(request),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productSnapshot.hasError) {
                return Center(
                  child: Text('Error: ${productSnapshot.error}'),
                );
              }

              if (!productSnapshot.hasData || productSnapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'There are no products available.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff59A5D8),
                        ),
                      ),
                    ],
                  ),
                );
              }

              List<ProductEntry> displayedProducts = productSnapshot.data!;
              
              if (_showMyProductsOnly) {
                displayedProducts = productSnapshot.data!
                    .where((product) => product.userId == currentUserId)
                    .toList();
                
                print('Filtered products: ${displayedProducts.length}');
              }

              if (displayedProducts.isEmpty && _showMyProductsOnly) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'You have no products yet.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff59A5D8),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: displayedProducts.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  prod: displayedProducts[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: displayedProducts[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}