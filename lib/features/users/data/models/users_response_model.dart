import 'package:waseelatask/features/users/data/models/user_model.dart';

class UsersResponseModel {
  final List<UserModel> users;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final SupportModel? support;
  final UsersMetaModel? meta;

  UsersResponseModel({
    required this.users,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    this.support,
    this.meta,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      users:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 6,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
      support: json['support'] != null
          ? SupportModel.fromJson(json['support'])
          : null,
      meta: json['_meta'] != null
          ? UsersMetaModel.fromJson(json['_meta'])
          : null,
    );
  }
}

class SupportModel {
  final String url;
  final String text;

  SupportModel({required this.url, required this.text});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(url: json['url'] ?? '', text: json['text'] ?? '');
  }
}

class UsersMetaModel {
  final String poweredBy;
  final String docsUrl;
  final String upgradeUrl;
  final String exampleUrl;
  final String variant;
  final String message;
  final UsersCtaModel? cta;
  final String context;

  UsersMetaModel({
    required this.poweredBy,
    required this.docsUrl,
    required this.upgradeUrl,
    required this.exampleUrl,
    required this.variant,
    required this.message,
    this.cta,
    required this.context,
  });

  factory UsersMetaModel.fromJson(Map<String, dynamic> json) {
    return UsersMetaModel(
      poweredBy: json['powered_by'] ?? '',
      docsUrl: json['docs_url'] ?? '',
      upgradeUrl: json['upgrade_url'] ?? '',
      exampleUrl: json['example_url'] ?? '',
      variant: json['variant'] ?? '',
      message: json['message'] ?? '',
      cta: json['cta'] != null ? UsersCtaModel.fromJson(json['cta']) : null,
      context: json['context'] ?? '',
    );
  }
}

class UsersCtaModel {
  final String label;
  final String url;

  UsersCtaModel({required this.label, required this.url});

  factory UsersCtaModel.fromJson(Map<String, dynamic> json) {
    return UsersCtaModel(label: json['label'] ?? '', url: json['url'] ?? '');
  }
}
