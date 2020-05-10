import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_info/media_info.dart';
import 'package:uuid/uuid.dart';

import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../model/reclip_content_creator.dart';
import '../../../../model/video.dart';
import '../../../custom_widgets/dialogs/dialog_collection.dart';

class AddContentVideoPage extends StatefulWidget {
  final File video;
  final ReclipContentCreator contentCreator;
  AddContentVideoPage({
    Key key,
    @required this.video,
    @required this.contentCreator,
  }) : super(key: key);

  @override
  _AddContentVideoPageState createState() => _AddContentVideoPageState();
}

class _AddContentVideoPageState extends State<AddContentVideoPage> {
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  File videoThumbnail;

  String thumbnailUrl;
  String videoUrl;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddContentBloc, AddContentState>(
            listener: (context, state) {
          if (state is UploadingVideo) {
            DialogCollection.showProgressDialog(context);
          } else if (state is UploadVideoSuccess) {
            Future.delayed(
                Duration(seconds: 2), () => Navigator.of(context).pop());

            DialogCollection.showSuccessDialog('Video Uploaded!', context);
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add Video'),
          backgroundColor: reclipBlack,
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (videoThumbnail == null) _buildEmptyContainer(),
                if (videoThumbnail != null) _buildThumbnail(),
                const SizedBox(height: 15),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: FormBuilder(
                      key: _fbKey,
                      autovalidate: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: 'title',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              hintText: 'Title',
                            ),
                            controller: _titleTextEditingController,
                            autovalidate: true,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            maxLines: 1,
                          ),
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                            attribute: 'description',
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: reclipIndigo),
                              ),
                              hintText: 'Description',
                            ),
                            controller: _descriptionTextEditingController,
                            maxLines: 5,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: RaisedButton(
                    child: Text('Add Video'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: reclipIndigo,
                    onPressed: () async {
                      final mediaInfo = MediaInfo();
                      final videoMetadata =
                          await mediaInfo.getMediaInfo(widget.video.path);
                      final height = videoMetadata['height'];
                      final width = videoMetadata['width'];
                      final Uuid randomIdGenerator = Uuid();
                      final video = Video(
                        contentCreatorName: widget.contentCreator.name,
                        contentCreatorEmail: widget.contentCreator.email,
                        title: _titleTextEditingController.text,
                        description: _descriptionTextEditingController.text,
                        videoId: randomIdGenerator.v5(
                            _titleTextEditingController.text,
                            _descriptionTextEditingController.text),
                        publishedAt: DateTime.now(),
                        height: height,
                        width: width,
                        likeCount: 0,
                        viewCount: 0,
                      );

                      BlocProvider.of<AddContentBloc>(context)
                        ..add(
                          VideoAdded(
                            contentCreator: widget.contentCreator,
                            rawVideo: widget.video,
                            thumbnail: videoThumbnail,
                            video: video,
                            isAdded: false,
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildThumbnail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        color: reclipBlack,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: reclipIndigo, width: 3),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(videoThumbnail),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            onTap: () async {
              try {
                videoThumbnail = await ImagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 50);
                setState(() {});
              } catch (e) {
                print(e.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  _buildEmptyContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        color: reclipBlack,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: reclipIndigo, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: (videoThumbnail == null)
                  ? Text(
                      'Add Thumbnail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    )
                  : Container(),
            ),
            onTap: () async {
              try {
                videoThumbnail =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {});
              } catch (e) {
                print(e.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
