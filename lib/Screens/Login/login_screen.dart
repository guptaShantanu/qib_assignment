import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qib_assignment/Screens/Login/login_bloc.dart';
import 'package:qib_assignment/Screens/Login/login_event.dart';
import 'package:qib_assignment/Screens/Login/login_state.dart';
import 'file:///C:/Users/HP/AndroidStudioProjects/qib_assignment/lib/Screens/Dashboard/dashboard_screen.dart';
import 'package:qib_assignment/Wrapper/loading_wrapper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;

  @override
  void initState() {
    _bloc = LoginBloc(LoginInitState());
    super.initState();
  }

  void showSuccessDialog(BuildContext context){
    // show success dialog and route to dashboard
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text('Yippeee'),
        content: Container(
          height: 100.0,
          color: Colors.grey,
        ),
      )
    );
  }

  void showErrorMessage(BuildContext context,String errorMessage){
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(errorMessage),
    ));
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
          cubit: _bloc,
          builder: (context, currentState){
            print("Current state : ${currentState}");
            if(currentState is LoginErrorState){
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error,color: Colors.red,
                      size: 100.0,),
                      Text(currentState.errorMessage),
                      SizedBox(
                        height: 20.0,
                      ),
                      FlatButton(
                        onPressed: (){
                          _bloc.add(LoginInitEvent());
                        },
                        child: Text('Try Again',
                        style: TextStyle(
                          color: Colors.white
                        ),),
                        color:  Color(0xff040F4F),
                      ),
                    ],
                  ),
                ),
              );
              // showSuccessDialog(context);
            }

            if(currentState is LoginSuccessState){
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.assignment_turned_in_rounded,color: Colors.green,
                        size: 100.0,),
                      Text('Login Succeed'),
                      SizedBox(
                        height: 20.0,
                      ),
                      FlatButton(
                        onPressed: ()async{
                          await Navigator.push(context, MaterialPageRoute(builder:(context){
                            return DashBoardScreen();
                          }));
                          _bloc.add(LoginInitEvent());
                        },
                        child: Text('Go',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color:  Color(0xff040F4F),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
                child: LoadingWrapper(
                  loading: currentState is LoginLoadingState ? true : false,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 150.0,
                          width: 170.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Assets/logo.png'),
                                  fit: BoxFit.contain)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back,',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Sign in to continue',
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xff707070)),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Enter registered number',
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xff707070)),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration:
                                    BoxDecoration(color: Color(0xffEFEFEF)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 1.0,
                                      height: 40.0,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 10.0),
                                        child: TextField(
                                          onChanged: (val){
                                            _bloc.loginModel.phone = val;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '7991373447'),
                                        ),
                                      ),
                                      flex: 7,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration:
                                BoxDecoration(color: Color(0xffEFEFEF)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 1.0,
                                      height: 40.0,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 10.0),
                                        child: TextField(
                                          onChanged: (val){
                                            _bloc.loginModel.password = val;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Password'),
                                        ),
                                      ),
                                      flex: 7,
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   child: Text(
                              //     'A 4 Digit OTP will sent to your Phone to Verify your Mobile Number',
                              //     style: TextStyle(
                              //         color: Color(0xff707070), fontSize: 10.0),
                              //   ),
                              // ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _bloc.add(LoginStartEvent());
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             DashBoardScreen()));
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff040F4F),
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'New here?',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14.0),
                                      ),
                                      Text(
                                        ' Create an account',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '©QIB All right reserved',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }),
    );
  }
}
