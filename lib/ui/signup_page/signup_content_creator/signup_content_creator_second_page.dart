import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../../core/reclip_colors.dart';
import '../../../core/router/route_generator.gr.dart';
import '../../../model/reclip_content_creator.dart';

class SignupContentCreatorSecondPage extends StatelessWidget {
  final ReclipContentCreator user;
  SignupContentCreatorSecondPage({
    Key key,
    this.user,
  }) : super(key: key);
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
                SignupContentCreatorSecondForm(user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorSecondForm extends StatefulWidget {
  final ReclipContentCreator user;

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
    super.initState();
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FormBuilderTextField(
              attribute: 'birth_date',
              decoration: InputDecoration(
                hintText: 'Birth Date (mm/dd/yy)',
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
              keyboardType: TextInputType.datetime,
              validators: [
                FormBuilderValidators.required(),
                //ignore: missing_return
                (val) {
                  try {
                    if (val.split('/').last.length < 4) {
                      return 'Invalid Date, please follow the format (mm/dd/yyyy)';
                    } else {
                      DateFormat('MM/dd/yyyy').parse(val);
                    }
                  } catch (e) {
                    return 'Invalid Date, please follow the format (mm/dd/yyyy)';
                  }
                }
              ],
            ),
            const SizedBox(
              height: 20,
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
                // ignore: missing_return
                (val) {
                  final regex = RegExp(r"^(\+63|0|63)?(9){1}?[0-9]{9}$");
                  if (!val.toString().contains(regex)) return 'Invalid Number';
                }
              ],
            ),
            const SizedBox(
              height: 20,
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
    );
  }

  _navigateToThirdPage() {
    if (_fbKey.currentState.saveAndValidate()) {
      final user = widget.user.copyWith(
        birthDate: birthDateController.text,
        contactNumber: contactNumberController.text,
      );
      ExtendedNavigator.rootNavigator
          .pushNamed(Routes.signupContentCreatorThirdPageRoute,
              arguments: SignupContentCreatorThirdPageArguments(
                user: user,
              ));
    }
  }
}
