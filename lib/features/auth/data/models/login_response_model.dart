import 'package:waseelatask/features/auth/domain/entities/login_entity.dart';

class LoginResponseModel {
  final String token;
  final MetaModel? meta;

  LoginResponseModel({required this.token, this.meta});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      meta: json['_meta'] != null ? MetaModel.fromJson(json['_meta']) : null,
    );
  }

  LoginEntity toEntity() {
    return LoginEntity(token: token, meta: meta?.toEntity());
  }
}

class MetaModel {
  final String poweredBy;
  final String docsUrl;
  final String upgradeUrl;
  final String exampleUrl;
  final String variant;
  final String message;
  final CtaModel? cta;
  final String context;

  MetaModel({
    required this.poweredBy,
    required this.docsUrl,
    required this.upgradeUrl,
    required this.exampleUrl,
    required this.variant,
    required this.message,
    this.cta,
    required this.context,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      poweredBy: json['powered_by'] ?? '',
      docsUrl: json['docs_url'] ?? '',
      upgradeUrl: json['upgrade_url'] ?? '',
      exampleUrl: json['example_url'] ?? '',
      variant: json['variant'] ?? '',
      message: json['message'] ?? '',
      cta: json['cta'] != null ? CtaModel.fromJson(json['cta']) : null,
      context: json['context'] ?? '',
    );
  }

  MetaEntity toEntity() {
    return MetaEntity(
      poweredBy: poweredBy,
      docsUrl: docsUrl,
      upgradeUrl: upgradeUrl,
      exampleUrl: exampleUrl,
      variant: variant,
      message: message,
      cta: cta?.toEntity(),
      context: context,
    );
  }
}

class CtaModel {
  final String label;
  final String url;

  CtaModel({required this.label, required this.url});

  factory CtaModel.fromJson(Map<String, dynamic> json) {
    return CtaModel(label: json['label'] ?? '', url: json['url'] ?? '');
  }

  CtaEntity toEntity() {
    return CtaEntity(label: label, url: url);
  }
}
