import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allRecords = [];
  List<Map<String, dynamic>> _filteredRecords = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize with dummy data
    _allRecords = [
      {
        "id": "001",
        "name": "McDonald's - Downtown",
        "address": "123 Main St",
        "status": "Passed",
        "date": "2023-09-15",
      },
      {
        "id": "002",
        "name": "Subway - Riverside",
        "address": "456 River Ave",
        "status": "Conditional Pass",
        "date": "2023-09-10",
      },
      {
        "id": "003",
        "name": "Pizza Hut - Westfield",
        "address": "789 West Blvd",
        "status": "Failed",
        "date": "2023-09-05",
      },
      {
        "id": "004",
        "name": "Starbucks - Central",
        "address": "101 Central Square",
        "status": "Passed",
        "date": "2023-09-01",
      },
      {
        "id": "005",
        "name": "Tim Hortons - Eastside",
        "address": "202 East Road",
        "status": "Passed",
        "date": "2023-08-28",
      },
    ];
    _filteredRecords = _allRecords;
    
    // Add listener to search field
    _searchController.addListener(_filterRecords);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecords() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRecords = _allRecords;
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredRecords = _allRecords.where((record) {
          return record['name'].toLowerCase().contains(query) ||
              record['id'].toLowerCase().contains(query) ||
              record['address'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // Get color based on status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
        return Colors.green;
      case 'conditional pass':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [const Color(0xFFE6F5FE), const Color(0xFFF5ECF9)],
            ),
          ),
          child: Stack(
            children: [
              // App bar with SafeServe text
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              // Navigation bar at bottom
              Positioned(
                left: 47,
                top: 817,
                child: Container(
                  width: 318,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home_outlined, color: Color(0xFF1F41BB)),
                        onPressed: () {
                          // Navigate to home
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Color(0xFF1F41BB), size: 30),
                        onPressed: null, // Current page
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Color(0xFF1F41BB)),
                        onPressed: () {
                          // Navigate to add page
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person_outline, color: Color(0xFF1F41BB)),
                        onPressed: () {
                          // Navigate to profile
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // SafeServe text
              Positioned(
                left: 78,
                top: 44,
                child: Text(
                  'SafeServe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Top right buttons
              Positioned(
                left: 299,
                top: 41,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFCDE6FE),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Color(0xFF1F41BB),
                    size: 20,
                  ),
                ),
              ),
              Positioned(
                left: 349,
                top: 41,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF1F41BB),
                    size: 20,
                  ),
                ),
              ),
              // Logo
              Positioned(
                left: 33,
                top: 35,
                child: Container(
                  width: 36,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/other/logo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              // Search box
              Positioned(
                left: 32,
                top: 193,
                child: Container(
                  width: 347,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF1F41BB),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Type Here.....',
                      hintStyle: TextStyle(
                        color: const Color(0xFF828282),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, bottom: 8),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Color(0xFF1F41BB)),
                        onPressed: _filterRecords,
                      ),
                    ),
                  ),
                ),
              ),
              // Search Records heading
              Positioned(
                left: 84,
                top: 134,
                child: Text(
                  'Search Records',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Search icon beside heading
              Positioned(
                left: 34,
                top: 129,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFF1F41BB),
                    size: 20,
                  ),
                ),
              ),
              // Search results list
              Positioned(
                left: 32,
                top: 260,
                child: Container(
                  width: 347,
                  height: 540,
                  child: _isSearching && _filteredRecords.isEmpty
                      ? Center(
                          child: Text(
                            "No records found",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredRecords.length,
                          itemBuilder: (context, index) {
                            final record = _filteredRecords[index];
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  record['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      record['address'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Inspection Date: ${record['date']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(record['status']),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    record['status'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigate to record details
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Selected record: ${record['name']}'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
