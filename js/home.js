/* =========================================================
   THE CIRCLEBOOK - HOME & FEED MODULE
   ========================================================= */

const CirclebookHome = {
    init() {
        console.log("Home feed controller initialized.");
    },

    refreshFeed() {
        CirclebookApp.toast("Feed updated with latest posts.");
        CirclebookRouter.render();
    }
};
