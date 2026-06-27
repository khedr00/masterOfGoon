import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/add_employee/add_employee.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class AddEmployeeWidget extends StatefulWidget {
  const AddEmployeeWidget({super.key, required this.userAuthInfo});

  final UserAuthInfo userAuthInfo;

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  bool _isLoading = false;

  String _selectedRole = 'SALES';

  final List<String> _roles = [
    'SALES',
    'PURCHASE',
    'RENTAL',
    'LEASE',
    'SUPPORT',
    'CONSULTANT',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  Future<void> _addEmployee() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await addEmployee(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        name: _nameController.text.trim(),
        role: _selectedRole,
        fullName: _fullNameController.text.trim(),
        location: _locationController.text.trim(),
        phone: _phoneController.text.trim(),
        salary: int.parse(_salaryController.text),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee Added Successfully')),
      );

      _nameController.clear();
      _fullNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _phoneController.clear();
      _locationController.clear();
      _salaryController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _textField({
    required double width,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Dialog(
      child: Container(
        width: width * (200 / 1920),
        height: width * (60 / 1920),
        padding: EdgeInsets.symmetric(horizontal: width * (25 / 1920)),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: getPrimaryTextColor(themeProvider.isDarkMode),
        //     width: width * (2 / 1920),
        //   ),
        // ),
        child: Center(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: getPrimaryTextColor(themeProvider.isDarkMode),
              fontFamily: 'NunitoSans-Medium',
              fontSize: width * (24 / 1920),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Medium',
                fontSize: width * (24 / 1920),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleDropdown(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Dialog(
      child: Container(
        width: width * (200 / 1920),
        height: width * (60 / 1920),
        padding: EdgeInsets.symmetric(horizontal: width * (20 / 1920)),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: getPrimaryTextColor(themeProvider.isDarkMode),
        //     width: width * (2 / 1920),
        //   ),
        // ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedRole,
            isExpanded: true,
            style: TextStyle(
              color: getPrimaryTextColor(themeProvider.isDarkMode),
              fontFamily: 'NunitoSans-Medium',
              fontSize: width * (24 / 1920),
            ),
            items: _roles.map((role) {
              return DropdownMenuItem(value: role, child: Text(role));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRole = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width;

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: width * (1000 / 1920),
          height: width * (700 / 1920),
          color: themeProvider.isDarkMode
              ? darkBackGroundColor
              : backGroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        _textField(
                          width: width,
                          hint: 'Employee Name',
                          controller: _nameController,
                        ),
                        SizedBox(height: width * (10 / 1920)),
                        _textField(
                          width: width,
                          hint: 'Full Name',
                          controller: _fullNameController,
                        ),
                        SizedBox(height: width * (10 / 1920)),
                        _textField(
                          width: width,
                          hint: 'Employee Email',
                          controller: _emailController,
                        ),
                        SizedBox(height: width * (10 / 1920)),
                        _textField(
                          width: width,
                          hint: 'Employee Password',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          'Employee Type',
                          style: TextStyle(
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (32 / 1920),
                          ),
                        ),

                        SizedBox(height: width * (10 / 1920)),

                        _roleDropdown(width),

                        SizedBox(height: width * (10 / 1920)),

                        _textField(
                          width: width,
                          hint: 'Phone',
                          controller: _phoneController,
                        ),

                        SizedBox(height: width * (10 / 1920)),

                        _textField(
                          width: width,
                          hint: 'Location',
                          controller: _locationController,
                        ),

                        SizedBox(height: width * (10 / 1920)),

                        _textField(
                          width: width,
                          hint: 'Salary',
                          controller: _salaryController,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: width * (20 / 1920)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWithText(
                      widthOfButton: width * (200 / 1920),
                      heightOfButton: width * (60 / 1920),
                      text: 'Cancel',
                      buttonAction: () {
                        Navigator.pop(context);
                      },
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ButtonWithText(
                            widthOfButton: width * (420 / 1920),
                            heightOfButton: width * (60 / 1920),
                            text: 'Add Employee',
                            buttonAction: _addEmployee,
                          ),
                  ],
                ),

                SizedBox(height: width * (80 / 1920)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
