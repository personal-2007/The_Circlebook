/* =========================================================
   THE CIRCLEBOOK - ONBOARDING CONTROLLER
   ========================================================= */

const CirclebookOnboarding = {
    currentStep: 1,

    nextStep() {
        if (this.currentStep < 3) {
            this.currentStep++;
            CirclebookRouter.navigate("entry", `onboarding${this.currentStep}`);
        } else {
            CirclebookApp.toast("Onboarding complete! Welcome to your Circle Feed.");
            CirclebookRouter.navigate("home", "feed");
        }
    },

    previousStep() {
        if (this.currentStep > 1) {
            this.currentStep--;
            CirclebookRouter.navigate("entry", `onboarding${this.currentStep}`);
        }
    }
};
