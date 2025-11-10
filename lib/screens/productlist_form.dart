import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oofootball/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  final List<String> _categories = <String>[
    'Baju',
    'Sepatu',
    'Merchendise',
    'Bola',
  ];

  String? _selectedCategory;
  bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  hintText: 'Contoh: Sepatu Futsal Precision 5',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama produk wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  hintText: 'Masukkan angka tanpa titik/koma',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  final int? parsedPrice = int.tryParse(value);
                  if (parsedPrice == null) {
                    return 'Harga harus berupa angka';
                  }
                  if (parsedPrice <= 0) {
                    return 'Harga harus lebih besar dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                ),
                items: _categories
                    .map(
                      (String category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  alignLabelWithHint: true,
                  hintText: 'Tuliskan detail produk secara singkat',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi wajib diisi';
                  }
                  if (value.trim().length < 10) {
                    return 'Deskripsi minimal 10 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _thumbnailController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'URL Thumbnail',
                  hintText: 'https://contoh.com/gambar-produk.jpg',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'URL thumbnail wajib diisi';
                  }
                  final Uri? uri = Uri.tryParse(value.trim());
                  final bool isValidUri = uri != null &&
                      (uri.isScheme('http') || uri.isScheme('https')) &&
                      uri.host.isNotEmpty;
                  if (!isValidUri) {
                    return 'Masukkan URL yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tampilkan sebagai produk unggulan'),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final String name = _nameController.text.trim();
    final int price = int.parse(_priceController.text.trim());
    final String description = _descriptionController.text.trim();
    final String thumbnail = _thumbnailController.text.trim();
    final String category = _selectedCategory ?? '-';
    final bool isFeatured = _isFeatured;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Produk Berhasil Disimpan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryRow('Nama', name),
              _buildSummaryRow('Harga', 'Rp $price'),
              _buildSummaryRow('Kategori', category),
              _buildSummaryRow('Unggulan', isFeatured ? 'Ya' : 'Tidak'),
              const SizedBox(height: 8),
              const Text(
                'Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(description),
              const SizedBox(height: 8),
              const Text(
                'Thumbnail',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(thumbnail),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    _resetForm();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Produk $name tersimpan.')),
      );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _thumbnailController.clear();
    setState(() {
      _selectedCategory = null;
      _isFeatured = false;
    });
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
