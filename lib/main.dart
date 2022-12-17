import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'my_encryption.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Useful variable
  TextEditingController tec = TextEditingController();
  var encryptedText, plaintext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption and Decryption"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: tec,
              ),
            ),

            //Outcome printed
            Column(
              children: [
                Text(
                  "Plain Text",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(plaintext == null ? "" : plaintext),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Encrypted Text",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(encryptedText == null
                      ? ""
                      : encryptedText is encrypt.Encrypted
                          ? encryptedText.base64
                          : encryptedText),
                )
              ],
            ),

            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    plaintext = tec.text;
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.encryptAES(plaintext);
                    });
                  },
                  child: Text("Encrypt"),
                ),

                ///////////////////////////////////////////////
                SizedBox(
                  width: 10,
                ),
                //////////////////////////////////////////////

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.decryptAES(encryptedText);
                    });
                  },
                  child: Text("Decrypt"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
