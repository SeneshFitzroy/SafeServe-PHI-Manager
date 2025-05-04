import 'package:flutter/material.dart';

class SearchableTradeDropdown extends StatefulWidget {
  final String initial;
  final bool  isInvalid;
  final ValueChanged<String> onSelected;

  const SearchableTradeDropdown({
    Key? key,
    required this.initial,
    required this.onSelected,
    this.isInvalid = false,
  }) : super(key: key);

  @override
  State<SearchableTradeDropdown> createState() =>
      _SearchableTradeDropdownState();
}

class _SearchableTradeDropdownState extends State<SearchableTradeDropdown> {
  static const _options = <String>[
    'Restaurants',
    'Eateries',
    'Bakeries',
    'Hotels',
    'Cafés',
    'Mobile Food Carts',
    'Street Vendors',
    'Supermarkets',
    'Fast‑Food Outlets',
    'Catering Services',
    'Food Processing',
    'Ice‑cream Parlors',
  ];

  late String? _selected = widget.initial.isNotEmpty ? widget.initial : null;

  void _openSearchDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => _SearchDialog(
        options: _options,
        initial: _selected,
      ),
    );
    if (result != null) {
      setState(() => _selected = result);
      widget.onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
    widget.isInvalid ? Colors.red : const Color(0xFF4289FC);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Type of Trade',
              style: TextStyle(fontSize: 18, color: Colors.black)),
          const SizedBox(height: 6),
          InkWell(
            onTap: _openSearchDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _selected ?? 'Select Trade',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                        _selected == null ? Colors.grey[600] : Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.search, color: Color(0xFF1F41BB)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------
// Search dialog with a text field
//--------------------------------------------------------------------------

class _SearchDialog extends StatefulWidget {
  final List<String> options;
  final String? initial;
  const _SearchDialog({required this.options, this.initial});

  @override
  State<_SearchDialog> createState() => __SearchDialogState();
}

class __SearchDialogState extends State<_SearchDialog> {
  late List<String> _filtered = widget.options;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = widget.options
            .where((e) => e.toLowerCase().contains(q))
            .toList(growable: false);
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchCtrl,
            decoration: const InputDecoration(
              hintText: 'Search trade type...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const Divider(height: 1),
        Flexible(
          child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, i) {
              final val = _filtered[i];
              final selected = val == widget.initial;
              return ListTile(
                title: Text(val),
                trailing: selected ? const Icon(Icons.check) : null,
                onTap: () => Navigator.pop(context, val),
              );
            },
          ),
        ),
      ]),
    );
  }
}
