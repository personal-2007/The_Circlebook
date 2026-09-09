/* =========================================================
   THE CIRCLEBOOK - PROFILE MODULE
   ========================================================= */

const CirclebookProfile = {
    updateBio(newBio) {
        CirclebookStore.currentUser.about = newBio;
        CirclebookStore.saveState();
        CirclebookApp.toast("Profile bio updated.");
        CirclebookRouter.render();
    },

    addSkill(skillName) {
        if (skillName && !CirclebookStore.currentUser.skills.includes(skillName)) {
            CirclebookStore.currentUser.skills.push(skillName);
            CirclebookStore.saveState();
            CirclebookApp.toast(`Skill "${skillName}" added.`);
            CirclebookRouter.render();
        }
    }
};
