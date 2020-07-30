import 'dart:convert';
import 'package:http/http.dart' as http;

Future getMemes() async {
  final url = 'https://api.imgflip.com/get_memes';
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var memes = data['data']['memes'];
    return memes;
  } else {
    print(response.statusCode);
  }
}

Future generateMeme(
    {String id,
    String username,
    String password,
    String text0,
    String text1,
    String maxFontSize,
    String font}) async {
  final String url = 'https://api.imgflip.com/caption_image';

  http.Response response = await http.post(
    url,
    body: {
      'template_id': id,
      'username': username,
      'password': password,
      'text0': text0,
      'text1': text1,
      'max_font_size': maxFontSize,
      'font': font,
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['success'] == true) {
      return data['data']['url'];
    } else {
      print('Generation failed');
      print(data['error_message']);
      // showDialog(
      //     context: context,
      //     builder: (context) => SimpleDialog(
      //           title: Text('Error Generating Meme!'),
      //           contentPadding: EdgeInsets.all(20.0),
      //           children: <Widget>[
      //             Text(data['error_message']),
      //           ],
      //         ));
    }
  }
}
