// --- General ---
// Open previous windows and tabs
user_pref("browser.startup.page", 3);

// Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// Choose your preferred language for displaying pages
user_pref("intl.accept_languages", "en-us,en,pt-br,pt");

// Use your operating system settings to format dates, times, numbers, and measurements.
user_pref("intl.regional_prefs.use_os_locales", true);

// Always ask you where to save files
user_pref("browser.download.useDownloadDir", false);

// Recommend extensions as you browse
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);

// Recommend features as you browse
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);


// --- Home ---
// Firefox Home Content: Shortcuts
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);


// --- Search ---
// Show search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

// Address Bar: When using the address bar, suggest: Search engines
user_pref("browser.urlbar.suggest.engines", false);


// --- Privacy & Security ---
// Tell websites not to sell or share my data
user_pref("privacy.globalprivacycontrol.enabled", true);

// Send websites a “Do Not Track” request
user_pref("privacy.donottrackheader.enabled", true);

// Ask to save passwords
user_pref("signon.rememberSignons", false);

// Show alerts about passwords for breached websites
user_pref("signon.management.page.breach-alerts.enabled", false);

// Allow Firefox to send technical and interaction data to Mozilla
user_pref("datareporting.healthreport.uploadEnabled", false);

// Allow Firefox to install and run studies
user_pref("app.shield.optoutstudies.enabled", false);

// Enable HTTPS-Only Mode in all windows
user_pref("dom.security.https_only_mode", true);

// Enable DNS over HTTPS using: Max Protection
user_pref("network.trr.mode", 3);


// --- Sync ---
// Passwords
user_pref("services.sync.engine.passwords", false);
// Addresses
user_pref("services.sync.engine.addresses", false);
// Payment methods
user_pref("services.sync.engine.creditcards", false);
// Add-ons
user_pref("services.sync.engine.addons", false);
// Settings
user_pref("services.sync.engine.prefs", false);


// --- Inspector ---
// Dock to Right
user_pref("devtools.toolbox.host", "right");
