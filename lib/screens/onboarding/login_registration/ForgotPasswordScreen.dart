import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import '../../../apis/apis.dart';

void main() => runApp(const ForgotPasswordScreen());

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ForgotPasswordWidgets();
  }
}

class ForgotPasswordWidgets extends StatefulWidget {
  const ForgotPasswordWidgets({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordWidgets> createState() => _ForgotPasswordWidgetsState();
}

class _ForgotPasswordWidgetsState extends State<ForgotPasswordWidgets> {
  final TextEditingController _emailController = TextEditingController();
  bool isButtonActive = false;

  var result = {};

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      final isButtonActive = _emailController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  handleForgot() async {
    var response = await UserProvider().forgotPassword(_emailController.text);
    print('response $response');
    return (response);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/background_images/bahag_background.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.neutralGray04,
            ),
            onPressed: () {
              Get.offAllNamed('/accountScreen');
              //Navigation
              Get.back();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                SvgPicture.asset('assets/images/forgot_password.svg'),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Forgot your password?',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralBlack02),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Enter your email to change your password',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.neutralBlack03,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 20.0),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'Confirm email',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray04,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray03),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.neutralGray01,
                              ))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary:
                                  Theme.of(context).colorScheme.intGreenMain,
                              onSurface:
                                  Theme.of(context).colorScheme.neutralGray03,
                            ),
                            child: Text(
                              'Confirm',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01),
                            ),
                            onPressed: () async => {
                                  if (isButtonActive)
                                    {
                                      result = await handleForgot(),
                                      if (result["status"])
                                        {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              insetPadding:
                                                  const EdgeInsets.all(50.0),
                                              title: Text(
                                                'Enter the verification code we sent',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .neutralBlack02,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Divider(
                                                    height: 1.0,
                                                    thickness: 1.0,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .neutralWhite04,
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    'Check your email and open the link given to reset your password',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .neutralBlack02),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 10, 15, 10),
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30))),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        primary:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .intGreenMain,
                                                        onSurface:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .neutralGray03,
                                                      ),
                                                      child: Text(
                                                        'Confirm',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .neutralWhite01),
                                                      ),
                                                      onPressed: isButtonActive
                                                          ? () {
                                                              //Navigation and account validation
                                                              Get.offAllNamed(
                                                                  '/accountScreen');
                                                            }
                                                          : null,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        }
                                      else
                                        {
                                          Get.snackbar(
                                            "Server Error Occurred during Request",
                                            result["email"],
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01,
                                          )
                                        }
                                    }
                                  else
                                    {null}
                                }),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
