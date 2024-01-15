part of 'select_lang_imports.dart';
class SelectLangController {
  GenericBloc<String> langBloc = GenericBloc("en");
  void changeLanguage(BuildContext context, String lang) {
    langBloc.onUpdateData(lang);
    getIt<Utilities>().changeLanguage(lang, context);
  }
}