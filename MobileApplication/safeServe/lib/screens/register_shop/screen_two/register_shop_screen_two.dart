import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../register_shop_form_data.dart';
import '../../../services/offline_queue.dart';
import '../../../services/auth_service.dart';
import 'widgets/photo_header.dart';
import 'widgets/photo_preview.dart';
import 'widgets/bottom_buttons.dart';

class RegisterShopScreenTwo extends StatefulWidget {
  final RegisterShopFormData formData;
  const RegisterShopScreenTwo({super.key, required this.formData});

  @override
  State<RegisterShopScreenTwo> createState() => _RegisterShopScreenTwoState();
}

class _RegisterShopScreenTwoState extends State<RegisterShopScreenTwo> {
  bool _photoMissing=false;
  final _db = FirebaseFirestore.instance;
  final _fs = FirebaseStorage.instance;

  Future<void> _takePhoto() async {
    final picked=await ImagePicker().pickImage(source:ImageSource.camera);
    if(picked!=null){
      final pos=await Geolocator.getCurrentPosition();
      setState(() {
        widget.formData.photoPath=picked.path;
        widget.formData.lat=pos.latitude;
        widget.formData.lng=pos.longitude;
        _photoMissing=false;
      });
    }
  }

  Future<void> _submit() async {
    if(widget.formData.photoPath==null){setState(()=>_photoMissing=true);return;}

    final uid = (await AuthService.instance.getCachedProfile())?['uid'] ?? '';
    final docId=widget.formData.referenceNo; // unique
    final data={
      'referenceNo'         : widget.formData.referenceNo,
      'businessRegNumber'   : widget.formData.businessRegNumber,
      'name'                : widget.formData.establishmentName,
      'establishmentAddress': widget.formData.establishmentAddress,
      'district'            : widget.formData.district,
      'gnDivision'          : widget.formData.gnDivision,
      'licenseNumber'       : widget.formData.licenseNumber,
      'licensedDate'        : Timestamp.fromDate(DateTime.parse(widget.formData.licensedDate)),
      'typeOfTrade'         : widget.formData.typeOfTrade,
      'numberOfEmployees'   : int.parse(widget.formData.numberOfEmployees),
      'ownerName'           : widget.formData.ownerName,
      'nicNumber'           : widget.formData.nicNumber,
      'privateAddress'      : widget.formData.privateAddress,
      'telephone'           : widget.formData.telephone,
      'registeredPHI'       : _db.doc('/users/$uid'),
      'location'            : widget.formData.lat!=null
          ? GeoPoint(widget.formData.lat!,widget.formData.lng!)
          : null,
      'grade'               : '',
      'lastInspection'      : [],
      'upcomingInspection'  : null,
    };

    final online = await Connectivity().checkConnectivity()!=ConnectivityResult.none;
    if(online){
      try{
        final snap = await _fs.ref('shops_images/$docId.jpg')
            .putFile(File(widget.formData.photoPath!),SettableMetadata(contentType:'image/jpeg'));
        final url = await snap.ref.getDownloadURL();
        await _db.collection('shops').doc(docId).set({...data,'image':url});
        Navigator.popUntil(context,(r)=>r.isFirst);
      }catch(e){
        _show('Upload failed: $e');
      }
    }else{
      OfflineQueue.instance.addShopJob(
          ShopCreationJob(docId,data,widget.formData.photoPath!));
      _show('Saved locally – will sync when online.');
      Navigator.popUntil(context,(r)=>r.isFirst);
    }
  }

  void _show(String m)=>ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content:Text(m)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(height:70,onMenuPressed:(){},),
      body:Stack(children:[
        Container(decoration:const BoxDecoration(
          gradient: LinearGradient(
              begin:Alignment.topCenter,end:Alignment.bottomCenter,
              colors:[Color(0xFFE6F5FE),Color(0xFFF5ECF9)]),)),
        SingleChildScrollView(
          padding:const EdgeInsets.only(bottom:40),
          child:Column(children:[
            const SizedBox(height:20),
            PhotoHeader(title:'Photo Upload',
                onArrowPressed:()=>Navigator.pop(context)),
            const SizedBox(height:20),
            PhotoPreview(photoPath:widget.formData.photoPath,
                isMissing:_photoMissing,onTap:_takePhoto),
            const SizedBox(height:30),
            BottomButtons(
                onPrevious:()=>Navigator.pop(context),
                onSubmit:_submit),
          ]),
        ),
      ]),
    );
  }
}