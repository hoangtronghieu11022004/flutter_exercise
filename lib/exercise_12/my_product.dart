import 'package:my_exercise/exercise_12/product.dart';
import 'package:flutter/material.dart';
import 'package:my_exercise/exercise_12/api.dart';

final ProductAPI testAPI = ProductAPI();

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {

  AppBar _buildSearchAppBar(BuildContext context) {
    void openDrawer() {
      Scaffold.of(context).openDrawer();
    }
    const Color headerColor = Colors.deepPurple;
    const Color searchBarColor = Colors.orange;

    return AppBar(
      backgroundColor: headerColor,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: openDrawer,
      ),

      title: const Text('Bài 12: Danh sách Sản phẩm',
          style: TextStyle(color: Colors.white, fontSize: 18)),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: Container(
          color: searchBarColor,
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () { },
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ),


              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Tìm kiếm sản phẩm...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none, // Xóa border mặc định của TextField
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {  },
                icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth > 600) ? 4 : 2;

    return Builder(
        builder: (context) {
          return Scaffold(
            appBar: _buildSearchAppBar(context),
            backgroundColor: Colors.grey[200],
            body: FutureBuilder<List<Product>?>(
              future: testAPI.getAllProduct(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  if (snap.hasData) {
                    return myGridView(snap.data!, crossAxisCount);
                  } else {
                    return const Center(child: Text("Không thể tải dữ liệu."));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        }
    );
  }

  Widget myGridView(List<Product> ls, int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: ls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return myItem(ls[index]);
      },
    );
  }

  Widget myItem(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.network(
                p.image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
              ),
            ),
          ),
          // Thông tin
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Tiêu đề
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  // Đánh giá sao
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      // Hiển thị rate
                      Text(
                        '${p.rating.rate}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  // Giá và Số lượng đã bán
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Giá
                      Text(
                        '${p.price} \$',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Số lượng đã bán
                      Text(
                        'Đã bán ${p.rating.count}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}