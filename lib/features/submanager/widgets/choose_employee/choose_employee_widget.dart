// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/get_all_employees/employee_card_info.dart';
import 'package:untitled1/back_end_test/get_all_employees/get_employee_cards_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/sales_manager_requests/sales_manager_request_model.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/models/pricing_policy_model.dart';
import 'package:untitled1/features/submanager/data/create_sales_manager_deal.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_card.dart/choose_employee_card.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ChooseEmployeeWidget extends StatefulWidget {
  const ChooseEmployeeWidget({
    super.key,
    required this.userAuthInfo,
    required this.dealRequest,
  });

  final UserAuthInfo userAuthInfo;
  final DealRequestCardInfo dealRequest;

  @override
  State<ChooseEmployeeWidget> createState() => _ChooseEmployeeWidgetState();
}

class _ChooseEmployeeWidgetState extends State<ChooseEmployeeWidget> {
  final CancelToken _cancelToken = CancelToken();
  final _maxPhasedPriceController = TextEditingController();
  final _minListingPriceController = TextEditingController();
  final _maxListingPriceController = TextEditingController();
  final _profitMarginController = TextEditingController();
  final _rentalPeriodController = TextEditingController();

  bool _isLoading = false;
  bool _isAssigning = false;
  bool _hasLoadedEmployees = false;
  String? _error;
  PricingPolicyModel? _pricingPolicy;
  List<EmployeeCardInfo> _employees = [];
  int _selectedEmployeeIndex = 0;

  bool get _isSaleLease {
    final type = _dealType;
    return type == 'SALE' || type == 'LEASE';
  }

  String get _dealType {
    final type = widget.dealRequest.type.trim().toUpperCase();
    return type == 'SELL' ? 'SALE' : type;
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _maxPhasedPriceController.dispose();
    _minListingPriceController.dispose();
    _maxListingPriceController.dispose();
    _profitMarginController.dispose();
    _rentalPeriodController.dispose();
    super.dispose();
  }

  Future<void> _loadEmployees() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _hasLoadedEmployees = true;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
      final employees = await getEmployeeCardsInfo(
        dioClient: dioClient,
        cancelToken: _cancelToken,
      );
      final matchingEmployees =
          employees
              .where(
                (employee) =>
                    employee.employeeType.toUpperCase() ==
                    _employeeRoleForRequest(),
              )
              .toList()
            ..shuffle();

      PricingPolicyModel? pricingPolicy;

      if (_isSaleLease) {
        // pricingPolicy = await getPricingPolicy(
        //   dioClient: dioClient,
        //   cancelToken: _cancelToken,
        //   city: 'Jadah',
        //   propertyType: 'APARTMENT',
        // );
      }

      if (!mounted) return;

      setState(() {
        _employees = matchingEmployees.take(5).toList();
        _pricingPolicy = pricingPolicy;
        _selectedEmployeeIndex = 0;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _assignDeal() async {
    if (_employees.isEmpty) return;

    final employee = _employees[_selectedEmployeeIndex];
    setState(() {
      _isAssigning = true;
      _error = null;
    });

    try {
      final dioClient = DioClient(userAuthInfo: widget.userAuthInfo);

      if (_isSaleLease) {
        await createSaleLeaseDeal(
          dioClient: dioClient,
          cancelToken: _cancelToken,
          propertyId: widget.dealRequest.id,
          clientId: widget.dealRequest.clientId,
          employeeId: employee.employeeId,
          dealType: _dealType,
          maxPhasedPrice: _numValue(_maxPhasedPriceController),
          minListingPrice: _numValue(_minListingPriceController),
          maxListingPrice: _numValue(_maxListingPriceController),
          profitMargin: _numValue(_profitMarginController),
          rentalPeriod: _dealType == 'LEASE'
              ? int.tryParse(_rentalPeriodController.text.trim())
              : null,
        );
      } else {
        print(widget.dealRequest.id);
        print(widget.dealRequest.clientId);
        print(employee.employeeId);
        print(_dealType);
        await createBuyRentDeal(
          dioClient: dioClient,
          cancelToken: _cancelToken,
          propertyId: widget.dealRequest.id,
          clientId: widget.dealRequest.clientId,
          employeeId: employee.employeeId,
          dealType: _dealType,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('deal created successfully')),
      );
      setState(() {
        _isAssigning = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString().replaceFirst('Exception: ', '');
        _isAssigning = false;
      });
    }
  }

  String _employeeRoleForRequest() {
    switch (_dealType) {
      case 'SALE':
        return 'SALES';
      case 'LEASE':
        return 'LEASE';
      case 'BUY':
        return 'PURCHASING';
      case 'RENT':
        return 'RENTAL';
      default:
        return _dealType;
    }
  }

  int _suitabilityForIndex(int index) => 96 - (index * 5);

  num _numValue(TextEditingController controller) {
    return num.tryParse(controller.text.trim()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * (1080 / 1920),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CreateLeadButton(
            isLoading: _isLoading,
            onPressed: _isLoading ? null : _loadEmployees,
          ),
          SizedBox(height: width * (16 / 1920)),
          if (_hasLoadedEmployees) ...[
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(
                _error!,
                style: TextStyle(
                  color: sixthColorPrimaryRed,
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (16 / 1920),
                ),
              )
            else if (_employees.isEmpty)
              Text(
                'No matching employees found',
                style: TextStyle(
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (16 / 1920),
                ),
              )
            else
              Column(
                children: [
                  SizedBox(
                    width: width * (760 / 1920),
                    height: width * (630 / 1920),
                    child: ListView.builder(
                      itemCount: _employees.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEmployeeIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: width * (8 / 1920),
                            ),
                            child: ChooseEmployeeCard(
                              employee: _employees[index],
                              suitability: _suitabilityForIndex(index),
                              isSelected: _selectedEmployeeIndex == index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_isSaleLease) ...[
                    _PricingPolicyInfo(
                      pricingPolicy: _pricingPolicy,
                      dealType: _dealType,
                    ),
                    SizedBox(height: width * (18 / 1920)),
                    _SaleLeaseFields(
                      maxPhasedPriceController: _maxPhasedPriceController,
                      minListingPriceController: _minListingPriceController,
                      maxListingPriceController: _maxListingPriceController,
                      profitMarginController: _profitMarginController,
                      rentalPeriodController: _rentalPeriodController,
                      showRentalPeriod: _dealType == 'LEASE',
                    ),
                  ],
                  SizedBox(height: width * (22 / 1920)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.isDarkMode
                          ? darkPrimaryColor
                          : primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * (48 / 1920),
                        vertical: width * (18 / 1920),
                      ),
                    ),
                    onPressed: _isAssigning ? null : _assignDeal,
                    child: Text(
                      _isAssigning ? 'Assigning...' : 'Assign',
                      style: TextStyle(
                        color: getTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (18 / 1920),
                      ),
                    ),
                  ),
                  SizedBox(height: width * (30 / 1920)),
                ],
              ),
          ],
        ],
      ),
    );
  }
}

class _CreateLeadButton extends StatelessWidget {
  const _CreateLeadButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeProvider.isDarkMode
            ? darkPrimaryColor
            : primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: width * (45 / 1920),
          vertical: width * (18 / 1920),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * (6 / 1920)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        isLoading ? 'Loading...' : 'Create Deal',
        style: TextStyle(
          color: getTextColor(themeProvider.isDarkMode),
          fontFamily: 'NunitoSans-Bold',
          fontSize: width * (20 / 1920),
        ),
      ),
    );
  }
}

class _PricingPolicyInfo extends StatelessWidget {
  const _PricingPolicyInfo({
    required this.pricingPolicy,
    required this.dealType,
  });

  final PricingPolicyModel? pricingPolicy;
  final String dealType;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final isSale = dealType == 'SALE';
    // final profitMargin = isSale
    //     ? pricingPolicy?.sellProfitMargin
    //     : pricingPolicy?.rentProfitMargin;
    // final listingMargin = isSale
    //     ? pricingPolicy?.saleListingMargin
    //     : pricingPolicy?.rentListingMargin;

    return Container(
      width: width * (820 / 1920),
      padding: EdgeInsets.symmetric(
        horizontal: width * (22 / 1920),
        vertical: width * (18 / 1920),
      ),
      decoration: BoxDecoration(
        color: getCardColor(themeProvider.isDarkMode),
        borderRadius: BorderRadius.circular(width * (8 / 1920)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _PolicyValue(
            title: isSale ? 'Sell Profit Margin' : 'Rent Profit Margin',
            value: '5%',
          ),
          _PolicyValue(
            title: isSale ? 'Sale Listing Margin' : 'Rent Listing Margin',
            value: '9%',
          ),
          _PolicyValue(title: 'expected price', value: '10200'),
        ],
      ),
    );
  }

  // String _percentText(double? value) {
  //   if (value == null) return '-';
  //   return '${(value * 100).toStringAsFixed(1)}%';
  // }
}

class _PolicyValue extends StatelessWidget {
  const _PolicyValue({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: getHintTextColor(themeProvider.isDarkMode),
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (17 / 1920),
          ),
        ),
        SizedBox(height: width * (6 / 1920)),
        Text(
          value,
          style: TextStyle(
            color: getPrimaryTextColor(themeProvider.isDarkMode),
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (23 / 1920),
          ),
        ),
      ],
    );
  }
}

class _SaleLeaseFields extends StatelessWidget {
  const _SaleLeaseFields({
    required this.maxPhasedPriceController,
    required this.minListingPriceController,
    required this.maxListingPriceController,
    required this.profitMarginController,
    required this.rentalPeriodController,
    required this.showRentalPeriod,
  });

  final TextEditingController maxPhasedPriceController;
  final TextEditingController minListingPriceController;
  final TextEditingController maxListingPriceController;
  final TextEditingController profitMarginController;
  final TextEditingController rentalPeriodController;
  final bool showRentalPeriod;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * (820 / 1920),
      child: Wrap(
        spacing: width * (18 / 1920),
        runSpacing: width * (16 / 1920),
        children: [
          _DealNumberField(
            controller: maxPhasedPriceController,
            hintText: 'Max Phased Price',
          ),
          _DealNumberField(
            controller: minListingPriceController,
            hintText: 'Min Listing Price',
          ),
          _DealNumberField(
            controller: maxListingPriceController,
            hintText: 'Max Listing Price',
          ),
          _DealNumberField(
            controller: profitMarginController,
            hintText: 'Profit Margin',
          ),
          if (showRentalPeriod)
            _DealNumberField(
              controller: rentalPeriodController,
              hintText: 'Rental Period',
            ),
        ],
      ),
    );
  }
}

class _DealNumberField extends StatelessWidget {
  const _DealNumberField({required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * (395 / 1920),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: getPrimaryTextColor(themeProvider.isDarkMode),
          fontFamily: 'NunitoSans-Regular',
          fontSize: width * (18 / 1920),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: getHintTextColor(themeProvider.isDarkMode),
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (18 / 1920),
          ),
          filled: true,
          fillColor: getCardColor(themeProvider.isDarkMode),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * (8 / 1920)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * (20 / 1920),
            vertical: width * (18 / 1920),
          ),
        ),
      ),
    );
  }
}
