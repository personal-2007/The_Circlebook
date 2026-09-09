/* =========================================================
   THE CIRCLEBOOK - CIRCLES MANAGEMENT
   ========================================================= */

const CirclebookCircles = {
    createCustomCircle(name) {
        if (!name) return;
        CirclebookStore.currentUser.customCircles.push({
            id: `circ_${Date.now()}`,
            name: name,
            memberIds: []
        });
        CirclebookStore.saveState();
        CirclebookApp.toast(`Custom Circle "${name}" created.`);
        CirclebookRouter.render();
    }
};
