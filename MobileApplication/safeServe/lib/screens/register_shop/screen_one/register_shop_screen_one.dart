import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../widgets/safe_serve_appbar.dart';
import '../register_shop_form_data.dart';
import 'widgets/form_text_field.dart';
import 'widgets/licensed_year_field.dart';
import 'widgets/next_button.dart';
import 'widgets/searchable_trade_dropdown.dart';

class RegisterShopScreenOne extends StatefulWidget {
  final RegisterShopFormData formData;
  const RegisterShopScreenOne({Key? key, required this.formData}) : super(key: key);

  @override
  State<RegisterShopScreenOne> createState() => _RegisterShopScreenOneState();
}

class _RegisterShopScreenOneState extends State<RegisterShopScreenOne> {
  final _invalid = <String>{};
  final _store = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _prefillDistrictGn();
  }

  Future<void> _prefillDistrictGn() async {
    final district  = await _store.read(key: 'ss_district') ?? '';
    final gnStr     = await _store.read(key: 'ss_gn_divisions') ?? '[]';
    final gnList    = (jsonDecode(gnStr) as List).cast<String>();

    setState(() {
      widget.formData.district   = district;
      widget.formData.gnDivision = gnList.isNotEmpty ? gnList.first : '';
      _gnOptions = gnList;
    });
  }

  late List<String> _gnOptions = [];

  bool _validate() {
    _invalid
      ..clear()
      ..addAll([
        if (!RegExp(r'^\d{6}$').hasMatch(widget.formData.referenceNo))   'reference',
        if (!RegExp(r'^\d{6}$').hasMatch(widget.formData.businessRegNumber)) 'bizReg',
        if (!RegExp(r'^\d{6}$').hasMatch(widget.formData.licenseNumber)) 'licNum',
        if (!RegExp(r'^\d{10}$').hasMatch(widget.formData.telephone))    'tel',
        if (widget.formData.establishmentName.isEmpty) 'estName',
        if (widget.formData.establishmentAddress.isEmpty) 'estAddr',
        if (widget.formData.licensedDate.isEmpty) 'licDate',
        if (widget.formData.typeOfTrade.isEmpty)  'trade',
        if (widget.formData.numberOfEmployees.isEmpty ||
            int.tryParse(widget.formData.numberOfEmployees) == null) 'emp',
        if (widget.formData.ownerName.isEmpty) 'owner',
        if (widget.formData.privateAddress.isEmpty) 'privAddr',
        if (widget.formData.nicNumber.isEmpty) 'nic',
      ]);
    setState(() {});
    return _invalid.isEmpty;
  }

  bool _isErr(String key) => _invalid.contains(key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(children: [
            const SizedBox(height: 20),
            _header(context),
            const SizedBox(height: 20),

            _numField('Reference Number', 'reference', maxLen: 6,
                onChanged: (v)=>widget.formData.referenceNo=v),
            _numField('Business Registration Number', 'bizReg', maxLen: 6,
                onChanged: (v)=>widget.formData.businessRegNumber=v),

            _txtField('Name of the Establishment', 'estName',
                onChanged:(v)=>widget.formData.establishmentName=v),
            _txtField('Address of the Establishment', 'estAddr',
                onChanged:(v)=>widget.formData.establishmentAddress=v),

            _readOnlyField('District', widget.formData.district),
            _gnDropdown(),

            _numField('License Number', 'licNum', maxLen: 6,
                onChanged:(v)=>widget.formData.licenseNumber=v),
            LicensedYearField(
              label:'Licensed Date',
              isInvalid:_isErr('licDate'),
              initialValue:widget.formData.licensedDate,
              onDatePicked:(v)=>widget.formData.licensedDate=v,
            ),

            SearchableTradeDropdown(
              initial:widget.formData.typeOfTrade,
              onSelected:(v)=>widget.formData.typeOfTrade=v,
              isInvalid:_isErr('trade'),
            ),

            _numField('Number of Employees', 'emp',
                onChanged:(v)=>widget.formData.numberOfEmployees=v),

            _txtField('Name of the Owner', 'owner',
                onChanged:(v)=>widget.formData.ownerName=v),
            _txtField('NIC Number', 'nic',
                onChanged:(v)=>widget.formData.nicNumber=v),
            _txtField('Private Address', 'privAddr',
                onChanged:(v)=>widget.formData.privateAddress=v),
            _numField('Telephone Number', 'tel', maxLen:10,
                onChanged:(v)=>widget.formData.telephone=v),

            const SizedBox(height: 30),
            NextButton(onPressed: (){
              if(_validate()){
                Navigator.pushNamed(
                  context,
                  '/register_shop_screen_two',
                  arguments: widget.formData,
                );
              }
            }),
          ]),
        ),
      ]),
    );
  }

  // ---------------- widgets helpers ----------------
  Widget _header(BuildContext ctx)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal:25),
    child: Row(children:[
      InkWell(
        onTap:()=>Navigator.pop(ctx),
        child:Container(
            padding:const EdgeInsets.all(8),
            decoration:BoxDecoration(
                color:const Color(0xFFCDE6FE),
                borderRadius:BorderRadius.circular(6)),
            child:const Icon(Icons.arrow_back_rounded,color:Color(0xFF1F41BB))),
      ),
      const SizedBox(width:12),
      const Text('Register New Shop',
          style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
    ]),
  );

  Widget _txtField(String label,String key,{required ValueChanged<String> onChanged}) =>
      FormTextField(
        label:label,
        isInvalid:_isErr(key),
        initialValue:'',
        onChanged:onChanged,
      );

  Widget _numField(String label,String key,{required ValueChanged<String> onChanged,int? maxLen}) =>
      FormTextField(
        label:label,
        isInvalid:_isErr(key),
        initialValue:'',
        inputType:TextInputType.number,
        maxLength:maxLen,
        onChanged:onChanged,
      );

  Widget _readOnlyField(String label,String value)=>Padding(
    padding:const EdgeInsets.symmetric(horizontal:25,vertical:8),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(label,style:const TextStyle(fontSize:18)),
      const SizedBox(height:6),
      Container(
        padding:const EdgeInsets.symmetric(vertical:12,horizontal:12),
        width:double.infinity,
        decoration:BoxDecoration(
          color:Colors.grey[200],
          borderRadius:BorderRadius.circular(10),
        ),
        child:Text(value.isEmpty?'…':value,
            style:const TextStyle(fontSize:16)),
      ),
    ]),
  );

  Widget _gnDropdown()=>Padding(
    padding:const EdgeInsets.symmetric(horizontal:25,vertical:8),
    child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        const Text('GN Division',style:TextStyle(fontSize:18)),
        const SizedBox(height:6),
        Container(
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(10),
            border:Border.all(color:_isErr('gn')?Colors.red:const Color(0xFF4289FC)),
          ),
          padding:const EdgeInsets.symmetric(horizontal:12),
          child:DropdownButtonHideUnderline(
            child:DropdownButton<String>(
              value:_gnOptions.contains(widget.formData.gnDivision)
                  ? widget.formData.gnDivision
                  : null,
              hint:const Text('Select GN Division'),
              isExpanded:true,
              items:_gnOptions.map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),
              onChanged:(v){
                setState(()=>widget.formData.gnDivision=v??'');
              },
            ),
          ),
        ),
      ],
    ),
  );
}
