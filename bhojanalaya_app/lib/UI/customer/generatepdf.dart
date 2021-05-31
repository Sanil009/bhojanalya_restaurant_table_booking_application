import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:bhojanalaya_app/constants.dart';

class GeneratePDF extends StatefulWidget {
  List list;
  int index;
  Map<String, dynamic> r;
  Map<String, dynamic> c;

  GeneratePDF({this.list, this.index, this.c, this.r});
  @override
  _GeneratePDFState createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  @override
  void initState() {
    super.initState();
  }

  final pdf = pw.Document();
  writeOnPdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(level: 0, text: "Customer Info:  "),
            // pw.Header(
            //   level: 0,
            //   child: pw.Text("User:  " + widget.c["name"]),
            // ),
            // pw.Paragraph(
            //   text: "Customer:  " + widget.c["id"],
            // ),
            pw.Paragraph(
              text: "Customer:  " + widget.c["name"],
            ),

            // Restaurant Info
            pw.Header(level: 0, text: "Restaurant Information:"),
            // pw.Paragraph(
            //   text: "Restaurant:  " + widget.r["id"],
            // ),
            pw.Paragraph(
              text: "Restaurant:  " + widget.r["name"],
            ),

            //Booking Info
            pw.Header(level: 0, text: "Booking Information:"),
            // pw.Paragraph(
            //     text: "Bookings:  " +
            //         widget.list[widget.index]["booking_status"]),
            pw.Paragraph(
                text: "Bookings:  " + widget.list[widget.index]["booked_date"]),

            pw.Paragraph(
                text: "Bookings:  " + widget.list[widget.index]["booked_time"]),

            //Disclaimer
            pw.Header(
              level: 1,
              child: pw.Text('Disclaimer: '),
            ),
            pw.Paragraph(
                text: "This invoice is proof of your booking. Keep it safely"),
            pw.Header(
              level: 0,
              child: pw.Text(
                'BHOJANALAYA APPROVED',
              ),
            ),
          ];
        },
      ),
    );
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;

    File file = File("$documentPath/booking_invoice.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Invoice",
            style: kTextStyle,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Tap on the preview button below",
                style: kTextStyle,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            writeOnPdf();
            await savePdf();
            Directory documentDirectory =
                await getApplicationDocumentsDirectory();
            String documentPath = documentDirectory.path;
            print(documentPath);
            String fullPath = "$documentPath/booking_invoice.pdf";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new PDFPreviewScreen(path: fullPath)));
          },
          child: Icon(Icons.preview),
        ),
      );
}

class PDFPreviewScreen extends StatelessWidget {
  final String path;
  PDFPreviewScreen({this.path});
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}

// import 'package:http/http.dart' as http;
