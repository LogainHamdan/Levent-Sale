import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/search-filter.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../../../config/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final double? width;
  final bool? hasFilterIcon;
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    this.hasFilterIcon = true,
    this.width = 223,
    this.onChanged,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Speech status: $val'),
        onError: (val) => print('Speech error: $val'),
      );
      List<stt.LocaleName> locales = await _speech.locales();
      for (var locale in locales) {
        print('Locale: ${locale.localeId} - Name: ${locale.name}');
      }
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'ar_EG',
          onResult: (val) {
            setState(() {
              widget.controller.text = val.recognizedWords;
              if (widget.onChanged != null) {
                widget.onChanged!(val.recognizedWords);
              }
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width!.w,
      height: 44.h,
      child: TextField(
        controller: widget.controller,
        style: GoogleFonts.tajawal(
            textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp)),
        textAlign: TextAlign.right,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.all(10.w),
            child: InkWell(
              onTap: () {
                final text = widget.controller.text.trim();
                if (text.isNotEmpty) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, SearchScreen.id);
                }
              },
              child: Image.asset(searchIcon, height: 24.h, width: 24.w),
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (widget.hasFilterIcon!) ...[
                //   InkWell(
                //     onTap: () => Navigator.pushNamed(context, FilterScreen.id),
                //     child: SvgPicture.asset(
                //       filterIcon,
                //       width: 20.w,
                //       height: 20.h,
                //     ),
                //   ),
                //   SizedBox(width: 5.w),
                //   Container(
                //     height: 20.h,
                //     width: 1.5.w,
                //     color: grey5,
                //   ),
                // ],
                InkWell(
                  onTap: _listen,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: grey5,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          hintStyle: GoogleFonts.tajawal(
              textStyle: TextStyle(
                  color: grey5, fontWeight: FontWeight.w500, fontSize: 16.sp)),
          hintText: 'بحث',
          filled: true,
          fillColor: grey8,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
