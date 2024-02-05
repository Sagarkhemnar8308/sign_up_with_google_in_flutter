import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  "email",
  'https://www.googleapis.com/auth/contacts.readonly'
]);

TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class _SignUpState extends State<SignUp> {
  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account!;
      });

      if (currentUser != null) {
        print("User is already authenticated");
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> handleSignin() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print("sign in error :" + e.toString());
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: currentUser != null
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 200,width: 200,child: GoogleUserCircleAvatar(identity: currentUser!)),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        currentUser!.displayName ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        currentUser!.email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "Welcome To the Baap App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp(),));
                      },
                      child: const Text("Sign Out"),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration:
                            const InputDecoration(hintText: " Enter Name *"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TextFormField(
                        controller: emailcontroller,
                        decoration:
                            const InputDecoration(hintText: " Enter Email *"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        decoration: const InputDecoration(
                            hintText: " Enter Password *"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text(" Sign up"))),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Or Login With",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                onPressed: () => handleSignin(),
                                icon: const Icon(
                                  Icons.g_mobiledata,
                                  size: 80,
                                ))),
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.apple,
                                  size: 80,
                                ))),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
