import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Clova{
  final apiURL = 'https://zp8rrjf47i.apigw.ntruss.com/custom/v1/24397/7b50d31ceaa021de059374371153a3ef5f1353a184df9ebd874269a23a174339/document/receipt';
  String? secretKey;
  late File imageFile;
  Map<String,dynamic> requestJSON = {
    'images': [
      {
        'format': '',
        'name': '',
      },
    ],
    'requestId': Uuid().v4(),
    'version': 'V2',
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  };


  getSecretKey() async{
    secretKey = await File("key.txt").readAsString();
  }

  Clova(File receipt){
    imageFile = receipt;
  }

  Future<dynamic> analyze() async{
    var path = imageFile.path.split('.');
    String name;
    String format;

    if(path.length <= 1){
      print("Path error : invalid path");
      return null;
    }
    name = path.first;
    format = path.last;
    requestJSON['images'][0]['name'] = name;
    requestJSON['images'][0]['format'] = format;

    await getSecretKey();

    final payload = {'message': jsonEncode(requestJSON)};
    final headers = {'X-OCR-SECRET': secretKey!};

    final request = http.MultipartRequest('POST', Uri.parse(apiURL))
      ..headers.addAll(headers)
      ..fields.addAll(payload)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final res = jsonDecode(responseBody);

        return res;
      } else {
        print('POST failed: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occured: $error');
    }
  }
}

void main() async{
  Clova test = Clova(File('마라탕.jpg'));
  var result = await test.analyze();
  print(result);

}