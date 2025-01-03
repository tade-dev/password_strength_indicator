import 'package:flutter/material.dart';
import 'package:password_strength_indicator/resources/colors_x.dart';

// ignore: must_be_immutable
class PasswordStrengthWid extends StatefulWidget {
  PasswordStrengthWid({super.key, required this.value});

  String value;

  @override
  State<PasswordStrengthWid> createState() => _PasswordStrengthWidState();
}

class _PasswordStrengthWidState extends State<PasswordStrengthWid> {
  String currentStrength = "Weak";
  double strengthScore = 0.0;

  void updateStrength(double strength) {
    setState(() {
      if (strength < 1.2 / 4) {
        currentStrength = "Weak";
      } else if (strength < 2.3 / 4) {
        currentStrength = "Average";
      } else if (strength < 3.2 / 4) {
        currentStrength = "Good";
      } else {
        currentStrength = "Strong";
      }
    });
  }

  double calculateStrength(String password) {
    double score = 0;

    if (password.length >= 8) score += 0.25;
    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]'))) score += 0.25;
    if (password.contains(RegExp(r'\d'))) score += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score += 0.25;

    return score;
  }

  @override
  void initState() {
    super.initState();
    strengthScore = calculateStrength(widget.value);
    updateStrength(strengthScore);
  }

  @override
  void didUpdateWidget(covariant PasswordStrengthWid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      strengthScore = calculateStrength(widget.value);
      updateStrength(strengthScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  currentStrength,
                  style: getLightStyle(color: Color(0xff1A1A1A), fontSize: 14),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: strengthScore < 1.2 / 4
                                ? Color(0xffDC2828)
                                : strengthScore < 2.3 / 4
                                    ? Color(0xffE7B008)
                                    : strengthScore < 3.2 / 4
                                        ? Color(0xff34C759)
                                        : Color(0xff16A249),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: strengthScore < 1.2 / 4
                                ? Colors.grey.shade300
                                : strengthScore < 2.3 / 4
                                    ? Color(0xffE7B008)
                                    : strengthScore < 3.2 / 4
                                        ? Color(0xff34C759)
                                        : Color(0xff16A249),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: strengthScore < 2.3 / 4
                                ? Colors.grey.shade300
                                : strengthScore < 3.2 / 4
                                    ? Color(0xff34C759)
                                    : Color(0xff16A249),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: strengthScore < 3.2 / 4
                                ? Colors.grey.shade300
                                : Color(0xff16A249),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Validation rules
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildValidationRow(
                "Must be at least 8 characters.",
                widget.value.length >= 8,
              ),
              const SizedBox(height: 5,),
              _buildValidationRow(
                "Capital letters and lowercase, e.g. A and a.",
                widget.value.contains(RegExp(r'[A-Z]')) &&
                    widget.value.contains(RegExp(r'[a-z]')),
              ),
              const SizedBox(height: 5,),
              _buildValidationRow(
                "Numbers, e.g. 1234567890.",
                widget.value.contains(RegExp(r'\d')),
              ),
              const SizedBox(height: 5,),
              _buildValidationRow(
                "Special characters, e.g. !@#\$%^&*()_+{}.",
                widget.value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: getLightStyle(
            color: isValid ? ColorManager.labelGrey : Colors.red,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
