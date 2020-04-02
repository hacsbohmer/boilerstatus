import QtQuick 2.1
import qb.components 1.0

/*
 * Tile for showing boiler parameters like boiler setpoint, pressure etc. on 
 * screen. Requires BoilerstatusApp.qml for data presentation.
 * 
 * (People at the Eneco forum have been asking for this for ages, it's here
 * just to nag the living daylights out of them ;-) ).
 *
 * 20170117: marcelr, first draft
 * 20180923: Tonz, Toon2 compatibility
 *
 */

Tile {
    id: boilerStatusTile
    
    property bool dimState: screenStateController.dimmedColors
	
	onClicked: {
		app.showPressureInDimState = !app.showPressureInDimState;
		app.saveShowPressureInDimState();
		if (app.showPressureInDimState) {
			qdialog.showDialog(qdialog.SizeSmall, "Ketel status", "De tegel toont nu de waterdruk in de dim stand.\nDruk opnieuw op de tegel om te switchen naar het brander modulatie niveau in de dim stand." , "Sluiten");
		} else {
			qdialog.showDialog(qdialog.SizeSmall, "Ketel status", "De tegel toont nu het brander modulatie niveau in de dim stand.\nDruk opnieuw op de tegel om te switchen naar de waterdruk in de dim stand." , "Sluiten");
		}
	}

	Text {  // r1 c1
	    id: boilerStatusTileRoomTempSetpoint
	    
	    text: i18n.number( Number( app.roomTempSetpoint ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 42 : 34
		right: parent.right
		rightMargin: isNxt ? 186 : 145
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	Text { // r1 c2
	    id: boilerStatusTileRoomTemp
	    
	    text: i18n.number( Number( app.roomTemp ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 42 : 34
		right: parent.right
		rightMargin: isNxt ? 38 : 30
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	} 
	
	Text { // r2 c1
	    id: boilerStatusTileBoilerSetpoint
	    
	    text: i18n.number( Number( app.boilerSetpoint ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 86 : 69
		right: parent.right
		rightMargin: isNxt ? 186 : 145
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	Text { // r2 c2
	    id: boilerStatusTileBoilerOutTemp
	    
	    text: i18n.number( Number( app.boilerOutTemp ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 86 : 69
		right: parent.right
		rightMargin: isNxt ? 38 : 30
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}

	Text { // r3 c2
	    id: boilerStatusTileBoilerInTemp
	    
	    text: i18n.number( Number( app.boilerInTemp ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 130 : 104
		right: parent.right
		rightMargin: isNxt ? 38 : 30
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	

	Text { // r5 c2
	    id: boilerStatusTileBoilerPressure
	    
	    text: i18n.number( Number( app.boilerPressure ), 1 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 130 : 104
		right: parent.right
		rightMargin: isNxt ? 186 : 145
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	
	Text { // r5 c1
	    id: boilerStatusTileRelModLevel
	    
	    text: i18n.number( Number( app.boilerModulationLevel ), 0 )
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 180 : 139
		right: parent.right
		rightMargin: isNxt ? 186 : 146
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 28 : 22
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}

	/*
	 * UNITS
	 */
	
	Text {
	    id: boilerStatusTileRoomTempSetpointUnit
	    
	    text: "°C"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 42 : 34
		left: parent.left
		leftMargin: isNxt ? 109 : 87
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	
	Text {
	    id: boilerStatusTileRoomTempUnit
	    
	    text: "°C"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 42 : 34
		left: parent.left
		leftMargin: isNxt ? 255 : 204
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	
	Text {
	    id: boilerStatusTileBoilerSetpointUnit
	    
	    text: "°C"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 86 : 69
		left: parent.left
		leftMargin: isNxt ? 109 : 87
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	
	Text {
	    id: boilerStatusTileBoilerOutTempUnit
	    
	    text: "°C"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 86 : 69
		left: parent.left
		leftMargin: isNxt ? 255 : 204
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    visible: !dimState
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	}
	

	Text {
	    id: boilerStatusTileBoilerInTempUnit
	    
	    text: "°C"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 130 : 104
		left: parent.left
		leftMargin: isNxt ? 255 : 204
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
   }


	Text {
	    id: boilerStatusTileBoilerPressureUnit
	    
	    text: "bar"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 130 : 104
		left: parent.left
		leftMargin: isNxt ? 109 : 87
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
	
	Text {
	    id: boilerStatusTileRelModLevelUnit
	    
	    text: "%"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 174 : 139
		left: parent.left
		leftMargin: isNxt ? 109 : 87
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 23 : 18
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: !dimState
	}
		
/* ICONS */

	Image {
	    id: boilerStatusTileRoomTempSetpointIcon
	    source: "qrc:/tsc/RoomTempSetpointIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 19 : 15
		left: parent.left
		leftMargin: isNxt ? 5 : 4
	    }
	    cache: false
	    visible: !dimState
	}
	
	Image {
	    id: boilerStatusTileRoomTempIcon
	    source: "qrc:/tsc/RoomTempIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 19 : 15
		left: parent.left
		leftMargin: isNxt ? 148 : 118
	    }
	    cache: false
	    visible: !dimState
	}
	
	Image {
	    id: boilerStatusTileBoilerTempOutSetpointIcon
	    source: "qrc:/tsc/BoilerOutTempSetpointIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 63 : 50
		left: parent.left
		leftMargin: isNxt ? 5 : 4
	    }
	    cache: false
	    visible: !dimState
	}
	
	Image {
	    id: boilerStatusTileBoilerTempOutIcon
	    source: "qrc:/tsc/BoilerTempOutIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 63 : 50
		left: parent.left
		leftMargin: isNxt ? 148 : 118
	    }
	    cache: false
	    visible: !dimState
	}
	
	Image {
	    id: boilerStatusTileBoilerTempInIcon
	    source: "qrc:/tsc/BoilerTempInIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 106 : 85
		left: parent.left
		leftMargin: isNxt ? 148 : 118
	    }
	    cache: false
	    visible: !dimState
	}

	Image {
	    id: boilerStatusTileBoilerPressureIcon
	    source: "qrc:/tsc/BoilerPressureIcon.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 106 : 85
		left: parent.left
		leftMargin: isNxt ? 5 : 4
	    }
	    cache: false
	    visible: !dimState
	}
	
	Image {
	    id: boilerStatusTileModulationLevelIcon
	    source: "qrc:/tsc/flameSmall.png"
	    anchors {
		baseline: parent.top
		baselineOffset: isNxt ? 150 : 120
		left: parent.left
		leftMargin: isNxt ? 19 : 15
	    }
	    cache: false
	    visible: !dimState
	}

	Text {
		id: boilerStatusTileDimstateText
		text: i18n.number( Number( app.boilerPressure ), 1 )
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 125 : 100
			left: parent.left
			leftMargin: isNxt ? 40 : 32
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.clockFaceText
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
      		visible: app.showPressureInDimState && dimState
	}

	Text {
		id: boilerStatusTileDimstateTextUnit
		text: " bar"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 125 : 100
			left: boilerStatusTileDimstateText.right
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 50 : 40
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
      		visible: app.showPressureInDimState && dimState
	}

	Text {
		id: boilerStatusTileDimstateText2
		text: i18n.number( Number( app.boilerModulationLevel ), 0 )
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 125 : 100
			left: parent.left
			leftMargin: isNxt ? 40 : 32
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.clockFaceText
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
      		visible: (!app.showPressureInDimState) && dimState
	}

	Text {
		id: boilerStatusTileDimstateTextUnit2
		text: "   %"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 125 : 100
			left: boilerStatusTileDimstateText.right
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 50 : 40
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
      		visible: (!app.showPressureInDimState) && dimState
	}


	Text {
	    id: boilerStatusTileBoilerInTemplabelDim
	    
	    text: "In:"
	    anchors {
		baseline: parent.bottom
		left: parent.left
		leftMargin: isNxt ? 13 : 10
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    visible: dimState
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	}

	Text { 
	    id: boilerStatusTileBoilerInTempDim
	    
	    text: i18n.number( Number( app.boilerInTemp ), 1 )
	    anchors {
		baseline: parent.bottom
		left: boilerStatusTileBoilerInTemplabelDim.right
		leftMargin: isNxt ? 6 : 5
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: dimState
	}

	Text {
	    id: boilerStatusTileBoilerInTempUnitDim
	    
	    text: "°C"
	    anchors {
		baseline: parent.bottom
		left: boilerStatusTileBoilerInTempDim.right
		leftMargin: isNxt ? 6 : 5
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    visible: dimState
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	}

	Text {
	    id: boilerStatusTileBoilerOutTempUnitDim
	    
	    text: "°C"
	    anchors {
		baseline: parent.bottom
		right: parent.right
		rightMargin: isNxt ? 13 : 10
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    visible: dimState
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	}

	Text { 
	    id: boilerStatusTileBoilerOutTempDim
	    
	    text: i18n.number( Number( app.boilerOutTemp ), 1 )
	    anchors {
		baseline: parent.bottom
		right: boilerStatusTileBoilerOutTempUnitDim.left
		rightMargin: isNxt ? 6 : 5
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	    visible: dimState
	}

	Text {
	    id: boilerStatusTileBoilerOutTemplabelDim
	    
	    text: "Uit:"
	    anchors {
		baseline: parent.bottom
		right: boilerStatusTileBoilerOutTempDim.left
		rightMargin: isNxt ? 6 : 5
	    }
	    font {
		family: qfont.regular.name
		pixelSize: isNxt ? 19 : 15
	    }
	    visible: dimState
	    color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	}
	

}
