/* =========================================================
   THE CIRCLEBOOK - PRIVACY CONTROLLER
   ========================================================= */

const CirclebookPrivacy = {
    updateSetting(key, value) {
        CirclebookStore.currentUser.privacy[key] = value;
        CirclebookStore.saveState();
        CirclebookApp.toast(`Privacy setting ${key} updated to ${value}`);
    }
};
