import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam/model/student.model.dart';
import 'package:flutter_exam/screens/list_screen.dart';
import 'package:flutter_exam/theme.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../widgets/input.dart';

class FormArguments {
  bool isUpdate;
  Student? st;

  FormArguments({this.isUpdate = false, this.st});
}

class FormStudentScreen extends StatefulWidget {
  const FormStudentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FormStudentScreen> createState() => _FormStudentScreenState();
}

class _FormStudentScreenState extends State<FormStudentScreen> {
  late Student st;
  late String formName = 'Thêm mới sinh viên';
  late FormArguments args = FormArguments();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _birth = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _course = TextEditingController();

  initValue(Student st) {
    setValueField(st.name, _name);
    setValueField(st.gender, _gender);
    setValueField(st.phone, _phone);
    setValueField(st.mail, _mail);
    setValueField(st.birth, _birth);
    setValueField(st.address, _address);
    setValueField(st.course, _course);
  }

  setValueField(String text, TextEditingController controller) {
    controller.value = TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length)));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)?.settings.arguments as FormArguments;
      if (args.isUpdate) {
        st = args.st!;
        initValue(st);
        // formName = 'Update Customer #${args.st?.id}';
        formName = 'Cập nhật thông tin sinh viên';
      } else {}
      setState(() {});
    });
  }

  submitForm() {
    if (args.isUpdate) {
      updateStudent();
    } else {
      addStudent();
    }
  }

  Future<void> updateStudent() async {
    var res = await http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/updateObjects?id=${st.id}&p0=${_name.text}&p1=${_birth.text}&p2=${_phone.text}&p3=${_mail.text}&p4=${_address.text}&p5=${_course.text}&p6=${_gender.text}&tokenup=lethibaotran'));
    if (res.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Can not update custommer'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  Future<void> addStudent() async {
    var res = await http.get(Uri.parse(
        'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=${_name.text}&id=1&p1=${_birth.text}&p2=${_phone.text}&p3=${_mail.text}&p4=${_address.text}&p5=${_course.text}&p6=${_gender.text}&tokenin=lethibaotran'));
    if (res.statusCode == 200) {
      Navigator.of(context).popAndPushNamed('$ListScreen');
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Can not add customer'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _gender.dispose();
    _birth.dispose();
    _phone.dispose();
    _mail.dispose();
    _address.dispose();
    _course.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Center(
                        child: Text(
                          formName.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 246, 8, 187),
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      CustomTextFormField().getWidget(
                        labelName: 'Họ và tên',
                        textController: _name,
                        hint: 'Nhập họ và tên của bạn',
                        validator: (value) {
                          if (value!.isEmpty || value.length > 100) {
                            return "Please enter valid name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        value: _gender.text.isEmpty ||
                                (_gender.text != 'Nam' && _gender.text != 'Nữ')
                            ? null
                            : _gender.text,
                        decoration: const InputDecoration(
                          label: Text("Giới tính"),
                          hintText: 'Chọn giới tính',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        items: const [
                          DropdownMenuItem(child: Text("Nam"), value: "Male"),
                          DropdownMenuItem(child: Text("Nữ"), value: "Female"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _gender.text = value.toString();
                          });
                          // _gender.text = value.toString();
                        },
                        validator: (value) =>
                            value == null || value.toString().isEmpty
                                ? "Please enter valid gender"
                                : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField().getWidget(
                          labelName: 'Ngày sinh',
                          textController: _birth,
                          enable: false,
                          // initialValue: args.isUpdate ? staff.birth : '01/01/2000',
                          hint: 'Chọn ngày sinh',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please chose valid birth";
                            } else {
                              return null;
                            }
                          },
                          onTap: () async {
                            final datePick = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (datePick != null) {
                              setState(() {
                                _birth.clear();
                                _birth.text =
                                    DateFormat("dd/MM/yyyy").format(datePick);
                              });
                              // _birth.text = DateFormat("dd/MM/yyyy").format(datePick);
                            }
                          }),
                      const SizedBox(height: 10),
                      CustomTextFormField().getWidget(
                        textController: _phone,
                        labelName: 'Số điện thoại',
                        hint: 'Nhập số điện thoại của bạn',
                        type: TextInputType.number,
                        validator: (value) {
                          RegExp regex =
                              RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');
                          if (!regex.hasMatch(value.toString())) {
                            return "Please enter valid phone number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      InputCustomWidget(
                        textController: _mail,
                        labelName: 'Email',
                        hint: 'Nhập email của bạn',
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !EmailValidator.validate(value.toString()) ||
                              value.length > 100) {
                            return "Please enter valid email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField().getWidget(
                        textController: _course,
                        labelName: 'Loại sinh viên',
                        hint: 'Nhập loại sinh viên',
                        validator: (value) {
                          if (value!.isEmpty || value.length > 100) {
                            return "Please enter valid guest type";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField().getWidget(
                        textController: _address,
                        labelName: 'Địa chỉ',
                        hint: 'Nhập địa chỉ của bạn',
                        validator: (value) {
                          if (value!.isEmpty || value.length > 100) {
                            return "Please enter valid address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            submitForm();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                gradient: new LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 126, 223),
                                    Color.fromARGB(255, 255, 182, 80)
                                  ],
                                )),
                            child: const Text(
                              'Xác Nhận',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          )),
    );
  }
}
