import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../data/model/reclip_content_creator.dart';
import '../../../../data/model/video.dart';
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
              children: <Widget>[
                if (videoThumbnail == null) _buildEmptyContainer(),
                if (videoThumbnail != null) _buildThumbnail(),
                Container(
                  height: ScreenUtil().setHeight(600),
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
                      final ffmpegProbe = FlutterFFprobe();
                      final Uuid randomIdGenerator = Uuid();
                      final video = Video(
                        contentCreatorEmail: widget.contentCreator.email,
                        title: _titleTextEditingController.text,
                        description: _descriptionTextEditingController.text,
                        videoId: randomIdGenerator.v5(
                            _titleTextEditingController.text,
                            _descriptionTextEditingController.text),
                        publishedAt: DateTime.now(),
                        likedBy: [],
                        likeCount: 0,
                        viewCount: 0,
                      );

                      //Get Video Height and Width
                      final videoMetadata = await ffmpegProbe
                          .getMediaInformation(widget.video.path);

                      PaintingBinding.instance.imageCache.clear();
                      BlocProvider.of<AddContentBloc>(context)
                        ..add(VideoAdded(
                          contentCreator: widget.contentCreator,
                          rawVideo: widget.video,
                          thumbnail: videoThumbnail,
                          video: video.copyWith(
                            width:
                                videoMetadata['streams'][0]['width'].toDouble(),
                            height: videoMetadata['streams'][0]['height']
                                .toDouble(),
                          ),
                          isAdded: false,
                        ));
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

  // Future<File> _compressVideo() async {
  //   final compressor = FlutterFFmpeg();
  //   final config = FlutterFFmpegConfig();
  //   return await showDialog<File>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       title: Text('Compressing Video', style: TextStyle(color: reclipBlack)),
  //       content: VideoCompressingProgress(
  //         video: widget.args.video,
  //         ffmpegCompressor: compressor,
  //         ffmpegConfig: config,
  //       ),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text('Cancel'),
  //           onPressed: () {
  //             compressor.cancel();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
              height: ScreenUtil().setHeight(800),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: reclipIndigo, width: 3),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(videoThumbnail),
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
              height: ScreenUtil().setHeight(800),
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
                        fontSize: ScreenUtil().setSp(50),
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
