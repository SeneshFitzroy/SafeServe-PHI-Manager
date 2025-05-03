class RegisterShopFormData {
  // Screen 1
  String referenceNo        = '';
  String businessRegNumber  = '';
  String establishmentName  = '';
  String establishmentAddress = '';
  String district           = ''; // prefilled, read‑only
  String gnDivision         = ''; // from dropdown
  String licenseNumber      = '';
  String licensedDate       = ''; // yyyy‑MM‑dd
  String typeOfTrade        = '';
  String numberOfEmployees  = '';
  String ownerName          = '';
  String nicNumber          = '';
  String privateAddress     = '';
  String telephone          = '';

  // Screen 2
  String? photoPath;  // local path
  double? lat;
  double? lng;

  // Derived
  String? photoUrl;   // filled online or on flush
}
