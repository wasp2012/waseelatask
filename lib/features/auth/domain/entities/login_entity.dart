class LoginEntity {
  final String token;
  final MetaEntity? meta;

  LoginEntity({required this.token, this.meta});
}

class MetaEntity {
  final String poweredBy;
  final String docsUrl;
  final String upgradeUrl;
  final String exampleUrl;
  final String variant;
  final String message;
  final CtaEntity? cta;
  final String context;

  MetaEntity({
    required this.poweredBy,
    required this.docsUrl,
    required this.upgradeUrl,
    required this.exampleUrl,
    required this.variant,
    required this.message,
    this.cta,
    required this.context,
  });
}

class CtaEntity {
  final String label;
  final String url;

  CtaEntity({required this.label, required this.url});
}
