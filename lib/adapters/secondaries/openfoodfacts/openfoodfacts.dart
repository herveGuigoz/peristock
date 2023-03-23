import 'package:flutter/foundation.dart';
import 'package:peristock/adapters/secondaries/http/http.dart';
import 'package:peristock/domain/domain.dart';

abstract class OpenFoodFactsRepository extends HttpClientInterface {
  OpenFoodFactsRepository({
    this.geography = 'fr',
    this.currentAPI = 'food',
  })  : assert(apis.containsKey(currentAPI), 'Unknown API'),
        super(baseURL: '', headers: {'User-Agent': 'Periscope - Android - 1.0'});

  static const Map<String, String> apis = {
    'food': 'https://%s.openfoodfacts.org',
    'beauty': 'https://%s.openbeautyfacts.org',
    'pet': 'https://%s.openpetfoodfacts.org',
    'product': 'https://%s.openproductsfacts.org',
  };

  static const List<String> facets = [
    'additives',
    'allergens',
    'brands',
    'categories',
    'countries',
    'contributors',
    'code',
    'entry_dates',
    'ingredients',
    'label',
    'languages',
    'nutrition_grade',
    'packaging',
    'packaging_codes',
    'purchase_places',
    'photographer',
    'informer',
    'states',
    'stores',
    'traces',
  ];

  final String currentAPI;

  final String geography;

  @protected
  String buildURL({required String service, required String ressource, required Json parameters}) {
    var url = apis[currentAPI]!.replaceAll(RegExp('%s'), geography);

    switch (service) {
      case 'api':
        final barecode = parameters['barcode'];
        url = '$url/api/v3/$ressource/$barecode';
        break;
      case 'data':
        url = '$url/data/$ressource';
        break;
      case 'cgi':
        url = '$url/cgi/$ressource';
        break;
      default:
        throw Exception('Unknown service');
    }

    final query = {...parameters, 'json': 1}.entries.map((e) => '${e.key}=${e.value}').join('&');

    return '$url?$query';
  }
}
