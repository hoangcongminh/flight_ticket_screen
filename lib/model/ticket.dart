import 'package:equatable/equatable.dart';

class Ticket {
  bool? success;
  int? code;
  String? message;
  String? meta;
  List<TicketItem>? data;

  Ticket({this.success, this.code, this.message, this.meta, this.data});

  Ticket.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    meta = json['meta'];
    if (json['elements'] != null) {
      data = <TicketItem>[];
      json['elements'].forEach((v) {
        data!.add(TicketItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    data['meta'] = meta;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketItem {
  String? currency;
  int? dn401;
  String? dv402;
  int? dn403;
  int? dn404;
  int? dn405;
  int? dn407;
  int? dn408;
  int? dn409;
  int? dn410;
  int? dn411;
  int? dn412;
  int? dn413;
  int? dn414;
  int? dn415;
  int? dn416;
  int? dn417;
  int? dn418;
  int? dn422;
  int? dn423;
  int? dn424;
  String? session;
  List<Fd100>? fd100;
  int? dn425;
  int? typeF;
  int? minMonth;
  int? step;
  int? flightType;
  String? id;

  TicketItem(
      {this.currency,
      this.dn401,
      this.dv402,
      this.dn403,
      this.dn404,
      this.dn405,
      this.dn407,
      this.dn408,
      this.dn409,
      this.dn410,
      this.dn411,
      this.dn412,
      this.dn413,
      this.dn414,
      this.dn415,
      this.dn416,
      this.dn417,
      this.dn418,
      this.dn422,
      this.dn423,
      this.dn424,
      this.session,
      this.fd100,
      this.dn425,
      this.typeF,
      this.minMonth,
      this.step,
      this.flightType,
      this.id});

  TicketItem.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    dn401 = json['dn401'];
    dv402 = json['dv402'];
    dn403 = json['dn403'];
    dn404 = json['dn404'];
    dn405 = json['dn405'];
    dn407 = json['dn407'];
    dn408 = json['dn408'];
    dn409 = json['dn409'];
    dn410 = json['dn410'];
    dn411 = json['dn411'];
    dn412 = json['dn412'];
    dn413 = json['dn413'];
    dn414 = json['dn414'];
    dn415 = json['dn415'];
    dn416 = json['dn416'];
    dn417 = json['dn417'];
    dn418 = json['dn418'];
    dn422 = json['dn422'];
    dn423 = json['dn423'];
    dn424 = json['dn424'];
    session = json['session'];
    if (json['fd100'] != null) {
      fd100 = <Fd100>[];
      json['fd100'].forEach((v) {
        fd100!.add(Fd100.fromJson(v));
      });
    }
    dn425 = json['dn425'];
    typeF = json['typeF'];
    minMonth = json['minMonth'];
    step = json['step'];
    flightType = json['flightType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['dn401'] = dn401;
    data['dv402'] = dv402;
    data['dn403'] = dn403;
    data['dn404'] = dn404;
    data['dn405'] = dn405;
    data['dn407'] = dn407;
    data['dn408'] = dn408;
    data['dn409'] = dn409;
    data['dn410'] = dn410;
    data['dn411'] = dn411;
    data['dn412'] = dn412;
    data['dn413'] = dn413;
    data['dn414'] = dn414;
    data['dn415'] = dn415;
    data['dn416'] = dn416;
    data['dn417'] = dn417;
    data['dn418'] = dn418;
    data['dn422'] = dn422;
    data['dn423'] = dn423;
    data['dn424'] = dn424;
    data['session'] = session;
    if (fd100 != null) {
      data['fd100'] = fd100!.map((v) => v.toJson()).toList();
    }
    data['dn425'] = dn425;
    data['typeF'] = typeF;
    data['minMonth'] = minMonth;
    data['step'] = step;
    data['flightType'] = flightType;
    data['id'] = id;
    return data;
  }
}

class Fd100 {
  String? pd400;
  int? dn101;
  String? dv102;
  int? dn103;
  String? dv104;
  String? dv105;
  List<String>? dd106;
  List<String>? dd107;
  String? dv108;
  int? dn109;
  int? dn110;
  int? dn111;
  int? dn112;
  String? dv113;
  String? dv114;
  int? dn115;
  String? dv116;
  String? session;
  int? dn117;
  List<Fd300>? fd300;
  String? dv118;
  String? dv119;
  String? dv121;
  String? dv122;
  D800? d800;
  String? id;
  String? dv120;

  Fd100(
      {this.pd400,
      this.dn101,
      this.dv102,
      this.dn103,
      this.dv104,
      this.dv105,
      this.dd106,
      this.dd107,
      this.dv108,
      this.dn109,
      this.dn110,
      this.dn111,
      this.dn112,
      this.dv113,
      this.dv114,
      this.dn115,
      this.dv116,
      this.session,
      this.dn117,
      this.fd300,
      this.dv118,
      this.dv119,
      this.dv121,
      this.dv122,
      this.d800,
      this.id,
      this.dv120});

  Fd100.fromJson(Map<String, dynamic> json) {
    pd400 = json['pd400'];
    dn101 = json['dn101'];
    dv102 = json['dv102'];
    dn103 = json['dn103'];
    dv104 = json['dv104'];
    dv105 = json['dv105'];
    dd106 = json['dd106'].cast<String>();
    dd107 = json['dd107'].cast<String>();
    dv108 = json['dv108'];
    dn109 = json['dn109'];
    dn110 = json['dn110'];
    dn111 = json['dn111'];
    dn112 = json['dn112'];
    dv113 = json['dv113'];
    dv114 = json['dv114'];
    dn115 = json['dn115'];
    dv116 = json['dv116'];
    session = json['session'];
    dn117 = json['dn117'];
    if (json['fd300'] != null) {
      fd300 = <Fd300>[];
      json['fd300'].forEach((v) {
        fd300!.add(Fd300.fromJson(v));
      });
    }
    dv118 = json['dv118'];
    dv119 = json['dv119'];
    dv121 = json['dv121'];
    dv122 = json['dv122'];
    d800 = json['d800'] != null ? D800.fromJson(json['d800']) : null;
    id = json['id'];
    dv120 = json['dv120'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pd400'] = pd400;
    data['dn101'] = dn101;
    data['dv102'] = dv102;
    data['dn103'] = dn103;
    data['dv104'] = dv104;
    data['dv105'] = dv105;
    data['dd106'] = dd106;
    data['dd107'] = dd107;
    data['dv108'] = dv108;
    data['dn109'] = dn109;
    data['dn110'] = dn110;
    data['dn111'] = dn111;
    data['dn112'] = dn112;
    data['dv113'] = dv113;
    data['dv114'] = dv114;
    data['dn115'] = dn115;
    data['dv116'] = dv116;
    data['session'] = session;
    data['dn117'] = dn117;
    if (fd300 != null) {
      data['fd300'] = fd300!.map((v) => v.toJson()).toList();
    }
    data['dv118'] = dv118;
    data['dv119'] = dv119;
    data['dv121'] = dv121;
    data['dv122'] = dv122;
    if (d800 != null) {
      data['d800'] = d800!.toJson();
    }
    data['id'] = id;
    data['dv120'] = dv120;
    return data;
  }
}

class Fd300 {
  String? pd100;
  int? dn301;
  String? dv302;
  String? dv303;
  String? dv304;
  List<String>? dd306;
  List<String>? dd307;
  String? dv308;
  int? dn309;
  String? dv310;
  String? dv311;
  int? dn314;
  int? dn316;
  int? dn317;
  int? dn318;
  int? dn319;
  int? dn320;
  int? dn321;
  String? dv322;
  String? dv324;
  String? dv325;
  String? dv326;
  String? dv327;
  String? dv328;
  String? dv329;
  String? dv333;
  D800? d800;
  String? id;
  String? dv323;

  Fd300(
      {this.pd100,
      this.dn301,
      this.dv302,
      this.dv303,
      this.dv304,
      this.dd306,
      this.dd307,
      this.dv308,
      this.dn309,
      this.dv310,
      this.dv311,
      this.dn314,
      this.dn316,
      this.dn317,
      this.dn318,
      this.dn319,
      this.dn320,
      this.dn321,
      this.dv322,
      this.dv324,
      this.dv325,
      this.dv326,
      this.dv327,
      this.dv328,
      this.dv329,
      this.dv333,
      this.d800,
      this.id,
      this.dv323});

  Fd300.fromJson(Map<String, dynamic> json) {
    pd100 = json['pd100'];
    dn301 = json['dn301'];
    dv302 = json['dv302'];
    dv303 = json['dv303'];
    dv304 = json['dv304'];
    dd306 = json['dd306'].cast<String>();
    dd307 = json['dd307'].cast<String>();
    dv308 = json['dv308'];
    dn309 = json['dn309'];
    dv310 = json['dv310'];
    dv311 = json['dv311'];
    dn314 = json['dn314'];
    dn316 = json['dn316'];
    dn317 = json['dn317'];
    dn318 = json['dn318'];
    dn319 = json['dn319'];
    dn320 = json['dn320'];
    dn321 = json['dn321'];
    dv322 = json['dv322'];
    dv324 = json['dv324'];
    dv325 = json['dv325'];
    dv326 = json['dv326'];
    dv327 = json['dv327'];
    dv328 = json['dv328'];
    dv329 = json['dv329'];
    dv333 = json['dv333'];
    d800 = json['d800'] != null ? D800.fromJson(json['d800']) : null;
    id = json['id'];
    dv323 = json['dv323'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pd100'] = pd100;
    data['dn301'] = dn301;
    data['dv302'] = dv302;
    data['dv303'] = dv303;
    data['dv304'] = dv304;
    data['dd306'] = dd306;
    data['dd307'] = dd307;
    data['dv308'] = dv308;
    data['dn309'] = dn309;
    data['dv310'] = dv310;
    data['dv311'] = dv311;
    data['dn314'] = dn314;
    data['dn316'] = dn316;
    data['dn317'] = dn317;
    data['dn318'] = dn318;
    data['dn319'] = dn319;
    data['dn320'] = dn320;
    data['dn321'] = dn321;
    data['dv322'] = dv322;
    data['dv324'] = dv324;
    data['dv325'] = dv325;
    data['dv326'] = dv326;
    data['dv327'] = dv327;
    data['dv328'] = dv328;
    data['dv329'] = dv329;
    data['dv333'] = dv333;
    if (d800 != null) {
      data['d800'] = d800!.toJson();
    }
    data['id'] = id;
    data['dv323'] = dv323;
    return data;
  }
}

class D800 {
  String? dv801;
  String? dv802;
  String? dv803;
  int? dn805;
  String? dv810;
  String? dv811;
  List<Fd801>? fd801;
  String? id;

  D800(
      {this.dv801,
      this.dv802,
      this.dv803,
      this.dn805,
      this.dv810,
      this.dv811,
      this.fd801,
      this.id});

  D800.fromJson(Map<String, dynamic> json) {
    dv801 = json['dv801'];
    dv802 = json['dv802'];
    dv803 = json['dv803'];
    dn805 = json['dn805'];
    dv810 = json['dv810'];
    dv811 = json['dv811'];
    if (json['fd801'] != null) {
      fd801 = <Fd801>[];
      json['fd801'].forEach((v) {
        fd801!.add(Fd801.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dv801'] = dv801;
    data['dv802'] = dv802;
    data['dv803'] = dv803;
    data['dn805'] = dn805;
    data['dv810'] = dv810;
    data['dv811'] = dv811;
    if (fd801 != null) {
      data['fd801'] = fd801!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Fd801 {
  String? lang;
  String? dv806;
  String? id;

  Fd801({this.lang, this.dv806, this.id});

  Fd801.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    dv806 = json['dv806'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lang'] = lang;
    data['dv806'] = dv806;
    data['id'] = id;
    return data;
  }
}
