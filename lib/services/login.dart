import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Login {
  static final RegExp regex = RegExp(r"makeCode\('(\d+)'\)");
  static final String baseURL = (dotenv.env['LOGIN_URL'] as String);
  static final String postLoginURL = '$baseURL/employee/loginProc.jsp';

  //로그인
  static Future<String> postLogin(
      String academicNumber, String password) async {
    final response = await http.post(
      Uri.parse(postLoginURL),
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
      },
      body: 'USER_ID=$academicNumber&USER_PW=$password&SAVE_PW=on',
    );

    if (response.statusCode == 200) {
      //로그인 오류
      const String errorMessage = '아이디와 비밀번호를 다시 입력해주세요';
      throw Exception(errorMessage);
    }

    //redirect 처리
    final location = response.headers['location'];
    final cookies = parseCookies(response.headers['set-cookie']!);
    final result = await redirectGetReuest(location!, cookies);

    //Html 코드에서 qr 데이터를 추출
    final match = regex.firstMatch(result);

    if (match == null) {
      //qr data 추출 오류 -> 재시도 유도
      const String errorMessage = '아이디와 비밀번호를 다시 입력해주세요';
      throw Exception(errorMessage);
    }
    final qrData = match.group(1);
    return qrData!;
  }

  static Future<String> redirectGetReuest(
      String location, Map<String, String> cookies) async {
    //헤더에 필요한 쿠키를 담아서 요청
    final headers = {
      'Cookie': cookies.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('; '),
    };

    final response = await http.get(
      Uri.parse('$baseURL$location'),
      headers: headers,
    );
    return response.body;
  }
}

Map<String, String> parseCookies(String cookiesString) {
  //필요한 쿠키만 추출
  final cookies = <String, String>{};

  cookiesString.split(',').forEach((cookie) {
    final keyValue = cookie.trim().split(';')[0].split('=');
    if (keyValue.length == 2) {
      cookies[keyValue[0]] = keyValue[1];
    }
  });

  return cookies;
}
