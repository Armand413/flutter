import 'package:flutter/material.dart';

void main() => runApp(MyApp());  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculatrice(),
    );
  }
}

class Calculatrice extends StatefulWidget {
  @override
  _CalculatriceState createState() => _CalculatriceState();
}

// widget d'état pour la calculatrice
class _CalculatriceState extends State<Calculatrice> {
  // Variables de logique de la calculatrice
  dynamic text = '';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '0';
  dynamic opr = '';
  dynamic preOpr = '';
 // Fonction pour créer les boutons de la calculatrice
  Widget calbouton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor,
          padding: EdgeInsets.all(20), 
        ),
      ),
    );
  }
 // Construction de l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculatrice'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Affichage de l'expression en cours
            Row( 
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 50,
                    ),
                  ),
                )
              ],
            ),
            //affichage du résultat final
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    finalResult,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
                )
              ], 
            ),
            // Boutons de la calculatrice par rangée
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbouton('C', Colors.grey, Colors.black),
                calbouton('%', Colors.grey, Colors.black),
                calbouton('/', Colors.orange, Colors.white),
                calbouton('x', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbouton('7', Colors.grey[850]!, Colors.white),
                calbouton('8', Colors.grey[850]!, Colors.white),
                calbouton('9', Colors.grey[850]!, Colors.white),
                calbouton('-', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbouton('4', Colors.grey[850]!, Colors.white),
                calbouton('5', Colors.grey[850]!, Colors.white),
                calbouton('6', Colors.grey[850]!, Colors.white),
                calbouton('+', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calbouton('1', Colors.grey[850]!, Colors.white),
                    ElevatedButton(
        onPressed: () {
          calculation('+/-');
        },
        child: Text(
          '+/-',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: Colors.grey[850],
          padding: EdgeInsets.all(20), 
        ),
      ),
                  ],
                ),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calbouton('2', Colors.grey[850]!, Colors.white),
                    calbouton('0', Colors.grey[850]!, Colors.white),
                  ],
                ),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calbouton('3', Colors.grey[850]!, Colors.white),
                    calbouton('.', Colors.grey[850]!, Colors.white),
                  ],
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.fromLTRB(28, 70, 28, 70),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    calculation('=');
                  }, 
                  child: Text(
                    '=',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],       
        )
      ),
    );
  } 
 // Logique de calcul
  void calculation(String btnText) {
  setState(() {

    // RESET
    if (btnText == 'C') {
      text = '';
      finalResult = '0';
      numOne = 0;
      numTwo = 0;
      opr = '';
      return;
    }

    // CHANGEMENT DE SIGNE
    if (btnText == '+/-') {
      if (finalResult.startsWith('-')) {
        finalResult = finalResult.substring(1);
      } else if (finalResult != '0') {
        finalResult = '-' + finalResult;
      }
      return;
    }

    // DECIMAL
    if (btnText == '.') {
      if (!finalResult.contains('.')) {
        finalResult += '.';
      }
      return;
    }

    // POURCENTAGE
    if (btnText == '%') {
      finalResult =
          (double.parse(finalResult) / 100).toString();
      text = '$finalResult';
      return;
    }

    // OPERATEURS
    if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/') {
      numOne = double.parse(finalResult);
      opr = btnText;
      text = '$numOne $opr';
      finalResult = '0';
      return;
    }

    // EGAL
    if (btnText == '=') {
      numTwo = double.parse(finalResult);

      text = '$numOne $opr $numTwo =';

      switch (opr) {
        case '+':
          finalResult = (numOne + numTwo).toString();
          break;
        case '-':
          finalResult = (numOne - numTwo).toString();
          break;
        case 'x':
          finalResult = (numOne * numTwo).toString();
          break;
        case '/':
          finalResult =
              numTwo == 0 ? 'Erreur' : (numOne / numTwo).toString();
          break;
      }

      opr = '';
      return;
    }

    // CHIFFRES
    if (finalResult == '0') {
      finalResult = btnText;
    } else {
      finalResult += btnText;
    }
  });
}


}