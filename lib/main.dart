import 'package:flutter/material.dart';
import 'package:otp_fetch/sms_user_consent_me.dart';
// import 'package:sms_user_consent/sms_user_consent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserConsentOtp(),
    );
  }
}

/*SMS verification using the SMS User Consent API */
/*https://developers.google.com/identity/sms-retriever/user-consent/overview */

class UserConsentOtp extends StatefulWidget {
  const UserConsentOtp({super.key});

  @override
  State<UserConsentOtp> createState() => _UserConsentOtpState();
}

class _UserConsentOtpState extends State<UserConsentOtp> {
  late SmsUserConsentMe _smsUserConsent;

  @override
  void initState() {
    super.initState();
    _smsUserConsent = SmsUserConsentMe(
        phoneNumberListener: () => setState(() {}),
        smsListener: () => setState(() {}));
  }

  @override
  void dispose() {
    _smsUserConsent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('sms_user_consent Example'),
            ),
            body: Center(
                child: SizedBox(
              width: 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('To retrieve SMS, make sure the following: '),
                    // SizedBox(height: 8.0),
                    // Text(
                    //     '''- The message contains a 4-10 character alphanumeric string with at least one number.'''),
                    // Text(
                    //     '''- The message was sent by a phone number that's not in the user's contacts.'''),
                    // Text(
                    //     '''- If you specified the sender's phone number, the message was sent by that number.'''),
                    // SizedBox(height: 16.0),
                    // Text('Tap FABs to request Phone number and SMS',
                    //     style: TextStyle(fontWeight: FontWeight.bold)),
                    // SizedBox(height: 16.0),
                    Text(
                        'Selected Phone number: ${_smsUserConsent.selectedPhoneNumber}'),
                    const SizedBox(height: 8.0),
                    Text('Received SMS: ${_smsUserConsent.receivedSms}'),
                    const SizedBox(
                      height: 48.0,
                    ),
                    _smsUserConsent.receivedSms == null
                        ? const SizedBox.shrink()
                        : showOtp(_smsUserConsent.receivedSms!),
                  ]),
            )),
            floatingActionButton:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              // FloatingActionButton(
              //   child: Icon(Icons.phone_android),
              //   onPressed: () => _smsUserConsent.requestPhoneNumber(),
              // ),
              // SizedBox(height: 16.0),
              Builder(
                  builder: (context) => FloatingActionButton(
                      child: const Icon(Icons.sms),
                      onPressed: () {
                        // call your server for sms, then
                        // requestOtp();

                        // _smsUserConsent.requestSms(senderPhoneNumber: '6505551212');
                        _smsUserConsent.requestSms();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Listening for SMS...')));
                      }))
            ])));
  }

  Widget showOtp(String receivedSms) {
    return Text('Your OTP is : ${receivedSms.substring(45, 49)}',
        textScaleFactor: 1.5);
  }
}
