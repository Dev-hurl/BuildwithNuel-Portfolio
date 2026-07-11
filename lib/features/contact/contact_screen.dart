import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    throw Exception('Could not launch $url');
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  static const double _wideBreakpoint = 800; // same cutoff as About page

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedService;
  String? _selectedBudget;

  bool _isSubmitting = false;
  String? _statusMessage;
  bool _statusIsError = false;

  // TODO: replace with your real Formspree endpoint after signup
  static const String _formEndpoint = 'https://formspree.io/f/xdaqnneq';

  static const List<String> _services = [
    'Fintech App',
    'E-commerce App',
    'Taxi & Delivery App',
    'UI/UX Design Only',
    'Other',
  ];

  // Generic tiers, no currency committed yet — swap for real ranges later
  static const List<String> _budgets = [
    'Small',
    'Medium',
    'Large',
    'Not sure yet',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validateService(String? value) {
    if (value == null || value.isEmpty) return 'Please select a service';
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) return 'Message is required';
    if (value.trim().length < 10) return 'Message is too short';
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _statusMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(_formEndpoint),
        headers: {'Accept': 'application/json'},
        body: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'website': _websiteController.text.trim(),
          'service': _selectedService ?? '',
          'budget': _selectedBudget ?? '',
          'message': _messageController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = "Message sent — thanks for reaching out!";
          _statusIsError = false;
          _selectedService = null;
          _selectedBudget = null;
        });
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _websiteController.clear();
        _messageController.clear();
      } else {
        setState(() {
          _statusMessage = 'Something went wrong. Try again or email directly.';
          _statusIsError = true;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Network error. Check your connection and try again.';
        _statusIsError = true;
      });
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > ContactScreen._wideBreakpoint;
        return isWide ? _buildWide(context) : _buildNarrow(context);
      },
    );
  }

  Widget _buildWide(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: _ContactIntro()),
          SizedBox(width: 32),
          Expanded(flex: 5, child: _buildFormCard(context)),
        ],
      ),
    );
  }

  Widget _buildNarrow(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ContactIntro(),
          SizedBox(height: 32),
          _buildFormCard(context),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _LabeledField(
                    label: 'Name',
                    controller: _nameController,
                    hint: 'Your Name',
                    validator: _validateName,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _LabeledField(
                    label: 'Email',
                    controller: _emailController,
                    hint: 'Your Email',
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _LabeledField(
              label: 'Website (optional)',
              controller: _websiteController,
              hint: 'Company Website',
            ),
            SizedBox(height: 16),
            _LabeledDropdown(
              label: 'Service you need',
              value: _selectedService,
              hint: 'Select a service...',
              items: _services,
              validator: _validateService,
              onChanged: (value) => setState(() => _selectedService = value),
            ),
            /*SizedBox(height: 16),
            _LabeledDropdown(
              label: 'Budget',
              value: _selectedBudget,
              hint: 'Select budget...',
              items: _budgets,
              onChanged: (value) => setState(() => _selectedBudget = value),
            ),*/
            SizedBox(height: 16),
            _LabeledField(
              label: 'Message',
              controller: _messageController,
              hint: 'Your Message',

              validator: _validateMessage,
              maxLines: 5,
            ),
            SizedBox(height: 24),
            if (_statusMessage != null) ...[
              Text(
                _statusMessage!,
                style: TextStyle(
                  color: _statusIsError ? Colors.redAccent : AppColors.accent,
                ),
              ),
              SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Send message',
                        style: TextStyle(
                          fontSize: AppFonts.bodySize,
                          color: AppColors.textPrimary,
                          fontWeight: AppFonts.bodyWeight,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactIntro extends StatelessWidget {
  const _ContactIntro();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: textTheme.headlineMedium,
            children: [
              TextSpan(text: "Let's Collaborate "),
              TextSpan(
                text: 'and Begin the work',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Prefer to book a call?',
                  style: textTheme.titleLarge,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 180,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _launchUrl(
                    'https://cal.com/buildwithnuel/1-1-project-consultation',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Let's Book A Call",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppFonts.bodySize,
                      fontWeight: AppFonts.bodyWeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: AppFonts.body,
            fontSize: 11,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: AppFonts.body,
            fontSize: AppFonts.captionSize,
            fontWeight: AppFonts.bodyWeight,
            color: AppColors.textPrimary,
          ),

          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              fontSize: AppFonts.captionSize,
              fontWeight: AppFonts.bodyWeight,
            ),

            filled: true,
            fillColor: AppColors.surfaceVariant,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}

class _LabeledDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final List<String> items;
  final String? Function(String?)? validator;
  final void Function(String?) onChanged;

  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: AppFonts.body,
            fontSize: 11,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: value,
          validator: validator,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppFonts.captionSize,
                      fontWeight: AppFonts.bodyWeight,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          dropdownColor: AppColors.surfaceVariant,
          hint: Text(
            hint,
            style: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              fontSize: AppFonts.captionSize,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceVariant,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
