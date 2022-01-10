import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Config.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/function.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lectures',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends  StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  String video ='';
  bool isLoading = false;
  String output = 'translation';
  var data;
  String url = '';
  var name;
  var videoUrl;
  choseVideo()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      setState(() {
        video = file.path!;
        videoUrl=file.path;
        name = file.name;
       url='http://10.0.2.2:5000/api?query=' + name.toString();
      });
      print(name);
    } else {
      // User canceled the picker
    }
  }


  
  Future saveVideo()async
  {
    final uri = Uri.parse(Config.SAVE_URL);
    var request = http.MultipartRequest("POST",uri);
    var uploadVideo =await http.MultipartFile.fromPath("my_video", videoUrl);
    request.files.add(uploadVideo);
    var response = await request.send();

    setState(() {
      isLoading = true;
    });

    if(response.statusCode==200)
      {
        print(response.reasonPhrase);
      }
    data= await (fetchdata(url)) ;
    print(data);
    setState(() {
      isLoading=false;
      output=data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Lectures")),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: OutlinedButton(onPressed: (){choseVideo();},child: Text("Upload Video"),)),
          SizedBox(height: 20,),
          Text(name !=null?name:"Select A Video"),
          SizedBox(height: 20,),
          BetterPlayer.network(video,
          betterPlayerConfiguration: BetterPlayerConfiguration(aspectRatio: 16/9,looping: true,autoPlay: true,fit: BoxFit.contain),
          ),
          MaterialButton(
              color: Colors.blue,
              onPressed: (){saveVideo();setState(() {
                isLoading=true;

              });},child: Text("Translate Lecture",style: TextStyle(color: Colors.white),),),
            SingleChildScrollView(

                child: isLoading? CircularProgressIndicator(


                ): Text(output))
          ],
        ),
      ),
    );
  }
}
