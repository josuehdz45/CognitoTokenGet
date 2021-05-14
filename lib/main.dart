import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// [See] https://pub.dev/packages/oauth2_client
void main() {
  runApp(QRCognito());
}

class QRCognito extends StatefulWidget {
  QRCognito({Key key}) : super(key: key);

  @override
  _QRCognitoState createState() => _QRCognitoState();
}

class _QRCognitoState extends State<QRCognito> {

	String _iniToken = "init";
  
	_QRCognitoState() {
		getQR().then((value) => setState(() {
			_iniToken = value.accessToken.toString();
		}));

		const oneSec = const Duration(seconds: 20);
		new Timer.periodic(oneSec, (Timer t) => {
			getQR().then((value) => setState(() {
					_iniToken = value.accessToken.toString();
			}))
		});
	}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("QR Cognito Demo")
        ),
        body: ListView(
          children: [
            Center(
              child: QrImage(
								data: "10|10|" + _iniToken,
								version: QrVersions.auto,
								size: 500.0,
							),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    // var client = OAuth2Client(
                    //   authorizeUrl: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
                    //   tokenUrl: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
                    //   redirectUri: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
                    //   customUriScheme: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token"
                    // );
                    
                    // var tknResp = client.getTokenWithClientCredentialsFlow(
                    //   clientId: "7kb18l23kn8e9hvtqob7i4lb5e",
                    //   clientSecret: "1o9p3f0qebh2sac3dhjjfghj0v3vjpsrgae2qbdom9pjfv2s48d4",
                    // );
                    // tknResp.then((value) => {
                    //   this.Token = value.accessToken.toString()
                    // });
                  });
                },
                child: Text("GENERATE TOKEN"),
              ),
            )
          ],
        )
      ),
    );
  }

	Future getQR() async {
		var client = OAuth2Client(
			authorizeUrl: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
			tokenUrl: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
			redirectUri: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token",
			customUriScheme: "https://beneficios-api.auth.us-east-1.amazoncognito.com/oauth2/token"
		);
		
		return await client.getTokenWithClientCredentialsFlow(
			clientId: "7kb18l23kn8e9hvtqob7i4lb5e",
			clientSecret: "1o9p3f0qebh2sac3dhjjfghj0v3vjpsrgae2qbdom9pjfv2s48d4",
		);
	}
}