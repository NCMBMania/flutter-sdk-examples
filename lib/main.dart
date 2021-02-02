import 'package:flutter/material.dart';
import 'package:ncmb/ncmb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NCMB ncmb = new NCMB('1f394bd4d2a0a80a45f0c5a86fea448b6b36d5a795ad2ce90ddb6ff7ad136fb2', 'cdc44afd241a213a917f35d58344672ad60e72666bbbd7aa44c82172ea4fa398');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NCMB Flutter SDK Demo', ncmb: ncmb),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.ncmb}) : super(key: key);

  final String title;
  final NCMB ncmb;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';
  String _objectId = '';

  void _handleText(String e) {
    setState(() {
      _message = e;
    });
  }

  void _handlePressed() async {
    NCMBObject item = widget.ncmb.Object('Item')
      ..set('message', _message);
    await item.save();
    setState(() {
      _objectId = item.get('objectId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'メッセージをどうぞ',
            ),
            new TextField(
              enabled: true,
              maxLength: 40,
              maxLengthEnforced: false,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              onChanged: _handleText,
            ),
            FlatButton(
              onPressed: _handlePressed,
              color: Colors.blue,
              child: Text(
                'データ登録',
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 15.0
                ),
              ),
            ),
            if (_objectId != '') Text('オブジェクトID ${_objectId} で保存されました')
          ],
        ),
      ),
    );
  }
}
