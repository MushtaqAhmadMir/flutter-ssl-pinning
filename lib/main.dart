

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

main(){
  runApp(const MaterialApp(home: MyApp(),),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  fetchData()async{
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    var response = await ioClient.get(Uri.parse('https://www.facebook.com/'));
    print(response.body);
  }

  Future<SecurityContext> get globalContext async {
    final sslCert1 = await
    rootBundle.load("assets/certificates/demo.pem");
    SecurityContext sc = SecurityContext(withTrustedRoots: false);
    sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
    return sc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: ()async{
            await fetchData();
          },
          child: const Text('Press here'),
        ),
      ),
    );
  }
}