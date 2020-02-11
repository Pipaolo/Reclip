import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:intl/intl.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import 'package:sailor/sailor.dart';

class SignupContentCreatorSecondArgs extends BaseArguments {
  final ReclipUser user;

  SignupContentCreatorSecondArgs({@required this.user});
}

class SignupContentCreatorSecondPage extends StatelessWidget {
  final SignupContentCreatorSecondArgs args;

  const SignupContentCreatorSecondPage({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: AutoSizeText(
                    'ENTER THE FOLLOWING \nDETAILS:',
                    style: TextStyle(
                      color: reclipBlackLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                SignupContentCreatorSecondForm(user: args.user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorSecondForm extends StatefulWidget {
  final ReclipUser user;

  const SignupContentCreatorSecondForm({Key key, this.user}) : super(key: key);
  @override
  _SignupContentCreatorSecondFormState createState() =>
      _SignupContentCreatorSecondFormState();
}

class _SignupContentCreatorSecondFormState
    extends State<SignupContentCreatorSecondForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  FocusNode birthDateFocus = FocusNode();
  FocusNode contactNumberFocus = FocusNode();

  @override
  void initState() {
    birthDateFocus.addListener(onDateFocused);
    super.initState();
  }

  void onDateFocused() {
    birthDateFocus.unfocus();
    Picker picker = Picker(
        adapter: DateTimePickerAdapter(
          isNumberMonth: true,
          yearBegin: 1800,
          yearEnd: 2050,
        ),
        hideHeader: true,
        title: Text('Enter Birthday'),
        confirmTextStyle: TextStyle(color: reclipIndigoDark),
        cancelTextStyle: TextStyle(color: reclipIndigoLight),
        containerColor: reclipBlack,
        headercolor: reclipBlack,
        backgroundColor: reclipIndigoLight,
        onConfirm: (picker, value) {
          final date = (picker.adapter as DateTimePickerAdapter).value;
          final convertedDate = DateFormat('MM/dd/yyyy').format(date);
          birthDateController.text = convertedDate;
        });
    picker.showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      initialValue: {
        'birth_date': DateFormat('MM/dd/yyyy').format(DateTime.now()),
        'contact_number': ''
      },
      autovalidate: true,
      child: SizedBox(
        height: ScreenUtil().setHeight(300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'birth_date',
                decoration: InputDecoration(
                  hintText: 'Birth Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                ),
                controller: birthDateController,
                focusNode: birthDateFocus,
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: 'contact_number',
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: reclipIndigo,
                      width: 2,
                    ),
                  ),
                ),
                controller: contactNumberController,
                focusNode: contactNumberFocus,
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.minLength(11,
                      errorText: 'Number should have 11 digits'),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: reclipIndigo,
                  child: Text('Next'.toUpperCase()),
                  onPressed: () => _navigateToThirdPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToThirdPage() {
    if (_fbKey.currentState.saveAndValidate()) {
      final user = widget.user.copyWith(
        birthDate: birthDateController.text,
        contactNumber: contactNumberController.text,
      );
      Routes.sailor.navigate(
        'signup_page/content_creator/third_page',
        args: SignupContentCreatorThirdArgs(user: user),
      );
    }
  }
}
