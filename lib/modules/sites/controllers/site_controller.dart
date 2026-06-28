import '../models/site_model.dart';

class SiteController {
  SiteModel? _selectedSite;

  SiteModel? get selectedSite => _selectedSite;

  void setSite(SiteModel site) {
    _selectedSite = site;
  }
}

final siteController = SiteController();
