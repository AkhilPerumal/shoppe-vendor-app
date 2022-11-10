import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({Key key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class ExpandItem {
  ExpandItem({
    this.isExpanded,
    this.title,
    this.body,
  });
  bool isExpanded;
  String title;
  String body;
}

class _TermsState extends State<Terms> {
  List<ExpandItem> expansionData = <ExpandItem>[
    ExpandItem(
        title: '1. Consent',
        body:
            '''By using the Website and/ or by providing your information, you consent to the collection and use of the information you disclose on the Website in accordance with this Privacy Policy, including but not limited to your consent for sharing your information as per this Privacy Policy. If you disclose any personal information relating to other people to us, you represent that you have the authority to do so and to permit us to use the information in accordance with this Privacy Policy.'''),
    ExpandItem(
        title: '2. Amendment',
        body:
            '''Our Privacy Policy is subject to change at any time without notice. To make sure you are aware of any changes, please review this policy periodically.'''),
    ExpandItem(
        title:
            '3. Collection of Personally Identifiable Information and other Information',
        body:
            '''When you use our Website, we collect and store your personal information such as name, contact number, email address etc. which is provided by you from time to time. Our primary goal in doing so is to be able to contact you for the services requested by you and to provide you a safe, efficient, smooth and customized experience.
In general, you can browse the Website without telling us who you are or revealing any personal information about yourself. Once you give us your personal information, you are not anonymous to us. Where possible, we indicate which fields are required and which fields are optional for us to contact you. You always have the option to not provide information, however, in such an instance we will not be able to contact you.
If you choose to post comments on our “Reach Us” page or leave feedback, we will collect that information you provide to us.

'''),
    ExpandItem(
        title: '4. Use of Profile Data / Your Information',
        body:
            '''We use personal information to provide the services you request. To the extent we use your personal information to market to you, we will provide you the ability to opt-out of such uses.
We identify and use your IP address to help diagnose problems with our server, and to administer our Website. Your IP address is also used to help identify you and to gather broad demographic information. We also use this information to do internal research on our users’ demographics, interests, and behavior to better understand, protect and serve our users. This information is compiled and analyzed on an aggregated basis. This information may include the URL that you just came from (whether this URL is on our Website or not), which URL you next go to (whether this URL is on our Website or not), your computer browser information, and your IP address.
We retain any information as necessary to contact you and provide support as permitted by law.'''),
    ExpandItem(
        title: '5. Sharing of personal information',
        body:
            '''We may share personal information with our affiliates. We do not disclose your personal information to third parties for their marketing and advertising purposes without your explicit consent.
We may disclose personal information if required to do so by law or in the good faith belief that such disclosure is reasonably necessary to respond to subpoenas, court orders, or other legal process. We may disclose personal information to law enforcement offices, third party rights owners, or others in the good faith belief that such disclosure is reasonably necessary to: enforce our Terms of Use or Privacy Policy; respond to claims that an advertisement, posting or other content violates the rights of a third party; or protect the rights, property or personal safety of our users or the general public.
We and our affiliates will share some or all of your personal information with another business entity should we (or our assets) plan to merge with, or be acquired by that business entity, or re-organization, amalgamation, restructuring of business. Should such a transaction occur that other business entity (or the new combined entity) will be required to follow this Privacy Policy with respect to your personal information.'''),
    ExpandItem(
        title: '6. Links to Other Sites',
        body:
            '''Our Website may contain links to other websites that may collect personally identifiable information about you. We are not responsible for the privacy practices or the content of those linked websites.'''),
    ExpandItem(
        title: '7. Security Precautions',
        body:
            '''Our Website has stringent security measures in place to protect the loss, misuse, and alteration of the information under our control. Once your information is in our possession, we adhere to strict security guidelines, protecting it against unauthorized access.'''),
    ExpandItem(
        title: '8. Cookies',
        body:
            '''A “cookie” is a small piece of information stored by a web server on a web browser so it can be later read back from that browser. Cookies are useful for enabling the browser to remember information specific to a given user. We place both permanent and temporary cookies in your computer’s hard drive. The cookies do not contain any of your personally identifiable information.
We use data collection devices such as “cookies” on certain pages of the Website to help analyze our web page flow, measure promotional effectiveness, and promote trust and safety. “Cookies” are small files placed on your hard drive that assist us in providing our services. We offer certain features that are only available through the use of a “cookie”. Cookies can also help us provide information that is targeted to your interests. Most cookies are “session cookies,” meaning that they are automatically deleted from your hard drive at the end of a session. You are always free to decline our cookies if your browser permits, although in that case you may not be able to use certain features on the Website.
Additionally, you may encounter “cookies” or other similar devices on certain pages of the Website that are placed by third parties. We do not control the use of cookies by third parties.'''),
    ExpandItem(
        title: '9. Choice/Opt-Out',
        body:
            '''We provide all users with the opportunity to opt-out of receiving non-essential (promotional, marketing-related) communications from us or on behalf of our partners.
If you want to remove your contact information from our server or want to unsubscribe to any newsletters or alerts from us, please contact us on the email address mentioned under clause 12 below.'''),
    ExpandItem(
        title: '10. Advertisements',
        body:
            '''We may use third-party advertising companies to serve ads when you visit our Website. These companies may use information (not including your name, address, email address, or telephone number) about your visits to this and other websites in order to provide advertisements about goods and services of interest to you.''')
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              //Image.asset('assets/image/privacy.png'),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: expansionData
                      .map((ExpandItem item) => ExpansionTile(
                            collapsedTextColor: Colors.black,
                            title: Text(item.title),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.body),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          )),
    );
  }
}
