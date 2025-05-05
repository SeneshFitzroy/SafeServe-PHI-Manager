import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../../widgets/safe_serve_drawer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;
  bool hasError = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) async {
    setState(() {
      isSearching = query.isNotEmpty;
      searchResults = [];
      hasError = false;
    });

    if (query.isEmpty) return;

    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('shops').get();
      final lowercaseQuery = query.toLowerCase();
      setState(() {
        searchResults = snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .where((shop) =>
            (shop['name'] ?? '').toString().toLowerCase().contains(lowercaseQuery))
            .toList();
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Search Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Search History'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to search history
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('Filter Options'),
              onTap: () {
                Navigator.pop(context);
                // Show filter options
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Advanced Search'),
              onTap: () {
                Navigator.pop(context);
                // Show advanced search options
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
      ),
      endDrawer: const SafeServeDrawer(
        profileImageUrl: '',
        userName: '',
        userPost: '',
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4964C7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/other/logo.png',
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.shield, color: Colors.white, size: 60),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SafeServe Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Notes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
          ),
        ),
        child: Column(
          children: [
            // Back, Title, Settings row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDE6FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF4964C7)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Text(
                      'Search Records',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDE6FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.tune,
                          color: Color(0xFF4964C7)),
                      onPressed: () => _showSettingsMenu(context),
                      tooltip: 'Search Settings',
                    ),
                  ),
                ],
              ),
            ),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCDE6FE),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1F41BB),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: performSearch,
                  decoration: InputDecoration(
                    hintText: 'Type Here.....',
                    hintStyle: const TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 18,
                    ),
                    prefixIcon: const Icon(Icons.search,
                        color: Color(0xFF4964C7)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear,
                          color: Color(0xFF4964C7)),
                      onPressed: () {
                        _searchController.clear();
                        performSearch('');
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Results list
            Expanded(
              child: isSearching && searchResults.isEmpty && !hasError
                  ? const Center(child: CircularProgressIndicator())
                  : hasError
                  ? const Center(
                child: Text(
                  'Error fetching results',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              )
                  : !isSearching
                  ? const Center(
                child: Text(
                  'Start typing to search',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
                  : searchResults.isEmpty
                  ? const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final shop = searchResults[index];
                  return Card(
                    margin:
                    const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: SizedBox(
                      height: 100, // ↑ taller card
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding:
                        const EdgeInsets.all(12),
                        leading: shop['image'] != null
                            ? ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              10),
                          child: Image.network(
                            shop['image'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context,
                                error,
                                stackTrace) =>
                            const Icon(
                                Icons.store,
                                size: 70),
                          ),
                        )
                            : const Icon(Icons.store,
                            size: 70),
                        title: Text(
                          shop['name'] ?? 'Unknown Shop',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              shop['address'] ??
                                  'No address',
                              maxLines: 1,
                              overflow:
                              TextOverflow.ellipsis,
                            ),
                            if (shop['typeOfTrade'] !=
                                null) ...[
                              const SizedBox(height: 2),
                              Text(
                                shop['typeOfTrade'],
                                style: const TextStyle(
                                    fontStyle:
                                    FontStyle.italic),
                              ),
                            ],
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/shop_detail',
                            arguments: shop['id'],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
