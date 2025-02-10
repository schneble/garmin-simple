import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class facegApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // application start up
    function onStart(state as Dictionary?) as Void {
    }

    // application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new facegView() ];
    }

}

function getApp() as facegApp {
    return Application.getApp() as facegApp;
}
