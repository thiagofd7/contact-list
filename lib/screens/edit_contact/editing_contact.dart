import 'package:contact_list/screens/new_contatact/new_contact_controller.dart';
import 'package:contact_list/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import '../../controller/data/share_prefs.dart';
import 'editing_contact_controller.dart';
import '../../models/contact_model.dart';
import '../widgets/buttom_widget.dart';
import '../widgets/custom_profile.dart';
import '../widgets/customfild.dart';

class EditingContact extends StatefulWidget {
  final String name;
  final String number;
  final String email;
  final String? image;
  final int index;
  const EditingContact(
      {super.key,
      required this.name,
      required this.number,
      required this.email,
      required this.image,
      required this.index});

  @override
  State<EditingContact> createState() => _EditingContactState();
}

class _EditingContactState extends State<EditingContact> {
  final _newconroller = NewContactController();
  final _editingController = EditingContactController();

  late ValueNotifier<String> title = ValueNotifier<String>('Contato');
  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _newconroller.onfile.addListener(() {
      setState(() {});
    });
    _nameController = TextEditingController(text: widget.name);
    _numberController = TextEditingController(text: widget.number);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: width * 0.1,
            )),
        title: Text(
          title.value,
          style: TextStyle(
              fontSize: height * 0.026,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.black.withOpacity(0.6),
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: GestureDetector(
                          onTap: () => {
                                _newconroller.onfile.value =
                                    !_newconroller.onfile.value
                              },
                          child: widget.image!.length == 2
                              ? CircleAvatar(
                                  radius: 60,
                                  child: _newconroller.value == null
                                      ? Text(
                                          widget.image!,
                                          style: TextStyle(
                                              fontSize: height * 0.07),
                                        )
                                      : Container(
                                          width: width * 0.5,
                                          height: height * 0.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(_newconroller
                                                    .convert64ToInmage(
                                                        widget.image!)),
                                              )),
                                        ))
                              : CustomProfile(
                                  arquivo: _newconroller.value,
                                  image: _newconroller
                                      .convert64ToInmage(widget.image!),
                                )),
                    ),
                    Container(
                      width: width,
                      height: height * 0.597,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.08,
                          ),
                          Customfild(
                            typekeybord: TextInputType.name,
                            validator: null,
                            prefixicons: Icons.person,
                            controller: _nameController,
                            label: "Nome",
                          ),
                          Customfild(
                            typekeybord: TextInputType.phone,
                            validator: null,
                            prefixicons: Icons.phone,
                            controller: _numberController,
                            label: "Numero",
                          ),
                          Customfild(
                            typekeybord: TextInputType.emailAddress,
                            validator: null,
                            prefixicons: Icons.email,
                            controller: _emailController,
                            label: "E-mail",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: _newconroller.onfile.value ? 535 : 1000,
                    child: AnimatedContainer(
                      width: width,
                      height: height * 0.24,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22))),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Vamos escolher uma foto!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtomWidget(
                                  onfile: _newconroller.onfile.value,
                                  icon: Icons.attach_file_rounded,
                                  nameFunction: "Selecionar arquivo",
                                  onpressed: () {
                                    _newconroller.getImageFile();
                                  },
                                ),
                                ButtomWidget(
                                  onfile: _newconroller.onfile.value,
                                  icon: Icons.camera_alt_rounded,
                                  nameFunction: "Tira uma Foto",
                                  onpressed: () {
                                    _newconroller.getImagePhoto();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )),
      floatingActionButton: _newconroller.onfile.value
          ? Container()
          : AnimatedContainer(
              width: width * 0.17,
              height: height * 0.08,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInBack,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _editingController.editingContact(
                    key: keylist,
                    index: widget.index,
                    contact: ContactModel(
                        name: _nameController.text,
                        email: _emailController.text,
                        number: _numberController.text,
                        image: _newconroller.value == null
                            ? widget.image!
                            : _newconroller.converImaB64(
                                fileImage: _newconroller.value!)),
                  );

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                  size: height * 0.05,
                ),
              ),
            ),
    );
  }
}
