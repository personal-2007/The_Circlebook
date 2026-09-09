/* =========================================================
   THE CIRCLEBOOK - GLOBAL CONFIGURATION
   ========================================================= */

window.CirclebookConfig = {
    appName: "The Circlebook",
    version: "2.5.0",
    apiBaseUrl: "http://localhost:8080/api/v1",
    aiModel: "CircleAI-v2.5-General",
    themeDefaults: {
        theme: "vintage-gold",
        fontSize: "medium",
        compactMode: false
    },
    featureFlags: {
        enableCircleAI: true,
        enableRealtimeChat: true,
        enableJobBoard: true,
        enableAdminSuite: true
    }
};
