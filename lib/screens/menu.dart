import 'package:flutter/material.dart';
import 'package:oofootball/screens/productlist_form.dart';
import 'package:oofootball/widgets/left_drawer.dart';

enum MenuAction { viewAll, myProducts, addProduct }

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String nama = "Muhammad Azka Awliya";
  final String npm = "2406431510";
  final String kelas = "C";

  final List<ItemHomePage> items = const [
    ItemHomePage("Semua Produk", Icons.sports_soccer, Colors.blue, MenuAction.viewAll),
    ItemHomePage("Koleksi Saya", Icons.list, Colors.green, MenuAction.myProducts),
    ItemHomePage("Tambah Produk", Icons.add, Colors.red, MenuAction.addProduct),
  ];

  void _handleMenuSelection(BuildContext context, ItemHomePage item) {
    switch (item.action) {
      case MenuAction.addProduct:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProductFormPage()),
        );
        break;
      case MenuAction.viewAll:
      case MenuAction.myProducts:
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text("Kamu memilih menu ${item.name}.")),
          );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OO Football',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: "NPM: ", content: npm),
                InfoCard(title: "Nama: ", content: nama),
                InfoCard(title: "Kelas: ", content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            Center(
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to OO Football',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,

                    children: items.map((ItemHomePage item) {
                      return ItemCard(
                        item: item,
                        onTap: () => _handleMenuSelection(context, item),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomePage {
  final String name;
  final IconData icon;
  final Color color;
  final MenuAction action;

  const ItemHomePage(this.name, this.icon, this.color, this.action);
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}


class ItemCard extends StatelessWidget {
  final ItemHomePage item;
  final VoidCallback onTap;

  const ItemCard({required this.item, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
