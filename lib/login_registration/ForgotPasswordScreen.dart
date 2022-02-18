import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

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
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  bool isButtonActive = true;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void initState() {
    super.initState();
    _pinPutController.addListener(() {
      final isButtonActive = _pinPutController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: SizedBox(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
    (snackBar);
  }

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
            body: ListView(
              children: [Column(
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
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>  AlertDialog(
                                    insetPadding: const EdgeInsets.all(50.0),
                                    title: const Text('Enter the verification code we sent',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          margin: const EdgeInsets.all(10.0),
                                          child: PinPut(
                                            fieldsCount: 6,
                                            onSubmit: (String pin) => _showSnackBar(pin, context),
                                            focusNode: _pinPutFocusNode,
                                            controller: _pinPutController,
                                            submittedFieldDecoration: _pinPutDecoration.copyWith(
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            selectedFieldDecoration: _pinPutDecoration,
                                            followingFieldDecoration: _pinPutDecoration.copyWith(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: Colors.black.withOpacity(.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0,),
                                        const Text('Check your email to confirm your account in order to log in',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(30))
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              onSurface: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: const Text('Confirm',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Proxima Nova',
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: isButtonActive ? () {
                                              //Navigation and account validation
                                            }
                                            :null,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              )]
            ),
          )
        ],
      ),
    );
  }
  //Widget Builder for popup
}

