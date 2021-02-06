import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_bloc.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_event.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_model.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_state.dart';
import 'package:qib_assignment/Utility/qib.dart';
import 'package:qib_assignment/Widgets/product_box.dart';
import 'package:qib_assignment/Wrapper/loading_wrapper.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


  List<String> brandImages = [
    'Assets/levis.png',
    'Assets/puma.png',
    'Assets/HM.png',
    'Assets/deisel.png',
  ];


  List<String> tabs = ['Home', 'Cart', 'Notify', 'Account'];
  Map tabVal = {'Home': true, 'Cart': false, 'Notify': false, 'Account': false};
  Map tabIcon = {
    'Home': Icons.home,
    'Cart': Icons.shopping_cart,
    'Notify': Icons.notifications,
    'Account': Icons.person
  };

  DashboardBloc _bloc;

  @override
  void initState() {
    _bloc = new DashboardBloc(DashboardLoadingState());
    _bloc.add(DashboardLoadEvent());
    // _bloc.add(DashboardMultiLoadEvent());
    super.initState();
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Text(
                'Cloudy',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What are you looking for Today?'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSlider(BuildContext context, List<WeatherModel> temps) {
    return Container(
      height: 180.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: temps
            .map((e) =>
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .8,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: (e.temperature - 273.0).toInt() <= 15 ? Colors
                          .lightBlueAccent : Colors.yellow
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((e.temperature - 273.0).toInt().toString() + '°',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          shadows: [
                            Shadow(
                            blurRadius: 1.0,
                          offset: Offset(1,1),
                          color: Colors.black.withOpacity(0.3)
                        )
                          ]
                        ),),
                      Text(e.cityName,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: 1.0,
                                  offset: Offset(1,1),
                                  color: Colors.black.withOpacity(0.3)
                              )
                            ]
                        ),
                      ),
                      Text(e.description,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: 1.0,
                                  offset: Offset(1,1),
                                  color: Colors.black.withOpacity(0.3)
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
            .toList(),
      ),
    );
  }

  Widget _buildBrandsRow(BuildContext context, List<String> images) {
    return Container(
      height: 90.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: images
              .map((e) =>
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(e))),
              ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 3.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Color(0xffEFEFEF),
    );
  }

  Future<WeatherModel> getData(String cityName) async {
    const String baseurl = 'https://api.openweathermap.org/data/2.5/weather?';
    String mainUrlWeather = baseurl+'q='+cityName+'&'+'appid='+QIB.mapKey;
    var response = await get(mainUrlWeather);
    var data =await jsonDecode(response.body);
    print("Api response $data");
    String desc = data['weather'][0]['description'];
    double temp = data['main']['temp'];
    WeatherModel weatherModel = new WeatherModel(cityName: cityName,temperature: temp,description: desc);
    return weatherModel;
  }


  Future<List<WeatherModel>> getList()async{
    List<WeatherModel> res = [];
    List<String> list = ['New York','Dubai','London','Australia','Mumbai'];
    for(int i =0;i<list.length;i++){
      res.add(await getData(list[i]));
    }
    return res;
  }

  Widget _buildMonthChart(BuildContext context){
    return Container(
      child: FutureBuilder(
        future: getList(),
        builder: (context,snapshot){
          if(snapshot.hasData) {
            print("response ${snapshot.data}");
            List<Widget> tiles = [];
            snapshot.data.forEach((WeatherModel e)=>{
              tiles.add(Container(
                height: 50.0,
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.cityName,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),),
                    Text((e.temperature.toInt()-273.0).toString(),
                    style: TextStyle(
                      color: (e.temperature - 273.0).toInt() <= 15 ? Colors
                .lightBlueAccent : Colors.yellow,
                      shadows: [Shadow(
                          blurRadius: 1.0,
                          offset: Offset(1,1),
                          color: Colors.black.withOpacity(0.3)
                      )]
                    ),),
                  ],
                ),
              ))
            });
            return Column(
              children: tiles,
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildVAHeader(BuildContext context, String title){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
            color: Color(0xff040F4F),
            fontSize: 18.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isActive, IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 34.0,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      decoration: BoxDecoration(
          color: !isActive ? Colors.white : Color(0xff040F4F),
          borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey,
          ),
          SizedBox(
            width: 10.0,
          ),
          isActive
              ? Text(
                  title,
                  style: TextStyle(
                      color: isActive ? Colors.white : Color(0xff040F4F)),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher(BuildContext context, List<String> tabs, tabVal) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs
              .map((e) => GestureDetector(
                  onTap: () {
                    tabVal['Home'] = false;
                    tabVal['Cart'] = false;
                    tabVal['Account'] = false;
                    tabVal['Notify'] = false;
                    setState(() {
                      tabVal[e] = true;
                    });
                  },
                  child: _buildTab(e, tabVal[e], tabIcon[e])))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040F4F),
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
            cubit: _bloc,
            builder: (context, currentState) {
              print("Current state ${currentState}");
              if (currentState is DashboardLoadingState) {
                return LoadingWrapper(
                    child: Column(
                      children: [
                        Spacer(),
                      ],
                    ), loading: true);
              }
              if(currentState is DashboardErrorState){
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
                            _bloc.add(DashboardLoadEvent());
                          },
                          child: Text('Try Again',
                            style: TextStyle(
                                color: Color(0xff040F4F)
                            ),),
                          color: Colors.white ,
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (currentState is DashboardLoadedState) {
                return Container(
                  color: Colors.white,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .5,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xff040F4F),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'Assets/mask.png'))),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                              // Content
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .55,
                                child: Column(
                                  // _buildAppBar(context),
                                  children: [
                                    _buildAppBar(context),
                                    _buildSearchField(context),
                                    _buildSlider(context, currentState.dashboardModel.cityTemps),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Our Trusted Clients',
                                            style: TextStyle(
                                                color: Color(0xff040F4F),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.workspaces_filled,
                                            color: Color(0xff040F4F),
                                          )
                                        ],
                                      ),
                                    ),
                                    _buildBrandsRow(context, brandImages),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          _buildDivider(context),
                          _buildTabSwitcher(context, tabs, tabVal),
                          _buildDivider(context),
                          _buildVAHeader(context, 'Others'),
                          _buildMonthChart(context)
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
