// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bacaBerita extends StatefulWidget {
  const bacaBerita({Key? key}) : super(key: key);
  @override
  _bacaBeritaState createState() => _bacaBeritaState();
}

class _bacaBeritaState extends State<bacaBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF22215B),)
        ),
        title: Text(
          'Baca Berita',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Container(
                  width: 400,
                  child:Image.asset('assets/img/bg-ws.jpg',
                    height: 260,
                    //width: 160,
                  ),
                ),
                SizedBox(height:10),
                Text(
                  'Small Step Big Impact, dari Limbah Sampah hingga Jadi Bernilai Ekonomis dan Bermanfaat',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height:10),
                Text(
                  'Masalah lingkungan kini menjadi hal yang perlu menjadi perhatian.Karena apa yang kita lakukan sekarang bisa berdampak untuk masa depan anak cucu kita. Untuk itu hari ini diluncurkan Sustainability Initiatif “Small Step Big Impact” Langkah kecil untuk Kebaikan Masa Depan. Sebuah inisiatif berkelanjutan sebagai bentuk komitmen perusahaan terhadap masyarakat dan lingkungan. Program ini mengajak masyarakat untuk mulai membuat perubahan melalui langkah-langkah kecil dan positif sejak usia dini. Melalui langkah kecil tersebut, diharapkan kepedulian terhadap masyarakat dan lingkungan akan memberikan keberlangsungan kehidupan yang lebih baik bagi generasi mendatang. “PZ Cussons percaya bahwa bisnis dapat menjadi kekuatan untuk memberi perubahan positif. Kami memahami bahwa kegiatan bisnis bisa memberikan kontribusi positif kepada masyarakat oleh karena itu, kami meluncurkan Inisiatif Keberlanjutan: Small Step Big Impact for a Better Future atau Langkah Kecil yang Memberi Manfaat Besar,  untuk Masa Depan yang Lebih Baik. Kegiatan ini fokus pada tiga bidang yaitu; Pendidikan, Kebersihan dan Kepedulian terhadap Penggunaan Plastik untuk masyarakat di Indonesia,” ujar Managing Director PZ Cussons Asia, Dimitris Kostianis. Baca Juga: Ramah Lingkungan, Ini Rekomendasi Home Decor dari Eceng Gondok DeputiBidang Pembangunan Manusia, Masyarakat, Dan Kebudayaan Kementerian PPN / Bappenas, Dr. Ir. Subandi, MSc.,menyambut baik PZ Cussons sustainability initiative, Small Step Big Impact ini. Bappenas sebagaipelaksanapemerintah yang ditunjuk oleh presiden menyoroti 17 Sustainable Development Goals (SDGs) yang berkaitan dengan kebutuhan masyarakat Indonesia untuk tumbuh sejahtera. “Apa yang dilakukan PZ Cussons dengan meluncurkan Small Step Big Impact ini sejalan dengan berbagai tujuan SDGs pemerintah dan kami siap memfasilitasi dan mendukung kegiatan ini. "Inisiatif dan partnership seperti ini juga harus digaungkan agar dunia usaha lain bisa meniru dan bersama pemerintah, media, serta masyarakat mendukung keberhasilan SDGs,” ujarnya dalam Konferensi Pers PZ Cussons Small Step Big Impact hari ini (25/08/2021).',
                  style: GoogleFonts.lato(
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.justify
                ),
                SizedBox(height: 40),
              ],
            ),
          )
        ],
      )
    );
  }
}