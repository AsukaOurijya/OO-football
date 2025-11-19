import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oofootball/models/product_entry.dart';
import 'package:oofootball/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key, this.onlyMine = false});

  final bool onlyMine;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static const String _productsUrl = 'http://localhost:8000/json/';
  late Future<List<NewsList>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<NewsList>> _fetchProducts() async {
    final response = await http.get(
      Uri.parse(_productsUrl),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat produk (status ${response.statusCode})');
    }

    final String decoded = utf8.decode(response.bodyBytes);
    return newsListFromJson(decoded);
  }

  Future<void> _refresh() async {
    setState(() {
      _productsFuture = _fetchProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final dynamic rawUserId = request.jsonData['id'];
    final int? currentUserId =
        rawUserId is int ? rawUserId : (rawUserId is String ? int.tryParse(rawUserId) : null);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? 'Koleksi Saya' : 'Daftar Produk'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<NewsList>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Terjadi kesalahan memuat data:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final List<NewsList> entries = snapshot.data ?? [];
            final List<NewsList> filtered = widget.onlyMine && currentUserId != null
                ? entries.where((entry) => entry.fields.user == currentUserId).toList()
                : entries;
            final List<NewsList> listToShow =
                filtered.isNotEmpty || !widget.onlyMine ? filtered : entries;

            if (listToShow.isEmpty) {
              return const Center(
                child: Text('Belum ada produk. Tambahkan lewat form.'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: listToShow.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = listToShow[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _showDetail(product),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (product.fields.thumbnail.isNotEmpty)
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              product.fields.thumbnail,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                              ),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey.shade100,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(strokeWidth: 2),
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.fields.name,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                    ),
                                  ),
                                  if (product.fields.isFeatured)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(Icons.star, color: Colors.amber),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('Rp ${product.fields.price} • ${product.fields.category}'),
                              const SizedBox(height: 2),
                              Text(
                                'Dilihat: ${product.fields.productViews}x',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDetail(NewsList entry) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.fields.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${entry.fields.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Kategori: ${entry.fields.category}'),
                const SizedBox(height: 8),
                Text(entry.fields.description),
                const SizedBox(height: 12),
                Text('Thumbnail: ${entry.fields.thumbnail}'),
                const SizedBox(height: 8),
                Text('Produk unggulan: ${entry.fields.isFeatured ? "Ya" : "Tidak"}'),
                const SizedBox(height: 8),
                Text('Dibuat: ${entry.fields.createdAt.toLocal()}'),
                const SizedBox(height: 8),
                Text('Jumlah dilihat: ${entry.fields.productViews}'),
                const SizedBox(height: 8),
                Text('ID Pemilik: ${entry.fields.user}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
