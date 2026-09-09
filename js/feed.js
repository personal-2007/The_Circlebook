/* =========================================================
   THE CIRCLEBOOK - FEED INTERACTIONS
   ========================================================= */

const CirclebookFeed = {
    filterByCategory(category) {
        CirclebookApp.toast(`Filtering feed by ${category}`);
        CirclebookRouter.render();
    }
};
