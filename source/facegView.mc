import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;
import Toybox.Time;
import Toybox.Time.Gregorian;

class facegView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        //  softer black
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // Use slightly off-white
        dc.setColor( Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

        // Get screen centering
        var screenWidth = dc.getWidth();
        var centerX = screenWidth / 2;

        // Weather (at the top, centered)
        var weatherY = 30;
        var weather = Weather.getCurrentConditions();
        if (weather != null) {
            var temp = weather.temperature;
            if (temp != null) {
                var tempString = temp.format("%d") + "°";
                dc.drawText(
                    centerX,
                    weatherY,
                    Graphics.FONT_GLANCE,
                    tempString,
                    Graphics.TEXT_JUSTIFY_CENTER
                );
            }
        }

        // Separator Line Below Weather
        // dc.drawLine(centerX - 40, weatherY + 20, centerX + 40, weatherY + 20);

    dc.setColor( Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        // Date (positioned below weather)
        var dateY = weatherY + 55;
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$", [
            today.day_of_week,
            today.day,
            today.month
        ]);
        dc.drawText(
            centerX,
            dateY,
            Graphics.FONT_SYSTEM_SMALL,
            dateString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

  dc.setColor( Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        // Time
        var timeY = dateY + 70;
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [
            clockTime.hour.format("%02d"),
            clockTime.min.format("%02d")
        ]);

        dc.drawText(
            centerX,
            timeY,
            Graphics.FONT_SYSTEM_NUMBER_HOT, // More modern, sleek font
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Separator Line Below Time
        dc.drawLine(centerX - 60, timeY + 140, centerX + 60, timeY + 140);

        //  Battery Icon
        var stats = System.getSystemStats();
        var battery = stats.battery;
        if (battery == null) {
            battery = 50; // Default for simulator testing
        }

        // Battery icon dimensions (small, centered)
        var battWidth = 30;
        var battHeight = 12;
        var battX = centerX - (battWidth / 2);
        var battY = dc.getHeight() - battHeight - 30; // Floating above the edge

        // Draw battery
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(battX, battY, battWidth, battHeight);

        var tipWidth = 3;
        var tipHeight = battHeight / 2;
        dc.fillRectangle(battX + battWidth, battY + (battHeight - tipHeight) / 2, tipWidth, tipHeight);

        // fill width based on battery percentage
        var fillWidth = ((battWidth - 2) * battery) / 100;

        // Battery Fill Color
        if (battery > 50) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        } else if (battery > 20) {
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        }

        // Fill the battery
        dc.fillRectangle(battX + 1, battY + 1, fillWidth, battHeight - 2);
    }

    function onHide() as Void {
    }

    function onExitSleep() as Void {
    }

    function onEnterSleep() as Void {
    }
}
