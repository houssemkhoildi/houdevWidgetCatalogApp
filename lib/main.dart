// Developed by Houssem Eddin Khoildi
// Visit: housemeddinkhoildi.me

import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetCatalogApp());
}

class WidgetCatalogApp extends StatelessWidget {
  const WidgetCatalogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> widgetCategories = [
    {
      'category': 'Layout',
      'widgets': ['Container', 'Row', 'Column', 'Stack']
    },
    {
      'category': 'Input',
      'widgets': ['TextField', 'Button', 'Checkbox', 'Switch']
    },
    {
      'category': 'Navigation',
      'widgets': ['AppBar', 'BottomNavigationBar', 'Drawer', 'TabBar']
    },
    {
      'category': 'Display',
      'widgets': ['Text', 'Image', 'Icon', 'ListView']
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchBar(context),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widgetCategories.length,
        itemBuilder: (context, index) {
          final category = widgetCategories[index];
          final filteredWidgets = (category['widgets'] as List<String>)
              .where((widget) => widget.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();

          if (filteredWidgets.isEmpty) return const SizedBox();

          return ExpansionTile(
            title: Text(category['category']),
            children: filteredWidgets
                .map((widgetName) => ListTile(
              title: Text(widgetName),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetDetailPage(widgetName: widgetName),
                  ),
                );
              },
            ))
                .toList(),
          );
        },
      ),
    );
  }

  void _showSearchBar(BuildContext context) {
    showSearch(
      context: context,
      delegate: WidgetSearchDelegate(widgetCategories),
    );
  }
}

class WidgetDetailPage extends StatelessWidget {
  final String widgetName;

  const WidgetDetailPage({Key? key, required this.widgetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widgetName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widgetName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _getWidgetExamples(widgetName),
          ],
        ),
      ),
    );
  }

  Widget _getWidgetExamples(String widgetName) {
    switch (widgetName) {
      case 'Container':
        return Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Example 1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Example 2: Decorated Container'),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              color: Colors.orange,
              child: const Text('Example 3: Padding & Margin'),
            ),
          ],
        );
      case 'Row':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.star, color: Colors.red),
                Icon(Icons.star, color: Colors.green),
                Icon(Icons.star, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  child: Text('Example 2: Expanded Item',
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('Expanded Item 2', textAlign: TextAlign.center),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('Baseline 1'),
                SizedBox(width: 8),
                Text('Baseline 2'),
              ],
            ),
          ],
        );
      case 'TextField':
        return Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Default',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Hint Example',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ],
        );
      case 'Button':
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
          ],
        );
      default:
        return Column(
          children: [
            const Text('Example not available for this widget.'),
            const SizedBox(height: 16),
            Text(
              'Visit housemeddinkhoildi.me for more resources.',
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        );
    }
  }
}

class WidgetSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> widgetCategories;

  WidgetSearchDelegate(this.widgetCategories);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = widgetCategories
        .expand((category) => category['widgets'] as List<String>)
        .where((widget) => widget.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final widgetName = results[index];
        return ListTile(
          title: Text(widgetName),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WidgetDetailPage(widgetName: widgetName),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
