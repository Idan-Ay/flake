var panel = new Panel
var panelScreen = panel.screen

panel.location = "bottom";
panel.height = 48
panel.alignment = "center";

geo = screenGeometry(panelScreen);

panel.minimumLength = geo.width * 9 / 16
panel.maximumLength = geo.width * 9 / 16


panel.addWidget("org.kde.plasma.pager")
panel.addWidget("org.kde.plasma.marginsseparator")

let taskBar = panel.addWidget("org.kde.plasma.icontasks")
taskBar.currentConfigGroup = ["General"]
taskBar.writeConfig("launchers",["preferred://browser","preferred://filemanager","applications:org.kde.konsole.desktop"])

let dQuick = panel.addWidget("org.kde.plasma.quicklaunch")
dQuick.currentConfigGroup = ["General"]
dQuick.writeConfig("launcherUrls", "file:///usr/share/applications/systemsettings.desktop")

panel.addWidget("org.kde.plasma.trash")




var panelTop = new Panel
panelTop.height = 32;
panelTop.location = "top";
panelTop.alignment = "center";
panelTop.minimumLength = geo.width
panelTop.maximumLength = geo.width

var kickoff = panelTop.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["Shortcuts"]
kickoff.writeConfig("global", "Alt+F1")
kickoff.currentConfigGroup = ["General"]
kickoff.writeConfig("favorites", ["preferred://browser", "org.kde.dolphin.desktop", "org.kde.konsole.desktop", "systemsettings.desktop"])

panelTop.addWidget("org.kde.plasma.showdesktop")
panelTop.addWidget("org.kde.plasma.appmenu");
panelTop.addWidget("org.kde.plasma.panelspacer");

var langIds = ["as",    // Assamese
               "bn",    // Bengali
               "bo",    // Tibetan
               "brx",   // Bodo
               "doi",   // Dogri
               "gu",    // Gujarati
               "hi",    // Hindi
               "ja",    // Japanese
               "kn",    // Kannada
               "ko",    // Korean
               "kok",   // Konkani
               "ks",    // Kashmiri
               "lep",   // Lepcha
               "mai",   // Maithili
               "ml",    // Malayalam
               "mni",   // Manipuri
               "mr",    // Marathi
               "ne",    // Nepali
               "or",    // Odia
               "pa",    // Punjabi
               "sa",    // Sanskrit
               "sat",   // Santali
               "sd",    // Sindhi
               "si",    // Sinhala
               "ta",    // Tamil
               "te",    // Telugu
               "th",    // Thai
               "ur",    // Urdu
               "vi",    // Vietnamese
               "zh_CN", // Simplified Chinese
               "zh_TW"] // Traditional Chinese

if (langIds.indexOf(languageId) != -1) {
    panelTop.addWidget("org.kde.plasma.kimpanel");
}

panelTop.addWidget("org.kde.plasma.systemtray");

var dClock = panelTop.addWidget("org.kde.plasma.digitalclock");
dClock.writeConfig("showDate", false);

var dLogout = panelTop.addWidget("org.kde.plasma.lock_logout");
dLogout.writeConfig("show_lockScreen", false);
