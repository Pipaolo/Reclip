import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import 'package:sailor/sailor.dart';

class SignupContentCreatorThirdArgs extends BaseArguments {
  final ReclipUser user;

  SignupContentCreatorThirdArgs({@required this.user});
}

class SignupContentCreatorThirdPage extends StatelessWidget {
  final SignupContentCreatorThirdArgs args;
  const SignupContentCreatorThirdPage({Key key, this.args}) : super(key: key);
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                SignupContentCreatorThirdForm(user: args.user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorThirdForm extends StatefulWidget {
  final ReclipUser user;
  SignupContentCreatorThirdForm({Key key, this.user}) : super(key: key);

  @override
  _SignupContentCreatorThirdFormState createState() =>
      _SignupContentCreatorThirdFormState();
}

class _SignupContentCreatorThirdFormState
    extends State<SignupContentCreatorThirdForm> {
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: SizedBox(
        height: ScreenUtil().setHeight(300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'description',
                decoration: InputDecoration(
                  hintText: 'Description',
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
                maxLines: 5,
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: reclipIndigo,
                  child: Text(
                    'Next'.toUpperCase(),
                  ),
                  onPressed: () => _navigateToFourthPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToFourthPage() {
    if (_fbKey.currentState.saveAndValidate()) {
      final user = widget.user.copyWith(
        description: descriptionController.text,
      );
      Routes.sailor.navigate('signup_page/content_creator/fourth_page',
          args: SignupContentCreatorFourthArgs(
            user: user,
          ));
    }
  }
}
