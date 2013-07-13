// For an introduction to the Blank template, see the following documentation:
// http://go.microsoft.com/fwlink/?LinkId=232509
(function () {
    "use strict";

    WinJS.Binding.optimizeBindingReferences = true;

    var app = WinJS.Application;
    var activation = Windows.ApplicationModel.Activation;

    app.onactivated = function (args) {
        if (args.detail.kind === activation.ActivationKind.launch) {
            if (args.detail.previousExecutionState !== activation.ApplicationExecutionState.terminated) {
                // TODO: This application has been newly launched. Initialize
                // your application here.
                var appData = Windows.Storage.ApplicationData.current;
                var roamingSettings = appData.roamingSettings;
                onLoading();
                if (roamingSettings.values["cash"]) {
                    cashM.add(new BigInt(roamingSettings.values["cash"]));
                }
                if (roamingSettings.values["interest"]) {
                cashM.interest = roamingSettings.values["interest"];
                }
                if (roamingSettings.values["shares"]) {
                    var ar = roamingSettings.values["shares"].split(",");
                    for (var x = 0 ; x < ar.length - 1; x++) {
                        graphs[x].setShares(new BigInt(ar[x]));
                    }
                }
                if (roamingSettings.values["time"] && cashM.interest) {
                    var timeDif=new BigInt(((new Date().getTime() / 1000) - roamingSettings.values["time"]).toString());
                    var inter = new BigInt(cashM.interest.toString());
                    cashM.add(bigint_mul(timeDif, inter));
                }
                gainInterestLevelB.disableCheck();
            } else {
                // TODO: This application has been reactivated from suspension.
                // Restore application state here.
                console.log("hit");
                var appData = Windows.Storage.ApplicationData.current;
                var roamingSettings = appData.roamingSettings;
                onLoading();
                if (roamingSettings.values["cash"]) {
                    cashM.add(new BigInt(roamingSettings.values["cash"]));
                }
                if (roamingSettings.values["interest"]) {
                    cashM.interest = roamingSettings.values["interest"];
                }
                if (roamingSettings.values["shares"]) {
                    var ar = roamingSettings.values["shares"].split(",");
                    for (var x = 0 ; x < ar.length - 1; x++) {
                        graphs[x].setShares(new BigInt(ar[x]));
                    }
                }
                if (roamingSettings.values["time"] && cashM.interest) {
                    var timeDif = new BigInt(((new Date().getTime() / 1000) - roamingSettings.values["time"]).toString());
                    var inter = new BigInt(cashM.interest.toString());
                    cashM.add(bigint_mul(timeDif, inter));
                }
                gainInterestLevelB.disableCheck();
            }
            args.setPromise(WinJS.UI.processAll());
        }
    };

    app.oncheckpoint = function (args) {
        // TODO: This application is about to be suspended. Save any state
        // that needs to persist across suspensions here. You might use the
        // WinJS.Application.sessionState object, which is automatically
        // saved and restored across suspension. If you need to complete an
        // asynchronous operation before your application is suspended, call
        // args.setPromise().
        var appData = Windows.Storage.ApplicationData.current;
        var roamingSettings = appData.roamingSettings;
        roamingSettings.values["cash"] = cashM.value.toString();
        roamingSettings.values["interest"] = cashM.interest;
        roamingSettings.values["shares"] = "";
        for (var x = 0 ; x < graphs.length; x++) {
            roamingSettings.values["shares"] += graphs[x].shares+",";
        }
        roamingSettings.values["time"] = new Date().getTime() / 1000;
    };
    app.onsettings = function (e) {
        e.detail.applicationcommands = {
            "privacyDiv": { title: "Privacy", href: "privacy.html" }
        };
        WinJS.UI.SettingsFlyout.populateSettings(e);
    };
    app.start();
})();
