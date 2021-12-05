import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_compress/video_compress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VdoCompress(),
    );
  }
}

class VdoCompress extends StatefulWidget {
  @override
  _VdoCompressState createState() => _VdoCompressState();
}

class _VdoCompressState extends State<VdoCompress> {
  var vdoPath;
  late Subscription _subscription;
  var progres = 0.0;

  @override
  void initState() {
    super.initState();

    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      setState(() {
        progres = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Compress"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.video,
                  );
                  print("----->>>---${result!.files.single.path}");
                  if (result != null) {
                    setState(() {
                      vdoPath = result.files.single.path;
                    });
                  } else {
                    //do somthing
                  }
                },
                child: const Text("Pick video")),

            SizedBox(height: 25,),
            ElevatedButton(
                onPressed: () {
                  vdoCompress();
                },
                child: const Text("Compress")),

            SizedBox(height: 25,),

            Text("Progress : $progres",textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  vdoCompress() async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      vdoPath,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false, // It's false by default
    );
    print("----------$mediaInfo");
  }
}
