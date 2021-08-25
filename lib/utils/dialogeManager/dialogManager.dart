import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/dialogeManager/dialogModels.dart';
import 'package:movie_mart/utils/dialogeManager/dialogService.dart';

class ProgressManager extends StatefulWidget {
  final Widget child;
  ProgressManager({Key key, this.child}) : super(key: key);

  _ProgressManagerState createState() => _ProgressManagerState();
}

class _ProgressManagerState extends State<ProgressManager> {
  ProgressService _progressService = locator<ProgressService>();

  @override
  void initState() {
    super.initState();
    _progressService.registerProgressListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(ProgressRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    var dialogType = request.buttonTitle != null;

    if (dialogType) {
         showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(request.title ?? ''),
        content: Text(request.description ?? ""),
        actions: <Widget>[
          if (isConfirmationDialog)
            TextButton(
              child: Text(request.cancelTitle),
              onPressed: () {
                _progressService.dialogComplete(ProgressResponse(confirmed: false));
              },
            ),
          TextButton(
            child: Text(request.buttonTitle),
            onPressed: () {
              _progressService.dialogComplete(ProgressResponse(confirmed: true));
            },
          ),
        ],
      ),
    );
    }

    else {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        dismissable: false,
        loadingWidget: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),),
        backgroundColor: Colors.transparent,);

    // pr.show();
    progressDialog.show();
   
  }
  }

}
