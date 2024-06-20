import 'package:flutter/material.dart';
import 'package:hypermarket_user/core/constants/color.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  bool card = false;
  bool upi = false;
  bool cod = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              card == false
                  ? Hero(
                      tag: 'valuecheck',
                      child: InkWell(
                        onTap: () {
                          card = !card;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.credit_card),
                                  SizedBox(width: 20),
                                  Text("Card Payment")
                                ],
                              ),
                              SizedBox(
                                  width: 100,
                                  child: Image.asset("assets/11.png"))
                            ],
                          ),
                        ),
                      ),
                    )
                  : Hero(
                      tag: 'valuecheck',
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildCardNumberTextField(
                                controller: _cardNumberController,
                                hintText: 'Card Number',
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: _expiryDateController,
                                      decoration: InputDecoration(
                                        labelText: 'Expiry Date',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: _buildCVVTextField(
                                      controller: _cvvController,
                                      hintText: 'CVV',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              //TextField(
                              //  controller: _upiIdController,
                              //  decoration: InputDecoration(
                              //    labelText: 'UPI ID',
                              //  ),
                              //),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        card = !card;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:
                                                    ColorConstant.hyperGrey)),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: ColorConstant.mainBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (_cardNumberController.text.length ==
                                                16 &&
                                            isNumeric(
                                                _cardNumberController.text) &&
                                            _cvvController.text.length == 3 &&
                                            isNumeric(_cvvController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Payment processed!'),
                                            ),
                                          );
                                          card = !card;
                                        } else {
                                          // Show error snack bar for invalid input
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please enter valid Card Number and CVV'),
                                            ),
                                          );
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConstant.primaryGreen),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Pay",
                                            style: TextStyle(
                                                color: ColorConstant.mainWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Image.asset("assets/aaa.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  upi = !upi;
                  setState(() {});
                },
                child: upi == false
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.password),
                                SizedBox(width: 20),
                                Text("UPI")
                              ],
                            ),
                            SizedBox(
                                width: 100,
                                height: 20,
                                child: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo-vector.svg/1280px-UPI-Logo-vector.svg.png"))
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _upiIdController,
                                decoration: InputDecoration(
                                  labelText: 'Enter your UPI (sample@ybl)',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter UPI ID';
                                  }
                                  if (!value.contains('@')) {
                                    return 'UPI ID should contain "@" symbol';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12.0),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        upi = !upi;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:
                                                    ColorConstant.hyperGrey)),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: ColorConstant.mainBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (_upiIdController.text
                                            .contains('@')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Payment processed!'),
                                            ),
                                          );
                                          upi = !upi;
                                        } else {
                                          // Show error snack bar for invalid input
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please enter a valid UPI ID'),
                                            ),
                                          );
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConstant.primaryGreen),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Pay",
                                            style: TextStyle(
                                                color: ColorConstant.mainWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  cod = !cod;
                  setState(() {});
                },
                child: cod == false
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.payments),
                                SizedBox(width: 20),
                                Text("Direct cash payment")
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        cod = !cod;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:
                                                    ColorConstant.hyperGrey)),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: ColorConstant.mainBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Payment processed!'),
                                          ),
                                        );
                                        cod = !cod;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConstant.primaryGreen),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Conform",
                                            style: TextStyle(
                                                color: ColorConstant.mainWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  Widget _buildCardNumberTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 16,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        if (value.length != 16) {
          return 'Card number should be 16 digits';
        }
        if (!isNumeric(value)) {
          return 'Please enter a valid card number';
        }
        return null;
      },
    );
  }

  Widget _buildCVVTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 3,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        if (value.length != 3) {
          return 'CVV should be 3 digits';
        }
        if (!isNumeric(value)) {
          return 'Please enter a valid CVV';
        }
        return null;
      },
    );
  }

  // Function to check if a string contains only numbers
  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
