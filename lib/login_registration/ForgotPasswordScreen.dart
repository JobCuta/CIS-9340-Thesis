import 'package:flutter/material.dart';

void main() => runApp(const ForgotPasswordScreen());

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ForgotPasswordWidgets(),
    );
  }
}

class ForgotPasswordWidgets extends StatefulWidget {
  const ForgotPasswordWidgets({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordWidgets> createState() => _ForgotPasswordWidgetsState();
}

class _ForgotPasswordWidgetsState extends State<ForgotPasswordWidgets>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[850],
                ),
                onPressed: () {
                  //Navigation
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 5.0,),
                  const Image(image: AssetImage('assets/images/forgot-password.png')),
                  const SizedBox(height: 15.0,),
                  const Text('Forgot your password?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  const Text('Enter your email to change your password',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: const [
                                Text('Confirm email',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(94, 102, 104, 1)
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0,),
                            TextField(
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onSurface: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: const Text('Send Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Proxima Nova',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  //Navigation and account validation
                                }
                              ),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

