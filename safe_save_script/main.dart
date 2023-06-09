import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:io';

//widgets
import './widgets/new_transaction.dart';
import './widgets/transcation_list.dart';
import './widgets/chart.dart';

//models
import './models/transaction.dart';

const globalPrimaryColor = Color.fromARGB(125, 19, 58, 131);
const globalAccentColor = Color.fromARGB(167, 255, 193, 7);

void main() {
  String currentPath = Directory.current.path + "\\lib\\";
  String fileName = 's.py';

  // https://api.dart.dev/stable/2.7.0/dart-io/Process-class.html

  // Lansam un proces ce ruleaza :
  // comanda "python"
  // argumente: "s.py"
  // se ruleaza in shell
  // path-ul pentru care se ruleaza comanda

  // Pentru lansarea unui proces independent
  Process.run(
    "python",
    [fileName],
    runInShell: true,
    workingDirectory: currentPath,
  );

  // Pentru lansarea unui proces non-independent
  // Process.start(
  //   "python",
  //   [fileName],
  //   runInShell: true,
  //   workingDirectory: currentPath,
  // ).then((process) {
  //   print('Script process id - ${process.pid}');
  //   process.exitCode.then((exitCode) {
  //     print('Python script ended.');
  //     print('Exit code: $exitCode');
  //   });
  // });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpensesApp Demo - Flutter',
      theme: ThemeData(
        primaryColor: globalPrimaryColor,
        accentColor: globalAccentColor,
        fontFamily: "Quicksand",
        errorColor: Color.fromARGB(171, 255, 0, 0),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(183, 168, 0, 197),
              ),
              headline5: const TextStyle(
                fontFamily: 'Opensans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(183, 168, 0, 197),
              ),
              button: const TextStyle(
                color: Colors.white,
                // backgroundColor: globalPrimaryColor,
              ),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: globalPrimaryColor,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = true;
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 12,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Ticket',
      amount: 2.22,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't4',
      title: 'T-Shirt',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't5',
      title: 'Helmet',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't6',
      title: 'Coffee',
      amount: 19,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't7',
      title: 'Headphones',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't8',
      title: 'Coffee',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Transaction(
      id: 't9',
      title: 'Apples',
      amount: 2.50,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
    Transaction(
      id: 't10',
      title: 'Mouse',
      amount: 149.99,
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenData) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenData,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(
      () {
        _userTransactions.removeWhere((tx) => tx.id == id);
      },
    );
  }

  List<Widget> _buildPortrait(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.23,
        child: Chart(_userTransactions),
      ),
      txListWidget
    ];
  }

  List<Widget> _buildLandscape(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
    Widget switchChart,
  ) {
    return [
      switchChart,
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_userTransactions),
            )
          : txListWidget
    ];
  }

  CupertinoNavigationBar buildIOSNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text(
        "Expenses",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }

  AppBar buildAndroidAppBar() {
    return AppBar(
      title: Text(
        "Expenses",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget chooseAppBar() {
    return Platform.isIOS ? buildIOSNavigationBar() : buildAndroidAppBar();
  }

  void init() async {
    String pyCode = await readFile();
  }

  Future<String> readFile() async {
    return await rootBundle.loadString('assets/script.txt');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = chooseAppBar();
    var switchChart = SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_recentTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isLandscape)
            ..._buildPortrait(
              mediaQuery,
              appBar,
              txListWidget,
            ),
          if (isLandscape)
            ..._buildLandscape(
              mediaQuery,
              appBar,
              txListWidget,
              switchChart,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
