import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodia_test/injector.dart';
import 'package:prodia_test/main/presentation/blocs/upload_image_bloc.dart';
import 'package:prodia_test/main/presentation/provider/user_provider.dart';
import 'package:prodia_test/main/presentation/widgets/image_upload_listener.dart';
import 'package:prodia_test/main/presentation/widgets/profile_image_view.dart';
import 'package:prodia_test/shared/constants.dart';
import 'package:prodia_test/shared/themes.dart';
import 'package:prodia_test/shared/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  UploadImageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = injector<UploadImageBloc>();
    debugPrint("BLOC $_bloc");
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addressController.text =
        Provider.of<UserProvider>(context, listen: false).address;
    emailController.text =
        Provider.of<UserProvider>(context, listen: false).email;
    fullNameController.text =
        Provider.of<UserProvider>(context, listen: false).fullname;
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            SafeArea(
              child: ListView(
                children: [
                  Column(
                    children: [
                      // Header
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                        width: double.infinity,
                        height: 100,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Profile",
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "",
                                  style: greyFontStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: DEFAULT_MARGIN,
                        width: double.infinity,
                        color: bgColor,
                      ),
                      Column(
                        children: [
                          _buildProfilePhoto(),
                          CustomTextField(
                            controller: fullNameController,
                            text: "Full Name",
                            enabled: false,
                          ),
                          CustomTextField(
                            controller: emailController,
                            text: "Email Address",
                            enabled: false,
                          ),
                          CustomTextField(
                            controller: addressController,
                            text: "Address",
                            enabled: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePhoto() {
    final provider = Provider.of<UserProvider>(context);
    bool _isLoading = false;
    return BlocBuilder(
      bloc: _bloc,
      builder: (_, state) {
        if (state is ImageUploading) {
          _isLoading = true;
        } else {
          _isLoading = false;
        }
        return Container(
          width: 110,
          height: 110,
          margin: EdgeInsets.only(top: 26),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/photo_border.png"),
            ),
          ),
          child: Stack(
            children: [
              (provider.profileImage == "")
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/ic_profile.png"),
                        ),
                      ),
                    )
                  : ProfileImageView(
                      photoUrl: provider.profileImage,
                    ),
              _isLoading ? LoadingIndicator() : SizedBox(),
              ImageUploadListener(
                stream: _bloc.stream,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const LoadingIndicator(
      {Key key,
      this.color = Colors.blue,
      this.height = 40.0,
      this.width = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
