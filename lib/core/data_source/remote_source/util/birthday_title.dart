Map<String, List<String>> birthdayTranslations = {
  'ru': ['День рождения', 'днюха'],            // Russian
  'en': ['Birthday', 'birth', 'b-day'],              // English
  'es': ['Cumpleaños', 'cumple'],                    // Spanish
  'fr': ['Anniversaire', 'anniv'],                   // French
  'de': ['Geburtstag', 'geb', 'b-day'],              // German
  'zh': ['生日', '生日快樂'],                         // Chinese
  'ja': ['誕生日', 'たんじょうび'],                     // Japanese
  'hi': ['जन्मदिन', 'जन्म'],                          // Hindi
  'ar': ['عيد ميلاد', 'ميلاد'],                       // Arabic
  'it': ['Compleanno', 'comple'],                    // Italian
  'ko': ['생일', '생'],                               // Korean
  'pt': ['Aniversário', 'niver'],                    // Portuguese
  'tr': ['Doğum günü', 'doğum'],                     // Turkish
  'nl': ['Verjaardag', 'verjaard'],                  // Dutch
  'sv': ['Födelsedag', 'födels'],                    // Swedish
  'pl': ['Urodziny', 'uro'],                         // Polish
  'cs': ['Narozeniny', 'narozky'],                   // Czech
  'fi': ['Syntymäpäivä', 'synttärit'],               // Finnish
  'he': ['יום הולדת', 'יום הול'],                     // Hebrew
  'uk': ['День народження'],          // Ukrainian
};

Set<String> birthdaysTitles = birthdayTranslations.values
    .expand((element) => element)
    .map((e) => e.toLowerCase())
    .toSet();