import 'package:flutter/material.dart';
import 'package:myfreshword/constants/constants.dart';
import 'package:myfreshword/screens/homeScreen.dart';
import 'package:flutter/foundation.dart';

import './widgets/custom_shape.dart';
import './widgets/customappbar.dart';
import './widgets/responsive_ui.dart';
import './widgets/textformfield.dart';
import '../data/user_data.dart';
import '../data/church_data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String _dropdownValue;
  ContentType contentType;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  bool _isLoading = false;

//http call to register
  Future<NewUser> _signupUser(String username, String mobile, String email,
      String password, String churchid) async {
    var body = json.encode({
      "username": username,
      "mobile": mobile,
      "email": email,
      "password": password,
      "church_id": churchid,
    });
    final response =
        await http.post('https://api.myfreshword.com/app/sign_up', body: body);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return NewUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error registering user');
    }
  }

  void signUp() async {
    //formvalidation
    if (_key.currentState.validate()) {
      // setState(() => _isLoading = true);
      var res = await _signupUser(
          usernameController.text,
          mobileController.text,
          emailController.text,
          passwordController.text,
          _dropdownValue);
      // setState(() => _isLoading = false);
      // NewUser user = NewUser.fromJson(res);
      if (res.status == 202) {
        return showDialog(
            context: context,
            barrierDismissible: false, //user must tap a button
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Registration Successful'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return new MyHomeScreen(
                            // user: user,
                            );
                      }));
                    },
                  )
                ],
              );
            });
      } else {
        return showDialog(
            context: context,
            barrierDismissible: true, //user must tap a button
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Registration Unsuccessful please try again'),
                // actions: <Widget>[
                //   FlatButton(
                //     child: Text('Ok'),
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute<Null>(
                //           builder: (BuildContext context) {
                //         return new MyHomeScreen(
                //             // user: user,
                //             );
                //       }));
                //     },
                //   )
                // ],
              );
            });
      }
    }
  }

//http call to get all churches.
  Future<List<Church>> fetchChurchList(http.Client client) async {
    final response =
        await http.get('https://api.myfreshword.com/app/church_list');

    if (response.statusCode == 200) {
      // print(response.body);
      // If server returns an OK response, parse the JSON.
      // return parseChurch(response.body);
      // Use the compute function to run parseChurch in a separate isolate. in other to prevent  app freezing
      return compute(parseChurch, response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // A function that converts a response body into a List<Church>.
  static List<Church> parseChurch(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Church>((json) => Church.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    this.fetchChurchList(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                infoTextRow(),
                socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[500], Colors.red],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[500], Colors.red],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
              onTap: () {
                print('Adding photo');
              },
              child: Icon(
                Icons.add_a_photo,
                size: _large ? 40 : (_medium ? 33 : 31),
                color: Colors.red[500],
              )),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            userNameTextFormField(),
            SizedBox(height: _height / 60.0),
            // churchListDropDown(),

            //fetching the data and displaying it in churchListDropDown(),
            FutureBuilder<List<Church>>(
              future: fetchChurchList(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? churchListDropDown(snapshot.data)
                    : Center(child: CircularProgressIndicator());

                // //if (snapchat.hasData){
                //   return churchListDropDown(snapshot.data);
                //   }else{ errorChurchlistDropdown(snapshot.error)}
              },
            ),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      textEditingController: nameController,
      icon: Icons.person,
      hint: "First Name",
      obscureText: false,
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      textEditingController: nameController,
      icon: Icons.person,
      hint: "Last Name",
      obscureText: false,
    );
  }

  Widget userNameTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      textEditingController: usernameController,
      icon: Icons.person,
      hint: "Username",
      obscureText: false,
    );
  }

  Widget churchListDropDown(churchlist) {
    final List<Church> churchData = churchlist;
    return CustomDropdownButton(
      item: churchData.map((item) {
        return new DropdownMenuItem(
            child: new Text(
              item.name,
              style: TextStyle(fontSize: 14.0),
            ),
            value: item.id);
      }).toList(),
      isExpanded: true,
      dropdownValue: _dropdownValue,
      onchanged: (String newValue) {
        setState(() {
          _dropdownValue = newValue;
          // print(_dropdownValue);
        });
      },
      // icon:Icons.home,
      hint: Text("Select Church"),
    );
  }

  //create a default dropdown should incase their is an error while fetching churchlist.
  // Widget errorChurchlistDropdown() {

  //   return CustomDropdownButton(
  //     item: churchData.map((item) {
  //       return new DropdownMenuItem(
  //           child: new Text(
  //             item.name,
  //             style: TextStyle(fontSize: 14.0),
  //           ),
  //           value: item.id);
  //     }).toList(),
  //     isExpanded: true,
  //     dropdownValue: _dropdownValue,
  //     onchanged: (String newValue) {
  //       setState(() {
  //         _dropdownValue = newValue;
  //         // print(_dropdownValue);
  //       });
  //     },
  //     // icon:Icons.home,
  //     hint: Text("Select Church"),
  //   );
  // }

  Widget emailTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: "Email ID",
      obscureText: false,
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      textEditingController: mobileController,
      icon: Icons.phone,
      hint: "Mobile Number",
      obscureText: false,
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      validator: (value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      textEditingController: passwordController,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red[500],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        signUp();
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.red[200], Colors.red],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
