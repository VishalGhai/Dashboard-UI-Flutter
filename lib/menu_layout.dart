import 'package:flutter/material.dart';
final Color backgroundcolor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin{
  
  bool isCollapsed = true;
  double screenWidth,screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync:this,duration:duration);
    _scaleAnimation = Tween<double>(begin: 1,end:0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0,end:1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin:Offset(-1,0),end:Offset(0,0)).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Stack(children: <Widget>[
        menu(context),
        dashboard(context),
      ],)
    );
  }

  Widget menu(context){
    
    return SlideTransition(
      position: _slideAnimation,
          child: Padding(
        padding: const EdgeInsets.only(left:16.0),
        child: Align(
          alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
            Text("Dashboard",style:TextStyle(color: Colors.white, fontSize:22)),
            SizedBox(height:20),
            Text("Message",style:TextStyle(color: Colors.white, fontSize:22)),
            SizedBox(height:20),
            Text("Utility",style:TextStyle(color: Colors.white, fontSize:22)),
            SizedBox(height:20),
            Text("Fund Transfer",style:TextStyle(color: Colors.white, fontSize:22)),
            SizedBox(height:20),
            Text("Branches",style:TextStyle(color: Colors.white, fontSize:22)),

          ],),
        ),
      ),
    );
  }

  Widget dashboard(context){
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      left:isCollapsed ? 0 : 0.6 * screenWidth,
      bottom: 0,
      right:isCollapsed ? 0 : -0.4 * screenWidth,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
            borderRadius: BorderRadius.all(Radius.circular(40)),
        elevation:8,
        color:backgroundcolor,
        child:Container(
            padding: EdgeInsets.only(left:16,right:16,top:48),
                  child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                InkWell(child: Icon(Icons.menu,color: Colors.white,),onTap: (){
                  setState((){
                    if(isCollapsed)
                    _controller.forward();
                    else
                    _controller.reverse();
                    isCollapsed = !isCollapsed;
                  });
                },),
                Text("Hello",style: TextStyle(fontSize: 25,color:Colors.white),),
                Icon(Icons.settings,color:Colors.white),
              ],
              ),
              SizedBox(height:50),
              Container(
                height: 200,
                child: PageView(
                  controller: PageController(viewportFraction:0.8),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.red,
                      width: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.blue,
                      width: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.green,
                      width: 100,
                    ),
                  ]

                  
                ),
              )
            ],
            ),
        ),
      ),
          ),
    );
  }
}