/* =========================================================
   THE CIRCLEBOOK - SAFETY CONTROLLER
   ========================================================= */

const CirclebookSafety = {
    submitReport(target, reason) {
        CirclebookApp.toast(`Report for ${target} submitted confidential review.`);
    }
};
