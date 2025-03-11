import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class CodeRow extends StatelessWidget {
  const CodeRow({super.key});

  @override
  Widget build(BuildContext context) {
    List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VerificationProvider>(context, listen: false)
          .setSelectedIndex(0);
    });

    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Consumer<VerificationProvider>(
              builder: (context, provider, child) {
                List<String> otpList = provider.getOtp();
                String value = otpList[index];
                bool isEmpty = value == '0' || value.isEmpty;
                bool isSelected = provider.selectedIndex == index;

                return Container(
                  width: 50.w,
                  height: 50.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: grey7,
                    border: Border.all(
                      color: (isSelected ||
                              (!isEmpty && otpList[index].isNotEmpty))
                          ? kprimaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: TextField(
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      autofocus: index == 0,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        hintText: "0",
                        hintStyle: TextStyle(color: grey4),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (val) {
                        provider.updateOtp(val.isEmpty ? '0' : val, index);

                        if (val.isNotEmpty && index < 5) {
                          FocusScope.of(context)
                              .requestFocus(focusNodes[index + 1]);
                          provider.setSelectedIndex(index + 1);
                        }
                        if (otpList.every((element) =>
                            element != '0' && element.isNotEmpty)) {
                          provider.submitOtpAction(context);
                        }
                      },
                      onTap: () {
                        provider.setSelectedIndex(index);
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
