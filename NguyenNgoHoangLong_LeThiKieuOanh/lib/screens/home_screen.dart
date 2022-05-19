import 'package:flutter/material.dart';
import 'package:flutter_exam/screens/add_new_screen.dart';
import 'package:flutter_exam/theme.dart';
import 'package:flutter_exam/widgets/button.dart';

import 'list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const HomeBackground(),
            const FractionallySizedBox(heightFactor: 0.5, child: HomeContent()),
            // const HomeContent(),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 50,
                  ),
                  ButtonNavigator(
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        size.width * 0.9,
                        size.height * 0.065,
                      ),
                    ),
                    textStyle: MaterialStateProperty.all(
                        PrimaryFont.medium(size.height * 0.03)),
                    content: 'Thêm Sinh Viên',
                    route: '/add',
                    args: FormArguments(),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(20),
                  //   width: 200,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [Colors.lightGreen, Colors.orange],
                  //       begin: FractionalOffset.topLeft,
                  //       end: FractionalOffset.bottomRight,
                  //     ),
                  //   ),
                  //   child: FlatButton(
                  //     child: Text(
                  //       'Login',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/add');
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        gradient: new LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 126, 223),
                            Color.fromARGB(255, 255, 182, 80),
                          ],
                        )),
                    child: ButtonNavigator(
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          size.width * 0.9,
                          size.height * 0.065,
                        ),
                      ),
                      textStyle: MaterialStateProperty.all(
                          PrimaryFont.medium(size.height * 0.03)),
                      content: 'Xem danh sách sinh viên',
                      route: '$ListScreen',
                    ),
                  ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => FormStudentScreen()));
                  //   },
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(80.0)),
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Ink(
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       padding: const EdgeInsets.all(10.0),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(30),
                  //           color: Colors.white,
                  //           gradient: new LinearGradient(
                  //             colors: [
                  //               Color.fromARGB(255, 255, 126, 223),
                  //               Color.fromARGB(255, 255, 182, 80),
                  //             ],
                  //           )),
                  //       child: const Text(
                  //         'Thêm sinh viên',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(color: Colors.white, fontSize: 24),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Spacer(
                  //   flex: 5,
                  // ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => ListScreen()));
                  //   },
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(80.0)),
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Ink(
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       padding: const EdgeInsets.all(10.0),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(30),
                  //           color: Colors.white,
                  //           gradient: new LinearGradient(
                  //             colors: [
                  //               Color.fromARGB(255, 255, 126, 223),
                  //               Color.fromARGB(255, 255, 182, 80)
                  //             ],
                  //           )),
                  //       child: const Text(
                  //         'Xem danh sách ',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(color: Colors.white, fontSize: 24),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAlias,
          child: Image.asset('assets/images/img.png'),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Spacer(
        flex: 5,
      ),
      Flexible(
        fit: FlexFit.tight,
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.0),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Quản Lý Sinh Viên',
                  style: PrimaryFont.bold(35).copyWith(
                      color: Color.fromARGB(255, 246, 8, 187), height: 1.5),
                  children: [
                    TextSpan(
                        text:
                            '\nNguyễn Ngô Hoàng Long - 18DH110286 \nLê Thị Kiều Oanh - 18DH110153',
                        style: PrimaryFont.light(20)
                            .copyWith(color: Color.fromARGB(255, 54, 54, 54)))
                  ])),
        ),
      ),
    ]);
  }
}
