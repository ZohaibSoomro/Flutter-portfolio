import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String expression = "";
  String answer = "";
  static const c = "Combination";
  static const p = "Permutataion";
  static const f = "Factorial";
  String choice = c;
  final choiceText = {
    f: "n!",
    c: "nCr",
    p: "nPr",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: choice,
              autofocus: true,
              focusColor: Colors.lightBlueAccent,
              onChanged: (val) => setState(() {
                choice = val!;
              }),
              items: const [
                //factorial
                DropdownMenuItem(
                  child: Text(f),
                  value: f,
                ),
                //combination
                DropdownMenuItem(
                  child: Text(c),
                  value: c,
                ),
                //permutation
                DropdownMenuItem(
                  child: Text(p),
                  value: p,
                ),
              ],
            ),
            TextField(
              onChanged: (val) => expression = val.toUpperCase(),
              decoration: InputDecoration(
                hintText: choiceText[choice],
                labelText: choice,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  if (expression != "") {
                    //combination work
                    if (expression.contains("C") && choice == c) {
                      int n = int.parse(
                          expression.substring(0, expression.indexOf("C")));
                      int r = int.parse(
                          expression.substring(expression.indexOf("C") + 1));
                      if (n < r) {
                        setState(() {
                          answer = "n can't exceed r!";
                        });
                        return;
                      }

                      int nFact = fact(n);
                      int rFact = fact(r);
                      int nRFact = fact(n - r);
                      String result = (nFact / (nRFact * rFact)).toString();

                      if (result.contains(".0")) {
                        result = double.parse(result).toInt().toString();
                      }
                      answer = result;
                      setState(() {});
                    }

                    ///permutataion work
                    else if (expression.contains("P") && choice == p) {
                      int n = int.parse(
                          expression.substring(0, expression.indexOf("P")));
                      int r = int.parse(
                          expression.substring(expression.indexOf("P") + 1));

                      if (n < r) {
                        setState(() {
                          answer = "n can't exceed r!";
                        });
                        return;
                      }
                      int nFact = fact(n);
                      int nRFact = fact(n - r);
                      String result = (nFact / nRFact).toString();

                      if (result.contains(".0")) {
                        result = double.parse(result).toInt().toString();
                      }
                      answer = result;
                      setState(() {});
                    }

                    ///factorial work
                    else if (expression.endsWith("!") && choice == f) {
                      int n = int.parse(
                          expression.substring(0, expression.indexOf("!")));
                      answer = fact(n).toString();
                      setState(() {});
                    } else {
                      setState(() {
                        answer = "";
                      });
                    }
                  }
                } catch (e) {
                  // print(e);
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 30),
            Flexible(
              child: Text(
                answer,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int fact(int n) {
    if (n < 1) return 1;
    return n * fact(n - 1);
  }
}
