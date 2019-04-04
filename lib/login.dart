import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wangpharmacy/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState ( );
}

class _LoginState extends State<Login> {
  bool _ShowPass = false; // กำหนดสถานะ ShowPass = false;

  TextEditingController ctrlUsername = new TextEditingController( );
  TextEditingController ctrlPassword = new TextEditingController( );

  var Useralert = 'Please enter the Username / กรุณากรอกชื่อบัญชีผู้';
  var Passalert = 'Please enter the Password / กรุณากรอกรหัสผ่านบัญชีผู้ใช้';
  var userInvalid = false;
  var passInvalid = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
        resizeToAvoidBottomPadding: false,
        body: Container (
          padding: EdgeInsets.fromLTRB ( 30, 0, 30, 40 ),
          // ซ้าย , บน , ขวา , ล่าง
          constraints: BoxConstraints.expand ( ),
          color: Colors.white,
          child: Column (
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding (
                padding: const EdgeInsets.fromLTRB( 0, 0, 0, 25 ),
                child: Container (
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all ( 5 ),
                  decoration: BoxDecoration (
                    shape: BoxShape.circle,
                    color: Color ( 0xffd8d8d8 ),
                  ),
                  //child: FlutterLogo(),
                  child: Image (
                    image: AssetImage ( "assets/images/logo-login.png" ),
                  ),
                ),
              ),
              Padding (
                padding: const EdgeInsets.fromLTRB( 0, 0, 0, 20 ),
                child: Text (
                  'Wangpharmacy\nกรุณาเข้าสู่ระบบ Login',
                  style: TextStyle (
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Padding (
                padding: const EdgeInsets.fromLTRB( 0, 0, 0, 40 ),
                child: TextFormField (
                  controller: ctrlUsername,
                  style: TextStyle (
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration (
                      prefixIcon: Icon (
                        Icons.account_box,
                        size: 30,
                      ),
                      labelText: 'Username / ชื่อบัญชีผู้ใช้',
                      errorText: userInvalid ? Useralert : null,
                      //'Please enter the Username / กรุณากรอกชื่อบัญชีผู้',
                      labelStyle: TextStyle (
                        color: Color ( 0xff888888 ),
                        fontSize: (15),
                      )
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding (
                padding: const EdgeInsets.fromLTRB( 0, 0, 0, 40 ),
                child: Stack (
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField (
                      controller: ctrlPassword,
                      style: TextStyle (
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      obscureText: !_ShowPass,
                      decoration: InputDecoration (
                        prefixIcon: Icon (
                          Icons.vpn_lock,
                          size: 30,
                        ),
                        labelText: 'Password / รหัสผ่านบัญชีผู้ใช้',
                        errorText: passInvalid ? Passalert : null,
                        labelStyle: TextStyle (
                          color: Color ( 0xff888888 ),
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    GestureDetector (
                      onTap: ClickShowpassword,
                      child: Text (
                        _ShowPass ? 'Hide' : 'Show',
                        style: TextStyle (
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding (
                padding: const EdgeInsets.fromLTRB( 0, 0, 0, 40 ),
                child: SizedBox (
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton (
                    color: Colors.blue,
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.all (
                        Radius.circular ( 10 ),
                      ),
                    ),
                    onPressed: OnLogin,
                    child: Text (
                      'เข้าสู่ระบบ',
                      style: TextStyle (
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox (
                height: 100.0,
              ),
              Container (
                height: 0,
                width: double.infinity,
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text (
                      'สมาชิกใหม่ ?',
                      style: TextStyle (
                        fontSize: 15,
                        color: Color ( 0xff888888 ),
                      ),
                    ),
                    Text (
                      'ลืมรหัสผ่าน',
                      style: TextStyle (
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) );
  }

  // เมื่อกด login เข้าสู่ระบบ
  void OnLogin() {
    setState ( () {
      // (ctrlUsername.text.length < 4 || !ctrlUsername.text.contains("@")) แปลว่า หรือถ้าไม่มีอักษร @ ไม่ให้ผ่าน

      if (ctrlUsername.text.length < 4) {
        userInvalid = true;
      } else {
        userInvalid = false;
      }

      if (ctrlPassword.text.length < 4) {
        passInvalid = true;
      } else {
        passInvalid = false;
      }

      // ถ้า มีการกรอกข้อมูลเข้ามาใน textfile
      if (!userInvalid && !passInvalid) {
        /*
        // ตรวจสอบ Username และ Password  ถ้าถูก ให้ไปหน้า HomePage
        String Username = ctrlUsername.text;
        String Password = ctrlPassword.text;
        if (Username == 'admin' && Password == 'admin') {
          Navigator.push (
              context,
              MaterialPageRoute ( builder: (context) => HomePage ( ) ) );
        }
        // ถ้าไม่ถูกให้เด้ง Alert มาแจ้งเตือน
        else {
          _neverSatisfied ( );
        }
        */
        Checkmember();
      }
    } );
  }

  void Checkmember() async {
    final response = await http.post (
      'http://wangpharma.com/Applications/login.php',
      body: {
        'Username':ctrlUsername.text,
        'Password':ctrlPassword.text,
      }
    );
    if (response.statusCode == 200) {
      var DataUsername = json.decode(response.body);
      if(DataUsername.length == 0){
        _neverSatisfied ( );
      }
      else {
        if(DataUsername[0]['Emp_Username']=='0377'){
          //print('ยินดีต้อนรับ พี่ฮก ครับ');
          Navigator.push (
              context,
              MaterialPageRoute ( builder: (context) => HomePage ( ) ) );
        }
        else if(DataUsername[0]['Emp_Username']!='0377'){
          //print('สวัสดีชาวโลก');
          Navigator.push (
              context,
              MaterialPageRoute ( builder: (context) => HomePage ( ) ) );
        }
      }
      /*
      var jsonResponse = json.decode(response.body);
      if(jsonResponse['error']=='0'){
        Navigator.push (
            context,
            MaterialPageRoute ( builder: (context) => HomePage ( ) ) );
      }
      else {
        _neverSatisfied ( );
      }
      */
    }
    else {
      print('not connections');
    }
    //print(response.body);
  }

  Widget gotoHome(BuildContext context) {
    return HomePage ();
  }

  // เมื่อกดแสดงรหัสผ่านที่ตัวเองกด
  void ClickShowpassword() {
    setState ( () {
      _ShowPass = !_ShowPass;
    } );
  }

  void _neverSatisfied() async {
    return showDialog<void> (
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog (
          title: Text ( 'Wangpharmacy' ),
          content: SingleChildScrollView (
            child: ListBody (
              children: <Widget>[
                Text (
                  'ชื่อบัญชีผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง\n',
                  style: TextStyle (
                    color: Colors.black,
                  ),
                ),
                Text (
                  '[ Account or Password Incorrect ]',
                  style: TextStyle (
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton (
              child: Text (
                'ตกลง',
                style: TextStyle (
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of ( context ).pop ( );
              },
            ),
          ],
        );
      },
    );
  }
}
