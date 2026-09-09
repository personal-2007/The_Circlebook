/* =========================================================
   THE CIRCLEBOOK - ADMIN CONTROLLER
   ========================================================= */

const CirclebookAdmin = {
    resolveReport(reportId) {
        CirclebookStore.adminData.pendingReports = CirclebookStore.adminData.pendingReports.filter(r => r.id !== reportId);
        CirclebookApp.toast("Report resolved.");
        CirclebookRouter.render();
    }
};
