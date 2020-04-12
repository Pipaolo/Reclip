import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../core/reclip_colors.dart';
import '../../../core/router/route_generator.gr.dart';
import '../../../data/model/reclip_content_creator.dart';

class SignupContentCreatorThirdPage extends StatelessWidget {
  final ReclipContentCreator user;
  SignupContentCreatorThirdPage({
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
                SignupContentCreatorThirdForm(user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorThirdForm extends StatefulWidget {
  final ReclipContentCreator user;
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
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
              controller: descriptionController,
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
    );
  }

  _navigateToFourthPage() {
    if (_fbKey.currentState.saveAndValidate()) {
      final user = widget.user.copyWith(
        description: descriptionController.text,
      );

      ExtendedNavigator.rootNavigator
          .pushNamed(Routes.signupContentCreatorFourthPageRoute,
              arguments: SignupContentCreatorFourthPageArguments(
                user: user,
              ));
    }
  }
}
