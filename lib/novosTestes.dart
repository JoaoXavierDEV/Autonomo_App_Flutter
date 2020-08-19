import 'package:autonomo_app/components/chip.dart';
import 'package:flutter/material.dart';

List<String> europeanCountries = [
  'subCategorias',
  'subCategorias',
  'subCategorias',
  'subCategorias',
  'subCategorias',
  'subCategorias',
  'subCategorias',
  'subCategorias'
];

class NovosTestes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
          //backgroundColor: Colors.deepPurple[700],
          backgroundColor: Color(0xff3700b3),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ExpansionTile(
              title: Text("INFORMÁTICA"),
              subtitle: Text("Selecione seus serviços"),
              backgroundColor: Colors.deepPurple[50],
              onExpansionChanged: (value) => {},
              leading: Icon(
                Icons.settings_input_composite,
                size: 32,
                color: Color(0xff3700b3),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: 32,
                color: Color(0xff3700b3),
              ),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ChipComponent(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(
                          label: Text(
                            'Suporte',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),

                          onDeleted: () {},
                          backgroundColor: Color(0xFF8F8F8F),
                          deleteIcon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 18,
                          ),
                          //deleteIconColor: Colors.amber,
                          labelPadding: EdgeInsets.only(
                            bottom: 2,
                            top: 2,
                            left: 12,
                            right: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'TI',
    <Entry>[
      Entry('s'),
      Entry('Suporte / Redes'),
    ],
  ),
  Entry(
    'Beleza',
    <Entry>[
      Entry('Manicure'),
      Entry('Designer de sobrancelhas'),
    ],
  ),
  Entry(
    'Transportes',
    <Entry>[
      Entry('Fretes'),
      Entry('Turismo'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(NovosTestes());
}
