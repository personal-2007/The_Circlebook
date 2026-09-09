/* =========================================================
   THE CIRCLEBOOK - CIRCLE REQUESTS HANDLER
   ========================================================= */

const CirclebookRequests = {
    accept(userId) {
        CirclebookStore.acceptConnectionRequest(userId);
        CirclebookApp.toast("Circle request accepted!");
        CirclebookRouter.render();
    },

    decline(userId) {
        CirclebookStore.declineConnectionRequest(userId);
        CirclebookApp.toast("Circle request declined.");
        CirclebookRouter.render();
    }
};
