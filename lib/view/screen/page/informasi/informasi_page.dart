import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/view/base/widget/header_widget.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({Key? key}) : super(key: key);

  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              Images.header_decoration,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.px, 6.h, 24.px, 3.h),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  HeaderWidget(),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apa Itu WBS (Whistle Blowing System?)',
                                style: robotoBold,
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                textAlign: TextAlign.justify,
                                'Whistleblowing system adalah mekanisme yang memungkinkan individu, seperti karyawan atau pihak lain yang terkait dengan suatu organisasi, untuk melaporkan tindakan yang dianggap melanggar hukum, etika, atau kebijakan internal tanpa takut akan pembalasan atau sanksi. Laporan yang biasanya diberikan melalui sistem ini bisa mencakup pelanggaran seperti penipuan, korupsi, penyalahgunaan wewenang, diskriminasi, atau tindakan tidak etis lainnya.',
                                style: robotoRegular,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                textAlign: TextAlign.justify,
                                'Beberapa elemen kunci dari whistleblowing system adalah:',
                                style: robotoRegular,
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    minLeadingWidth: 1.w,
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: Text(
                                      '1.',
                                      style: robotoRegular,
                                    ),
                                    title: Text(
                                      textAlign: TextAlign.justify,
                                      'Kerahasiaan: Pelapor (whistleblower) dijamin identitasnya tidak akan diketahui oleh pihak yang terlibat dalam pelanggaran tersebut, sehingga mengurangi risiko pembalasan.',
                                      style: robotoRegular,
                                    ),
                                  ),
                                  ListTile(
                                    minLeadingWidth: 1.w,
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: Text(
                                      '2.',
                                      style: robotoRegular,
                                    ),
                                    title: Text(
                                      textAlign: TextAlign.justify,
                                      'Perlindungan terhadap pembalasan: Salah satu tujuan utama dari sistem ini adalah untuk melindungi whistleblower dari tindakan balas dendam, seperti pemecatan atau intimidasi.',
                                      style: robotoRegular,
                                    ),
                                  ),
                                  ListTile(
                                    minLeadingWidth: 1.w,
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: Text(
                                      '3.',
                                      style: robotoRegular,
                                    ),
                                    title: Text(
                                      textAlign: TextAlign.justify,
                                      'Transparansi dan akuntabilitas: Whistleblowing membantu organisasi dalam menjaga transparansi dan mencegah praktik tidak etis, dengan memastikan bahwa pelanggaran dapat segera diketahui dan ditindaklanjuti.',
                                      style: robotoRegular,
                                    ),
                                  ),
                                  ListTile(
                                    minLeadingWidth: 1.w,
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: Text(
                                      '4.',
                                      style: robotoRegular,
                                    ),
                                    title: Text(
                                      textAlign: TextAlign.justify,
                                      'Proses yang jelas: Organisasi harus memiliki prosedur yang jelas dan dapat diakses untuk pelaporan, baik secara anonim atau dengan identitas jelas, serta menyediakan jalur untuk tindak lanjut laporan tersebut.',
                                      style: robotoRegular,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                textAlign: TextAlign.justify,
                                'Whistleblowing system sering diterapkan di berbagai organisasi, baik di sektor publik maupun swasta, dan penting untuk menjaga integritas serta mematuhi peraturan yang berlaku. Dalam beberapa negara, ada juga undang-undang yang memberikan perlindungan khusus bagi whistleblower untuk mendorong pelaporan pelanggaran tanpa rasa takut akan reperkusi.',
                                style: robotoRegular,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
