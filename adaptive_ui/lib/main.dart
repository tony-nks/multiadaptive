import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final SliverGridDelegate gridDelegate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Adap(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Adap extends StatelessWidget {
  const Adap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MediaQuery.of(context).size.width <700 ? ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext, index){
            return People();
          },
        ) : Container(
          child: Row(
            children: [
              Container(
                width: 250,
                color: Colors.red,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 20,
                  itemBuilder: (BuildContext, index){
                    return PeopleTablet();
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}


class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 200,
        width: 200,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            // Item A in the popover
            InkWell(
              onTap: () {
                // Navigate to SecondRoute when Item A is tapped
                Navigator.of(context)
                  ..pop() // Dismiss the current screen (popover)
                  ..push(
                    MaterialPageRoute<SecondRoute>(
                      builder: (context) => SecondRoute(),
                    ),
                  );
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            // Item B in the popover
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            // Item C in the popover
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}

class People extends StatelessWidget {
  const People({super.key});
  void _show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.amber,
        context: ctx,
        builder: (ctx) => Container(
          width: 300,
          height: 250,
          color: Colors.white54,
          alignment: Alignment.center,
          child: const Text('Breathe in... Breathe out...'),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          _show(context);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: ListTile(
            leading: Icon(Icons.person, size: 20,),
            title: Text('Student № 1'),
          ),
        ),
      ),
    );
  }
}

class PeopleTablet extends StatelessWidget {
  const PeopleTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            showPopover(
              context: context,
              bodyBuilder: (context) =>
              const ListItems(), // Display the ListItems in the popover
              onPop: () => print(
                  'Popover was popped!'), // Print a message when the popover is dismissed
              direction:
              PopoverDirection.bottom, // Set the direction of the popover
              width: 200, // Set the width of the popover
              height: 250, // Set the height of the popover
              arrowHeight: 15, // Set the height of the arrow
              arrowWidth: 30, // Set the width of the arrow
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: ListTile(
              leading: Icon(Icons.person, size: 20,),
              title: Text('Student № 2'),
            ),
          ),
        ),
      ),
    );
  }
}
