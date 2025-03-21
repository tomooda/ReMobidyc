Class {
	#name : 'RMDPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#classVars : [
		'UsesOSWindow'
	],
	#category : 'ReMobidyc-Spec2-Abstract',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Abstract'
}

{ #category : 'testing' }
RMDPresenter class >> isAbstract [

	^ self = RMDPresenter
]

{ #category : 'settings' }
RMDPresenter class >> settingOn: aBuilder [

	<systemsettings>
	(aBuilder group: #remobidycAppearance)
		parent: #remobidyc;
		label: 'Appearance';
		description: 'Settings about GUI (experimental)';
		with: [
			(aBuilder setting: #usesOSWindow)
				label: 'Opens native windows';
				target: self;
				description:
					'Opens a separate OS-native window if checked. Open a simulated window within one OS-native window, otherwise. You are warned that this is experimental feature and there are known issues using this feature.' ]
]

{ #category : 'settings' }
RMDPresenter class >> usesOSWindow [

	^ (UsesOSWindow ifNil: [ UsesOSWindow := false ]) = true
]

{ #category : 'settings' }
RMDPresenter class >> usesOSWindow: aBoolean [

	UsesOSWindow := aBoolean = true
]

{ #category : 'icons' }
RMDPresenter >> acceptIcon [

	^ Smalltalk ui icons iconNamed: #smallOk
]

{ #category : 'icons' }
RMDPresenter >> addIcon [
	^ Smalltalk ui icons iconNamed: #add
]

{ #category : 'private' }
RMDPresenter >> agentNameValidation [

	^ [ :name | 
	  (RMDGrammar current agentIdentifier parse: name) isPetit2Success ]
]

{ #category : 'icons' }
RMDPresenter >> boxChartIcon [

	| form fillColor |
	fillColor := Color blue mixed: 0.5 with: Color cyan.
	form := Form extent: 24 @ 24 depth: 32.
	form getCanvas
		fillColor: Color white;
		line: 5 @ 2
		to: 5 @ 18
		width: 2
		color: Color black;
		frameAndFillRectangle: (2 @ 4 corner: 8 @ 14)
		fillColor: fillColor
		borderWidth: 1
		borderColor: Color black;
		line: 15 @ 6
		to: 15 @ 22
		width: 2
		color: Color black;
		frameAndFillRectangle: (12 @ 10 corner: 18 @ 20)
		fillColor: fillColor
		borderWidth: 1
		borderColor: Color black;
		flush.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> chartIcon [

	^ self lineChartIcon
]

{ #category : 'ui requests' }
RMDPresenter >> confirm: queryString label: titleString [

	^ self application newConfirm
		  title: titleString;
		  label: queryString;
		  openModal
]

{ #category : 'accessing' }
RMDPresenter >> currentWorld [

	self withAdapterDo: [ :a | a widgetDo: [ :w | ^ w currentWorld ] ].
	^ super currentWorld
]

{ #category : 'icons' }
RMDPresenter >> downIcon [
	^ Smalltalk ui icons down
]

{ #category : 'icons' }
RMDPresenter >> dropdownIcon [

	| form |
	form := Form extent: 8 @ 24 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		drawPolygon: { 
				(1 @ 10).
				(7 @ 10).
				(4 @ 14) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color black;
		flush.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> editIcon [
	^ Smalltalk ui icons iconNamed: #edit
]

{ #category : 'icons' }
RMDPresenter >> experimentariumIcon [

	^ Smalltalk ui icons iconNamed: #smallProfile
]

{ #category : 'icons' }
RMDPresenter >> exportIcon [

	^ Smalltalk ui icons iconNamed: #smallExport
]

{ #category : 'icons' }
RMDPresenter >> filterIcon [

	| form fillColor |
	fillColor := Color gray: 0.3.
	form := Form extent: 24 @ 24 depth: 32.
	form getCanvas
		fillColor: Color white;
		drawPolygon: {
				(7 @ 5).
				(16 @ 5).
				(11 @ 15) }
		color: fillColor
		borderWidth: 0
		borderColor: fillColor;
		fillRectangle: (10 @ 11 corner: 13 @ 20) color: fillColor;
		flush.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> greenTriangleIcon [

	| form canvas |
	form := Form extent: 11 @ 11 depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color transparent.
	canvas
		drawPolygon: {
				(2 @ 2).
				(10 @ 5).
				(2 @ 9) }
		color: Color green
		borderWidth: 1
		borderColor: Color darkGray.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> historyIcon [

	^ Smalltalk ui iconNamed: #history
]

{ #category : 'icons' }
RMDPresenter >> icebergIcon [

	^ Smalltalk ui icons iconNamed: #komitterSmalltalkhubRemote
]

{ #category : 'initialization' }
RMDPresenter >> initializePresenters [
	self
		whenBuiltDo: [ :w | 
			| font |
			font := TextStyle defaultFont.
			w widget
				allMorphsDo: [ :m | 
					(m respondsTo: #font:)
						ifTrue: [ m font: font ] ] ]
]

{ #category : 'icons' }
RMDPresenter >> lineChartIcon [

	| form |
	form := Form extent: 24 @ 24 depth: 32.
	form getCanvas
		fillColor: Color white;
		line: 0 @ 0
		to: 0 @ 23
		width: 1
		color: Color black;
		line: 0 @ 23
		to: 23 @ 23
		width: 1
		color: Color black;
		line: 2 @ 20
		to: 10 @ 5
		width: 1.5
		color: Color red;
		line: 10 @ 5
		to: 15 @ 18
		width: 1.5
		color: Color red;
		line: 15 @ 18
		to: 20 @ 3
		width: 1.5
		color: Color red;
		line: 2 @ 10
		to: 10 @ 15
		width: 1.5
		color: Color blue;
		line: 10 @ 15
		to: 15 @ 8
		width: 1.5
		color: Color blue;
		line: 15 @ 8
		to: 20 @ 13
		width: 1.5
		color: Color blue.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> modelerIcon [

	^Smalltalk ui icons iconNamed: #edit
]

{ #category : 'widgets' }
RMDPresenter >> newAnimatInput [
	^ self newValidatedTextInput
		validation: [ :name | 
			(self agentNameValidation value: name)
				and: [ (#('World' 'Patch') includes: name asString) not ] ]
]

{ #category : 'widgets' }
RMDPresenter >> newColorDropList [

	^ self newColorDropList: { 
			  Color black.
			  Color gray.
			  Color blue.
			  Color red.
			  Color green.
			  Color magenta.
			  Color cyan.
			  Color yellow }
]

{ #category : 'widgets' }
RMDPresenter >> newColorDropList: anArrayOfColor [

	^ self newDropList
		  items: anArrayOfColor;
		  display: [ :color | '' ];
		  displayIcon: [ :color | 
			  | form |
			  form := Form extent: 14 @ 14 depth: 32.
			  form getCanvas fillColor: color.
			  form ];
		  yourself
]

{ #category : 'widgets' }
RMDPresenter >> newHighlightingSyntaxNodeTextInput [
	^ self instantiate: RMDHighlightingSyntaxNodeTextInputPresenter
]

{ #category : 'widgets' }
RMDPresenter >> newMetadata [
	^ self instantiate: RMDMetadataPresenter
]

{ #category : 'widgets' }
RMDPresenter >> newNumberInput [
	^ self instantiate: RMDNumberInputPresenter
]

{ #category : 'widgets' }
RMDPresenter >> newSourceWith: aParser [
	^ (self instantiate: RMDSourceTextPresenter)
		parser: aParser;
		yourself
]

{ #category : 'widgets' }
RMDPresenter >> newSyntaxNodeTextInput [
	^ self instantiate: RMDSyntaxNodeTextInputPresenter
]

{ #category : 'widgets' }
RMDPresenter >> newTableWithHorizontalScrollbar [

	^ self instantiate: RMDTableWithHBarPresenter
]

{ #category : 'widgets' }
RMDPresenter >> newValidatedTextInput [
	^ self instantiate: RMDValidatedTextInputPresenter
]

{ #category : 'icons' }
RMDPresenter >> observatoryIcon [

	| form |
	form := Form extent: 16 @ 16 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		drawPolygon: { 
				(4 @ 2).
				(0 @ 8).
				(16 @ 8).
				(12 @ 2) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color black;
		fillOval: (0 @ 6 corner: 8 @ 14)
		color: (Color cyan mixed: 0.5 with: Color white)
		borderWidth: 1
		borderColor: Color darkGray;
		fillOval: (8 @ 6 corner: 16 @ 14)
		color: (Color cyan mixed: 0.5 with: Color white)
		borderWidth: 1
		borderColor: Color darkGray;
		line: 8 @ 4
		to: 8 @ 10
		width: 1
		color: Color lightGray;
		fillOval: (7 @ 4 corner: 9 @ 6)
		color: Color cyan
		borderWidth: 0
		borderColor: Color lightGray;
		flush.
	^ form
]

{ #category : 'showing' }
RMDPresenter >> open [

	^ self class usesOSWindow
		  ifTrue: [ self openInExternalWindow ]
		  ifFalse: [ super open ]
]

{ #category : 'showing' }
RMDPresenter >> openInExternalWindow [

	| morph world |
	morph := self build.
	world := morph openInExternalWindow.
	morph layoutFrame: (0 @ 0 extent: 1 @ 1).
	self initializeWindow: (RMDOSWindowPresenter on: world).
	^ self
]

{ #category : 'icons' }
RMDPresenter >> pullIcon [

	| icebergIcon downIcon icon canvas |
	icebergIcon := Smalltalk ui icons iconNamed:
		               #komitterSmalltalkhubRemote.
	downIcon := Smalltalk ui icons iconNamed: #down.
	icon := Form
		        extent: icebergIcon width + downIcon width - 3
			        @ (icebergIcon height max: downIcon height)
		        depth: 32.
	canvas := icon getCanvas.
	canvas
		fillColor: Color transparent;
		paintImage: icebergIcon
		at: 0 @ (icon height - icebergIcon height // 2);
		translucentImage: downIcon
		at: icebergIcon width - 3 @ (icon height - downIcon height // 2);
		flush.
	^ icon
]

{ #category : 'icons' }
RMDPresenter >> pushIcon [

	| icebergIcon upIcon icon canvas |
	icebergIcon := Smalltalk ui icons iconNamed:
		               #komitterSmalltalkhubRemote.
	upIcon := Smalltalk ui icons iconNamed: #up.
	icon := Form
		        extent: icebergIcon width + upIcon width - 3
			        @ (icebergIcon height max: upIcon height)
		        depth: 32.
	canvas := icon getCanvas.
	canvas
		fillColor: Color transparent;
		paintImage: icebergIcon
		at: 0 @ (icon height - icebergIcon height // 2);
		translucentImage: upIcon
		at: icebergIcon width - 3 @ (icon height - upIcon height // 2);
		flush.
	^ icon
]

{ #category : 'icons' }
RMDPresenter >> redTriangleIcon [

	| form canvas |
	form := Form extent: 11 @ 11 depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color transparent.
	canvas
		drawPolygon: {
				(1 @ 1).
				(10 @ 5).
				(1 @ 10) }
		color: Color red
		borderWidth: 1
		borderColor: Color lightGray.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> removeIcon [
	^ Smalltalk ui icons remove
]

{ #category : 'icons' }
RMDPresenter >> replacementIcon [
	^ Smalltalk ui icons iconNamed: #smallForward
]

{ #category : 'icons' }
RMDPresenter >> repositoryIcon [

	^ Smalltalk ui icons database
]

{ #category : 'icons' }
RMDPresenter >> resetIcon [

	| form |
	form := Form extent: 16 @ 16 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		drawPolygon: { 
				(9 @ 2).
				(4 @ 8).
				(9 @ 14) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color darkGray;
		drawPolygon: { 
				(14 @ 2).
				(9 @ 8).
				(14 @ 14) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color darkGray.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> runIcon [

	| form |
	form := Form extent: 16 @ 16 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		drawPolygon: { 
				(4 @ 2).
				(12 @ 8).
				(4 @ 14) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color darkGray.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> saveIcon [

	^ (Smalltalk ui icons iconNamed: #smallSave) scaledToSize: 24 @ 24
]

{ #category : 'icons' }
RMDPresenter >> saveIconWith: aString [

	| form label font |
	form := Form extent: 24 @ 24 depth: 32.
	font := TextStyle defaultFont.
	label := Form
		         extent: (font widthOfString: aString) @ font height
		         depth: 32.
	label getCanvas
		fillColor: Color white;
		drawString: aString
		at: 0 @ 0
		font: font
		color: Color black.
	label := label scaledToSize: 16 @ 12.
	form getCanvas
		paintImage:
			((Smalltalk ui icons iconNamed: #smallSave) scaledToSize: 24 @ 24)
		at: 0 @ 0;
		translucentImage: label
		at: form width - label width // 2 @ (form height - label height);
		flush.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> spreadIcon [

	^ Smalltalk ui iconNamed: #exception
]

{ #category : 'icons' }
RMDPresenter >> stepIcon [

	| form |
	form := Form extent: 16 @ 16 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillRectangle: (2 @ 3 corner: 5 @ 13) color: Color darkGray;
		drawPolygon: { 
				(7 @ 2).
				(15 @ 8).
				(7 @ 14) }
		color: Color darkGray
		borderWidth: 0
		borderColor: Color darkGray.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> tabularIcon [

	^ Smalltalk ui icons iconNamed: #workspace
]

{ #category : 'icons' }
RMDPresenter >> tagIcon [

	| form fillColor a |
	fillColor := Color white.
	form := Form extent: 24 @ 24 depth: 32.
	a := 8.
	form getCanvas
		drawPolygon: {
				(4 @ 4).
				(4 + a @ 4).
				(23 @ (23 - a)).
				(23 - a @ 23).
				4 @ (a + 4) }
		color: Color white
		borderWidth: 1
		borderColor: Color black;
		flush.
	^ form
]

{ #category : 'icons' }
RMDPresenter >> upIcon [

	^ Smalltalk ui iconNamed: #up
]

{ #category : 'icons' }
RMDPresenter >> updateIcon [

	^ Smalltalk ui icons iconNamed: #smallUpdate
]

{ #category : 'icons' }
RMDPresenter >> validatoriumIcon [

	^ Smalltalk ui iconNamed: #smallInspectIt
]

{ #category : 'icons' }
RMDPresenter >> versionsIcon [
	^ Smalltalk ui icons iconNamed: #smallProfile
]

{ #category : 'icons' }
RMDPresenter >> yellowTriangleIcon [

	| form canvas |
	form := Form extent: 11 @ 11 depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color transparent.
	canvas
		drawPolygon: {
				(1 @ 1).
				(10 @ 5).
				(1 @ 10) }
		color: Color yellow
		borderWidth: 1
		borderColor: Color darkGray.
	^ form
]
