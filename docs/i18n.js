// i18n.js — Minimal internationalization for Nepal Administrative Data
// Supports: English (en), Nepali (ne), Maithili (mai), Bhojpuri (bho)
const I18N = {
  current: localStorage.getItem('lang') || 'en',
  strings: {
    en: {
      home: 'Home', apiDocs: 'API Docs', explorer: 'Data Explorer', brand: 'Brand',
      pubDev: 'pub.dev', github: 'GitHub', search: 'Search by name, district, or province...',
      provinces: 'Provinces', districts: 'Districts', localBodies: 'Local Bodies', wards: 'Wards',
      viewOnPubDev: 'View on pub.dev', readApiDocs: 'Read API Docs', exploreData: 'Explore Data',
      elevation: 'Elevation', maintainedBy: 'Maintained by', license: 'License',
    },
    ne: {
      home: 'गृह', apiDocs: 'API दस्तावेज', explorer: 'डाटा एक्सप्लोरर', brand: 'ब्रान्ड',
      pubDev: 'pub.dev', github: 'GitHub', search: 'नाम, जिल्ला वा प्रदेशबाट खोज्नुहोस्...',
      provinces: 'प्रदेश', districts: 'जिल्ला', localBodies: 'स्थानीय तह', wards: 'वडा',
      viewOnPubDev: 'pub.dev मा हेर्नुहोस्', readApiDocs: 'API दस्तावेज पढ्नुहोस्', exploreData: 'डाटा एक्सप्लोर गर्नुहोस्',
      elevation: 'उचाइ', maintainedBy: 'सञ्चालन', license: 'इजाजतपत्र',
    },
    mai: {
      home: 'होम', apiDocs: 'API दस्तावेज', explorer: 'डाटा एक्सप्लोरर', brand: 'ब्रान्ड',
      pubDev: 'pub.dev', github: 'GitHub', search: 'नाम, जिल्ला वा प्रदेश सँ खोजू...',
      provinces: 'प्रदेश', districts: 'जिल्ला', localBodies: 'स्थानीय तह', wards: 'वडा',
      viewOnPubDev: 'pub.dev मे देखू', readApiDocs: 'API दस्तावेज पढ़ू', exploreData: 'डाटा एक्सप्लोर करू',
      elevation: 'उचाइ', maintainedBy: 'सञ्चालन', license: 'इजाजतपत्र',
    },
    bho: {
      home: 'होम', apiDocs: 'API दस्तावेज', explorer: 'डाटा एक्सप्लोरर', brand: 'ब्रान्ड',
      pubDev: 'pub.dev', github: 'GitHub', search: 'नाम, जिल्ला वा प्रदेश से खोजू...',
      provinces: 'प्रदेश', districts: 'जिल्ला', localBodies: 'स्थानीय तह', wards: 'वडा',
      viewOnPubDev: 'pub.dev मे देखू', readApiDocs: 'API दस्तावेज पढ़ू', exploreData: 'डाटा एक्सप्लोर करू',
      elevation: 'उचाइ', maintainedBy: 'सञ्चालन', license: 'इजाजतपत्र',
    },
  },
  t(key) {
    return (this.strings[this.current] || this.strings.en)[key] || key;
  },
  setLang(lang) {
    this.current = lang;
    localStorage.setItem('lang', lang);
    document.documentElement.lang = lang === 'ne' ? 'ne' : 'en';
    // Dispatch event for components to re-render
    window.dispatchEvent(new CustomEvent('langchange', { detail: lang }));
  },
  init() {
    // Auto-detect from browser
    if (!localStorage.getItem('lang')) {
      const browserLang = navigator.language.split('-')[0];
      if (['ne', 'mai', 'bho'].includes(browserLang)) this.current = browserLang;
    }
  },
};

// Auto-init
I18N.init();
window.I18N = I18N;
