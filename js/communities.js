/* =========================================================
   THE CIRCLEBOOK - COMMUNITIES MODULE
   ========================================================= */

const CirclebookCommunities = {
    join(communityId) {
        CirclebookStore.toggleCommunityJoin(communityId);
        CirclebookRouter.render();
    }
};
