/* =========================================================
   THE CIRCLEBOOK - CAREER HUB MODULE
   ========================================================= */

const CirclebookCareer = {
    apply(jobId) {
        CirclebookStore.applyForJob(jobId);
        CirclebookApp.toast("Application submitted successfully!");
        CirclebookRouter.render();
    }
};
