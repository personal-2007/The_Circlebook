/* =========================================================
   THE CIRCLEBOOK - EVENTS MODULE
   ========================================================= */

const CirclebookEvents = {
    rsvp(eventId) {
        CirclebookStore.toggleEventRSVP(eventId);
        CirclebookRouter.render();
    }
};
