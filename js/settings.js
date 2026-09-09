/* =========================================================
   THE CIRCLEBOOK - SETTINGS MODULE
   ========================================================= */

const CirclebookSettings = {
    changeTheme(themeName) {
        CirclebookStore.applyTheme(themeName);
        CirclebookApp.toast(`Theme changed to ${themeName}`);
        CirclebookRouter.render();
    }
};
