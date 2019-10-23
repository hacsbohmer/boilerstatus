import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0

/*
 * BoilerstatusApp.qml
 *
 * Toon application for boiler parameters display.
 * data is retrieved from the rra databases (used to be happ_thermstat)
 *
 * 20170117: marcelr, first draft
 * 20180118: Toonz, rewritten to use rra database as datasource
 */

App {
    id: boilerStatusApp
    
   
    property url tileUrl : "BoilerstatusTile.qml"
    property url thumbnailIcon: "./drawables/boilerstatus.png"

    /* boiler status parameters */

    property real boilerSetpoint
    property real roomTempSetpoint
    property real boilerPressure
    property real roomTemp
    property real boilerOutTemp
    property real boilerInTemp
    property real boilerModulationLevel : 1
    property string sampleTime
    property bool showPressureInDimState : true
    property string fullDateStr
 
    property string ipToon : "127.0.0.1"  //can put any external Toon ip address as well for testing purposes
   
    function init() {
	registry.registerWidget( "tile", tileUrl, this, null, 
				 { thumbLabel: qsTr("Ketel status"), 
				   thumbIcon: thumbnailIcon, 
				   thumbCategory: "general", 
				   thumbWeight: 30, 
				   baseTileWeight: 10, 
				   thumbIconVAlignment: "center" } );
	}

	Component.onCompleted: {
 		datetimeTimer.start();
		readDefaults();
	}

	function readDefaults() {
		var doc4 = new XMLHttpRequest();
		doc4.onreadystatechange = function() {
			if (doc4.readyState == XMLHttpRequest.DONE) {
				if (doc4.responseText.length > 2) {
					showPressureInDimState = (doc4.responseText == "true");
				}
			}
		}  		
		doc4.open("GET", "file:///HCBv2/qml/apps/boilerstatus/showPressureInDimState.txt", true);
		doc4.send();
	}

	function saveShowPressureInDimState() {

   		var doc2 = new XMLHttpRequest();
		doc2.open("PUT", "file:///HCBv2/qml/apps/boilerstatus/showPressureInDimState.txt");
		doc2.send(showPressureInDimState);
	}

    function getBoilerParameter(loggerName, variableName) {
	
	var xmlhttp = new XMLHttpRequest();
	var infoJson = {};
	var resultValue = 0.1;

	xmlhttp.onreadystatechange = function() {
		if  ( xmlhttp.readyState == 4 ) {
			if  ( xmlhttp.status == 200  ) {

		   		infoJson = JSON.parse( xmlhttp.responseText );
				for (var props in infoJson ) {
					resultValue = parseFloat(infoJson [props]);  //only interested in the last one == most recent
					sampleTime = props;
				}
				switch(variableName) {
					case "boilerSetpoint":
						boilerSetpoint = resultValue;
						break;
					case "roomTempSetpoint":
						roomTempSetpoint = resultValue;
						break;
					case "boilerPressure":
						boilerPressure = resultValue;
						break;
					case "roomTemp":
						roomTemp = resultValue;
						break;
					case "boilerOutTemp":
						boilerOutTemp = resultValue;
						break;
					case "boilerInTemp":
						boilerInTemp = resultValue;
						break;
					default:
						break;
				}
			}
	    	}
	}
	xmlhttp.open( "GET", "http://" + ipToon + "/hcb_rrd?action=getRrdData&loggerName=" + loggerName + "&rra=30days&readableTime=1&nullForNaN=1&from=" + fullDateStr, true );
	xmlhttp.send();
    }

    function getThermostatInfo() {
	
	var xmlhttp = new XMLHttpRequest();
	var infoJson = {};
	var resultValue = 0.1;

	xmlhttp.onreadystatechange = function() {
		if  ( xmlhttp.readyState == 4 ) {
			if  ( xmlhttp.status == 200  ) {
		   		infoJson = JSON.parse( xmlhttp.responseText );
				boilerModulationLevel = parseFloat(infoJson ["currentModulationLevel"]);
				writeBoilerValues();
			}
	    	}
	}
	xmlhttp.open( "GET", "http://" + ipToon + "/happ_thermstat?action=getThermostatInfo", true );
	xmlhttp.send();
    }
      
	function writeBoilerValues() {
		var infoJSson = {};
		infoJSson["sampleTime"] = sampleTime;
		infoJSson["boilerSetpoint"] = boilerSetpoint;
		infoJSson["roomTempSetpoint"] = roomTempSetpoint;
		infoJSson["boilerPressure"] = boilerPressure;
		infoJSson["roomTemp"] = roomTemp;
		infoJSson["boilerOutTemp"] = boilerOutTemp;
		infoJSson["boilerInTemp"] = boilerInTemp;
		infoJSson["boilerModulationLevel"] = boilerModulationLevel;
	 	var doc2 = new XMLHttpRequest();
   		doc2.open("PUT", "file:///var/volatile/tmp/boilervalues.txt");
   		doc2.send(JSON.stringify(infoJSson));
	}


    Timer {
	id: datetimeTimer
	interval: 60000  // update every minute 
	triggeredOnStart: false
	running: false
	repeat: true
	onTriggered: {
		var now = new Date().getTime() - 3000;
		fullDateStr = i18n.dateTime(now, i18n.cent_yes) + " " + i18n.dateTime(now, i18n.time_yes);
		getBoilerParameter("thermstat_realTemps", "roomTemp");
		getBoilerParameter("thermstat_boilerRetTemp", "boilerInTemp");
		getBoilerParameter("thermstat_boilerTemp", "boilerOutTemp");
		getBoilerParameter("thermstat_boilerSetpoint", "boilerSetpoint");
		getBoilerParameter("thermstat_boilerChPressure", "boilerPressure");
		getBoilerParameter("thermstat_setpoint", "roomTempSetpoint");
		getThermostatInfo();
	    }
	}
}
