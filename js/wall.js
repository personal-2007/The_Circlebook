/* =========================================================
   THE CIRCLEBOOK - PROFILE WALL CONTROLLER
   ========================================================= */

const CirclebookWall = {
    postToWall(text) {
        if (!text) return;
        CirclebookStore.addPost(text, "General");
        CirclebookApp.toast("Posted to wall!");
        CirclebookRouter.render();
    }
};
