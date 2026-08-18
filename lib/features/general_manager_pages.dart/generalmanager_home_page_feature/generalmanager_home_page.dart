import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/datasources/get_pricing_policy.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/models/pricing_policy_model.dart';
import 'package:untitled1/providers/theme_provider.dart';

class GeneralmanagerHomePage extends StatefulWidget {
  const GeneralmanagerHomePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<GeneralmanagerHomePage> createState() => _GeneralmanagerHomePageState();
}

class _GeneralmanagerHomePageState extends State<GeneralmanagerHomePage> {
  final List<String> areas = [
    'Damascus',
    'Hama',
    'Homs',
    'Tartous',
    'Aleppo',
    'Al-Hasakah',
    'Raqqa',
    'Deir ez-Zor',
    'Quneitra',
    'As-Suwayda',
    'Jadah',
    'Dubai',
  ];

  final List<String> propertyTypes = [
    'APARTMENT',
    'Villa',
    'Office',
    'Store',
    'Hall',
  ];

  _MarginConfig? propertyProfitMargins;
  _MarginConfig? listingPriceMargins;
  _AdjustmentConfig? propertyPriceAdjustment;
  int _inputVersion = 0;

  dynamic _pricingPolicyModel;
  final CancelToken _cancelToken = CancelToken();
  String _city = 'Jadah';
  String _propertyType = 'APARTMENT';

  Future<void> _getPricingPolicy() async {
    print(_city);
    DioClient dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
    PricingPolicyModel pricingPolicyModel = await getPricingPolicy(
      cancelToken: _cancelToken,
      city: _city,
      propertyType: _propertyType,
      dioClient: dioClient,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _pricingPolicyModel = pricingPolicyModel;
      propertyProfitMargins = _MarginConfig(
        region: _pricingPolicyModel.city,
        propertyType: _pricingPolicyModel.propertyType,
        saleMargin: _pricingPolicyModel.sellProfitMargin.toString(),
        rentMargin: _pricingPolicyModel.rentProfitMargin.toString(),
      );

      listingPriceMargins = _MarginConfig(
        region: _pricingPolicyModel.city,
        propertyType: _pricingPolicyModel.propertyType,
        saleMargin: _pricingPolicyModel.saleListingMargin.toString(),
        rentMargin: _pricingPolicyModel.rentListingMargin.toString(),
      );

      propertyPriceAdjustment = _AdjustmentConfig(
        region: _pricingPolicyModel.city,
        propertyType: _pricingPolicyModel.propertyType,
        saleSign: '+',
        saleAdjustment: _pricingPolicyModel.saleGlobalAdjust.toString(),
        rentSign: '-',
        rentAdjustment: _pricingPolicyModel.rentGlobalAdjust.toString(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getPricingPolicy();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    if (propertyPriceAdjustment == null) {
      return CircularProgressIndicator();
    }

    return Container(
      width: width * (1920 / 1920),
      height: width * (882 / 1920),
      color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * (40 / 1920),
              vertical: width * (20 / 1920),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: themeProvider.isDarkMode
                        ? getPrimaryTextColor(true)
                        : getPrimaryTextColor(false),
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  tooltip: 'Toggle Theme',
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (40 / 1920)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT SIDE
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _marginConfigurationCard(
                                width,
                                title: 'Property Profit Margins',
                                config: propertyProfitMargins!,
                                onChanged: (config) {
                                  setState(() {
                                    propertyProfitMargins = config;
                                    _city = config.region;
                                    _propertyType = config.propertyType;
                                    propertyProfitMargins =
                                        propertyProfitMargins!.confirmed();
                                    _inputVersion++;
                                  });

                                  _getPricingPolicy();
                                },
                                onConfirm: () {
                                  setState(() {});
                                },
                                onCancel: () {
                                  setState(() {
                                    propertyProfitMargins =
                                        propertyProfitMargins!.cancelled();
                                    _inputVersion++;
                                  });
                                },
                              ),
                              SizedBox(height: width * (22 / 1920)),
                              _marginConfigurationCard(
                                width,
                                title: 'Listing Price Margins',
                                config: listingPriceMargins!,
                                onChanged: (config) {
                                  setState(() {
                                    listingPriceMargins = config;
                                    _city = config.region;
                                    _propertyType = config.propertyType;
                                    propertyProfitMargins =
                                        propertyProfitMargins!.confirmed();
                                    _inputVersion++;
                                  });

                                  _getPricingPolicy();
                                },
                                onConfirm: () {
                                  setState(() {});
                                },
                                onCancel: () {
                                  setState(() {
                                    listingPriceMargins = listingPriceMargins!
                                        .cancelled();
                                    _inputVersion++;
                                  });
                                },
                              ),
                              SizedBox(height: width * (22 / 1920)),
                              _priceAdjustmentCard(
                                width,
                                config: propertyPriceAdjustment!,
                                onChanged: (config) {
                                  setState(() {
                                    propertyPriceAdjustment = config;
                                    _city = config.region;
                                    _propertyType = config.propertyType;
                                    propertyProfitMargins =
                                        propertyProfitMargins!.confirmed();
                                    _inputVersion++;
                                  });

                                  _getPricingPolicy();
                                },
                                onConfirm: () {
                                  setState(() {});
                                },
                                onCancel: () {
                                  setState(() {
                                    propertyPriceAdjustment =
                                        propertyPriceAdjustment!.cancelled();
                                    _inputVersion++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: width * (35 / 1920)),

                  /// RIGHT SIDE
                  SizedBox(
                    width: width * (500 / 1920),

                    child: Column(
                      children: [
                        /// BUSINESS HEALTH
                        Container(
                          width: double.infinity,
                          height: width * (430 / 1920),

                          decoration: BoxDecoration(
                            color: getBusinessHealthColor(
                              themeProvider.isDarkMode,
                            ),

                            borderRadius: BorderRadius.circular(
                              width * (24 / 1920),
                            ),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: width * (8 / 1920),
                                color: getShadowColor(themeProvider.isDarkMode),
                                offset: Offset(0, width * (4 / 1920)),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: width * (78 / 1920),

                                decoration: BoxDecoration(
                                  color: getBusinessHealthHeaderColor(
                                    themeProvider.isDarkMode,
                                  ),

                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      width * (24 / 1920),
                                    ),
                                    topRight: Radius.circular(
                                      width * (24 / 1920),
                                    ),
                                  ),
                                ),

                                child: Center(
                                  child: Text(
                                    'Business Health Indicator',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans-Bold',
                                      fontSize: width * (25 / 1920),
                                      color: getPrimaryTextColor(
                                        themeProvider.isDarkMode,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: [
                                    _healthRow(
                                      width,
                                      image: 'assets/images/Handshake.png',
                                      title: 'Active deals',
                                      value: '22',
                                    ),

                                    _healthRow(
                                      width,
                                      icon: Icons.home_work_rounded,
                                      title: 'Idle properties',
                                      value: '40',
                                    ),

                                    _healthRow(
                                      width,
                                      icon: Icons.warning_rounded,
                                      title: 'High Risk Deals',
                                      value: '8',
                                    ),

                                    _healthRow(
                                      width,
                                      image:
                                          'assets/images/profilePhoto-icon.png',
                                      title: 'Employee Utilization',
                                      value: '69%',
                                      isLast: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: width * (28 / 1920)),

                        /// ALERTS
                        Expanded(
                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: getCardColor(themeProvider.isDarkMode),

                              borderRadius: BorderRadius.circular(
                                width * (24 / 1920),
                              ),

                              border: Border.all(
                                color: themeProvider.isDarkMode
                                    ? darkAlertBorderColor
                                    : lightAlertBorderColor,
                                width: width * (2 / 1920),
                              ),
                            ),

                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: width * (78 / 1920),

                                  decoration: BoxDecoration(
                                    color: getAlertHeaderColor(
                                      themeProvider.isDarkMode,
                                    ),

                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        width * (24 / 1920),
                                      ),
                                      topRight: Radius.circular(
                                        width * (24 / 1920),
                                      ),
                                    ),
                                  ),

                                  child: Center(
                                    child: Text(
                                      'Alerts',
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Bold',
                                        color: getTextColor(
                                          themeProvider.isDarkMode,
                                        ),
                                        fontSize: width * (32 / 1920),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      width * (20 / 1920),
                                    ),

                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),

                                      itemCount: 3,

                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: width * (16 / 1920)),

                                      itemBuilder: (context, index) {
                                        List<String> alerts = [
                                          '12 properties have been Idle\nfor over 90 days',
                                          'Revenue in Homs dropped by\n50% this month',
                                          'Employee Productivity have\ndecreased by 6%',
                                        ];

                                        return _alertCard(width, alerts[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _marginConfigurationCard(
    double width, {
    required String title,
    required _MarginConfig config,
    required ValueChanged<_MarginConfig> onChanged,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return _configurationCard(
      width,
      title: title,
      region: config.region,
      propertyType: config.propertyType,
      hasChanges: config.hasChanges,
      onRegionChanged: (value) => onChanged(config.copyWith(region: value)),
      onTypeChanged: (value) => onChanged(config.copyWith(propertyType: value)),
      onConfirm: onConfirm,
      onCancel: onCancel,
      child: Row(
        children: [
          Expanded(
            child: _numberInput(
              width,
              label: 'For Sale Profit Margin (%)',
              value: config.saleMargin,
              onChanged: (value) =>
                  onChanged(config.copyWith(saleMargin: value)),
            ),
          ),
          SizedBox(width: width * (24 / 1920)),
          Expanded(
            child: _numberInput(
              width,
              label: 'For Rent Profit Margin (%)',
              value: config.rentMargin,
              onChanged: (value) =>
                  onChanged(config.copyWith(rentMargin: value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceAdjustmentCard(
    double width, {
    required _AdjustmentConfig config,
    required ValueChanged<_AdjustmentConfig> onChanged,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return _configurationCard(
      width,
      title: 'Global Property Price Adjustment',
      region: config.region,
      propertyType: config.propertyType,
      hasChanges: config.hasChanges,
      onRegionChanged: (value) => onChanged(config.copyWith(region: value)),
      onTypeChanged: (value) => onChanged(config.copyWith(propertyType: value)),
      onConfirm: onConfirm,
      onCancel: onCancel,
      child: Row(
        children: [
          Expanded(
            child: _signedNumberInput(
              width,
              label: 'For Sale Adjustment',
              sign: config.saleSign,
              value: config.saleAdjustment,
              onSignChanged: (value) =>
                  onChanged(config.copyWith(saleSign: value)),
              onValueChanged: (value) =>
                  onChanged(config.copyWith(saleAdjustment: value)),
            ),
          ),
          SizedBox(width: width * (24 / 1920)),
          Expanded(
            child: _signedNumberInput(
              width,
              label: 'For Rent Adjustment',
              sign: config.rentSign,
              value: config.rentAdjustment,
              onSignChanged: (value) =>
                  onChanged(config.copyWith(rentSign: value)),
              onValueChanged: (value) =>
                  onChanged(config.copyWith(rentAdjustment: value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _configurationCard(
    double width, {
    required String title,
    required String region,
    required String propertyType,
    required bool hasChanges,
    required ValueChanged<String> onRegionChanged,
    required ValueChanged<String> onTypeChanged,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeProvider().isDarkMode ? darkSecondaryColor : secondaryColor,
        borderRadius: BorderRadius.circular(width * (28 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (8 / 1920),
            color: getShadowColor(ThemeProvider().isDarkMode),
            offset: Offset(0, width * (4 / 1920)),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: width * (96 / 1920),
            decoration: BoxDecoration(
              color: ThemeProvider().isDarkMode
                  ? darkPrimaryColor
                  : primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (28 / 1920)),
                topRight: Radius.circular(width * (28 / 1920)),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (28 / 1920)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        color: Colors.white,
                        fontSize: width * (28 / 1920),
                      ),
                    ),
                  ),
                  SizedBox(width: width * (18 / 1920)),
                  _compactDropDownBox(
                    width,
                    value: region,
                    items: areas,
                    onChanged: (value) => onRegionChanged(value!),
                  ),
                  SizedBox(width: width * (14 / 1920)),
                  _compactDropDownBox(
                    width,
                    value: propertyType,
                    items: propertyTypes,
                    onChanged: (value) => onTypeChanged(value!),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * (28 / 1920),
              vertical: width * (24 / 1920),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child,
                if (hasChanges) ...[
                  SizedBox(height: width * (20 / 1920)),
                  _actionButtons(
                    width,
                    onConfirm: onConfirm,
                    onCancel: onCancel,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _compactDropDownBox(
    double width, {
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: width * (190 / 1920),
      height: width * (52 / 1920),
      padding: EdgeInsets.symmetric(horizontal: width * (12 / 1920)),
      decoration: BoxDecoration(
        color: getInputBackgroundColor(ThemeProvider().isDarkMode),
        borderRadius: BorderRadius.circular(width * (6 / 1920)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: getInputBackgroundColor(ThemeProvider().isDarkMode),
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            color: getSecondaryTextColor(ThemeProvider().isDarkMode),
            fontSize: width * (15 / 1920),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ThemeProvider().isDarkMode ? darkPrimaryColor : primaryColor,
            size: width * (26 / 1920),
          ),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
        ),
      ),
    );
  }

  Widget _numberInput(
    double width, {
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (19 / 1920),
            color: getPrimaryTextColor(ThemeProvider().isDarkMode),
          ),
        ),
        SizedBox(height: width * (10 / 1920)),
        Container(
          height: width * (62 / 1920),
          padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
          decoration: BoxDecoration(
            color: getInputBackgroundColor(ThemeProvider().isDarkMode),
            borderRadius: BorderRadius.circular(width * (6 / 1920)),
          ),
          child: TextFormField(
            key: ValueKey('$label-$_inputVersion'),
            initialValue: value,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontFamily: 'NunitoSans-Regular',
              color: getSecondaryTextColor(ThemeProvider().isDarkMode),
              fontSize: width * (18 / 1920),
            ),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _signedNumberInput(
    double width, {
    required String label,
    required String sign,
    required String value,
    required ValueChanged<String> onSignChanged,
    required ValueChanged<String> onValueChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (19 / 1920),
            color: getPrimaryTextColor(ThemeProvider().isDarkMode),
          ),
        ),
        SizedBox(height: width * (10 / 1920)),
        Row(
          children: [
            _signSelector(width, sign: sign, onChanged: onSignChanged),
            SizedBox(width: width * (12 / 1920)),
            Expanded(
              child: Container(
                height: width * (62 / 1920),
                padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
                decoration: BoxDecoration(
                  color: getInputBackgroundColor(ThemeProvider().isDarkMode),
                  borderRadius: BorderRadius.circular(width * (6 / 1920)),
                ),
                child: TextFormField(
                  key: ValueKey('$label-$_inputVersion'),
                  initialValue: value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Regular',
                    color: getSecondaryTextColor(ThemeProvider().isDarkMode),
                    fontSize: width * (18 / 1920),
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: onValueChanged,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _signSelector(
    double width, {
    required String sign,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      width: width * (72 / 1920),
      height: width * (62 / 1920),
      padding: EdgeInsets.symmetric(horizontal: width * (10 / 1920)),
      decoration: BoxDecoration(
        color: getInputBackgroundColor(ThemeProvider().isDarkMode),
        borderRadius: BorderRadius.circular(width * (6 / 1920)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: sign,
          isExpanded: true,
          dropdownColor: getInputBackgroundColor(ThemeProvider().isDarkMode),
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            color: ThemeProvider().isDarkMode ? darkPrimaryColor : primaryColor,
            fontSize: width * (22 / 1920),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ThemeProvider().isDarkMode ? darkPrimaryColor : primaryColor,
            size: width * (22 / 1920),
          ),
          onChanged: (value) => onChanged(value!),
          items: const [
            DropdownMenuItem(value: '+', child: Text('+')),
            DropdownMenuItem(value: '-', child: Text('-')),
          ],
        ),
      ),
    );
  }

  Widget _actionButtons(
    double width, {
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _actionButton(
          width,
          label: 'Cancel',
          color: getInputBackgroundColor(ThemeProvider().isDarkMode),
          textColor: getSecondaryTextColor(ThemeProvider().isDarkMode),
          onPressed: onCancel,
        ),
        SizedBox(width: width * (14 / 1920)),
        _actionButton(
          width,
          label: 'Confirm',
          color: ThemeProvider().isDarkMode ? darkPrimaryColor : primaryColor,
          textColor: getTextColor(ThemeProvider().isDarkMode),
          onPressed: onConfirm,
        ),
      ],
    );
  }

  Widget _actionButton(
    double width, {
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: width * (130 / 1920),
      height: width * (46 / 1920),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * (8 / 1920)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (16 / 1920),
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _healthRow(
    double width, {
    IconData? icon,
    String? image,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: getPrimaryTextColor(ThemeProvider().isDarkMode),
                    width: width * (1 / 1920),
                  ),
                ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (24 / 1920)),

          child: Row(
            children: [
              image != null
                  ? Image.asset(
                      image,
                      width: width * (42 / 1920),
                      height: width * (42 / 1920),
                    )
                  : Icon(icon, size: width * (42 / 1920), color: primaryColor),

              SizedBox(width: width * (18 / 1920)),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (18 / 1920),
                    color: getPrimaryTextColor(ThemeProvider().isDarkMode),
                  ),
                ),
              ),

              Text(
                value,
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (34 / 1920),
                  color: getPrimaryTextColor(ThemeProvider().isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertCard(double width, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * (26 / 1920),
        vertical: width * (18 / 1920),
      ),

      decoration: BoxDecoration(
        color: getAlertBackgroundColor(ThemeProvider().isDarkMode),

        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'NunitoSans-Regular',
          color: getTextColor(ThemeProvider().isDarkMode),
          fontSize: width * (16 / 1920),
        ),
      ),
    );
  }
}

class _MarginConfig {
  const _MarginConfig({
    required this.region,
    required this.propertyType,
    required this.saleMargin,
    required this.rentMargin,
    String? savedRegion,
    String? savedPropertyType,
    String? savedSaleMargin,
    String? savedRentMargin,
  }) : savedRegion = savedRegion ?? region,
       savedPropertyType = savedPropertyType ?? propertyType,
       savedSaleMargin = savedSaleMargin ?? saleMargin,
       savedRentMargin = savedRentMargin ?? rentMargin;

  final String region;
  final String propertyType;
  final String saleMargin;
  final String rentMargin;
  final String savedRegion;
  final String savedPropertyType;
  final String savedSaleMargin;
  final String savedRentMargin;

  bool get hasChanges =>
      region != savedRegion ||
      propertyType != savedPropertyType ||
      saleMargin != savedSaleMargin ||
      rentMargin != savedRentMargin;

  _MarginConfig copyWith({
    String? region,
    String? propertyType,
    String? saleMargin,
    String? rentMargin,
  }) {
    return _MarginConfig(
      region: region ?? this.region,
      propertyType: propertyType ?? this.propertyType,
      saleMargin: saleMargin ?? this.saleMargin,
      rentMargin: rentMargin ?? this.rentMargin,
      savedRegion: savedRegion,
      savedPropertyType: savedPropertyType,
      savedSaleMargin: savedSaleMargin,
      savedRentMargin: savedRentMargin,
    );
  }

  _MarginConfig confirmed() {
    return _MarginConfig(
      region: region,
      propertyType: propertyType,
      saleMargin: saleMargin,
      rentMargin: rentMargin,
    );
  }

  _MarginConfig cancelled() {
    return _MarginConfig(
      region: savedRegion,
      propertyType: savedPropertyType,
      saleMargin: savedSaleMargin,
      rentMargin: savedRentMargin,
    );
  }
}

class _AdjustmentConfig {
  const _AdjustmentConfig({
    required this.region,
    required this.propertyType,
    required this.saleSign,
    required this.saleAdjustment,
    required this.rentSign,
    required this.rentAdjustment,
    String? savedRegion,
    String? savedPropertyType,
    String? savedSaleSign,
    String? savedSaleAdjustment,
    String? savedRentSign,
    String? savedRentAdjustment,
  }) : savedRegion = savedRegion ?? region,
       savedPropertyType = savedPropertyType ?? propertyType,
       savedSaleSign = savedSaleSign ?? saleSign,
       savedSaleAdjustment = savedSaleAdjustment ?? saleAdjustment,
       savedRentSign = savedRentSign ?? rentSign,
       savedRentAdjustment = savedRentAdjustment ?? rentAdjustment;

  final String region;
  final String propertyType;
  final String saleSign;
  final String saleAdjustment;
  final String rentSign;
  final String rentAdjustment;
  final String savedRegion;
  final String savedPropertyType;
  final String savedSaleSign;
  final String savedSaleAdjustment;
  final String savedRentSign;
  final String savedRentAdjustment;

  bool get hasChanges =>
      region != savedRegion ||
      propertyType != savedPropertyType ||
      saleSign != savedSaleSign ||
      saleAdjustment != savedSaleAdjustment ||
      rentSign != savedRentSign ||
      rentAdjustment != savedRentAdjustment;

  _AdjustmentConfig copyWith({
    String? region,
    String? propertyType,
    String? saleSign,
    String? saleAdjustment,
    String? rentSign,
    String? rentAdjustment,
  }) {
    return _AdjustmentConfig(
      region: region ?? this.region,
      propertyType: propertyType ?? this.propertyType,
      saleSign: saleSign ?? this.saleSign,
      saleAdjustment: saleAdjustment ?? this.saleAdjustment,
      rentSign: rentSign ?? this.rentSign,
      rentAdjustment: rentAdjustment ?? this.rentAdjustment,
      savedRegion: savedRegion,
      savedPropertyType: savedPropertyType,
      savedSaleSign: savedSaleSign,
      savedSaleAdjustment: savedSaleAdjustment,
      savedRentSign: savedRentSign,
      savedRentAdjustment: savedRentAdjustment,
    );
  }

  _AdjustmentConfig confirmed() {
    return _AdjustmentConfig(
      region: region,
      propertyType: propertyType,
      saleSign: saleSign,
      saleAdjustment: saleAdjustment,
      rentSign: rentSign,
      rentAdjustment: rentAdjustment,
    );
  }

  _AdjustmentConfig cancelled() {
    return _AdjustmentConfig(
      region: savedRegion,
      propertyType: savedPropertyType,
      saleSign: savedSaleSign,
      saleAdjustment: savedSaleAdjustment,
      rentSign: savedRentSign,
      rentAdjustment: savedRentAdjustment,
    );
  }
}
