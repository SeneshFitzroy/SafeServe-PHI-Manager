import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../../../widgets/safe_serve_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
  bool isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) {
    // This is a placeholder for actual search functionality
    // You would replace this with your actual search logic
    setState(() {
      isSearching = query.isNotEmpty;
      if (query.isNotEmpty) {
        searchResults = [
          'Result 1: $query',
          'Result 2: $query',
          'Result 3: $query',
          'Result 4: $query',
          'Result 5: $query',
        ];
      } else {
        searchResults = [];
      }
    });
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
        height: 80,
        onMenuPressed: () {
          // Handle menu button press
          Scaffold.of(context).openDrawer();
        },
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
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF4964C7)),
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
                      icon: const Icon(Icons.tune, color: Color(0xFF4964C7)),
                      onPressed: () => _showSettingsMenu(context),
                      tooltip: 'Search Settings',
                    ),
                  ),
                ],
              ),
            ),
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
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF4964C7)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Color(0xFF4964C7)),
                            onPressed: () {
                              _searchController.clear();
                              performSearch('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isSearching && searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
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
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                              child: ListTile(
                                title: Text(searchResults[index]),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                onTap: () {
                                  // Handle result selection
                                },
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
