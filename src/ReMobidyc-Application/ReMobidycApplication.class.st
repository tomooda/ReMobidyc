Class {
	#name : 'ReMobidycApplication',
	#superclass : 'ClapApplication',
	#category : 'ReMobidyc-Application',
	#package : 'ReMobidyc-Application'
}

{ #category : 'utilities' }
ReMobidycApplication class >> deploy [

	<script>
	RMDMetadata flushCurrentAuthor.
	RMDRepositoryDirectory flushCurrent.
	GraphicFontSettings setFontsToStyleNamed: #small.
	MCRepositoryGroup allSubInstancesDo: [ :group |
		group repositories do: [ :repo | group removeRepository: repo ] ].
	IceRepository registry removeAll.
	IceCredentialStore current in: [ :store |
		store allCredentials do: [ :each | each removeFrom: store ] ].
	self currentWorld closeAllWindowsDiscardingChanges.
	Deprecation
		raiseWarning: false;
		showWarning: false.
	NoSourcesManager beCurrent.
	"NoPharoFilesOpener install."
	"FFICompilerPlugin install."
	Stdio useNullStreams.
	MCCacheRepository uniqueInstance disable.
	EpMonitor reset.
	BaselineOfReMobidyc initializeResources.
	PasteUpMorph shouldShowWorldMenu: false.
	5 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : 'accessing' }
ReMobidycApplication class >> quit [

	(SpApplication defaultApplication newConfirm
		 title: 'Quit re:mobidyc?';
		 label: 'Quit re:mobidyc?';
		 acceptLabel: 'Quit';
		 cancelLabel: 'Cancel';
		 openModal) = true ifTrue: [
		Smalltalk snapshot: false andQuit: true ]
]

{ #category : 'commandline' }
ReMobidycApplication class >> remobidyc [

	<commandline>
	^ (ClapCommandSpec id: #'re:mobidyc')
		  description: 'IBM Platform for population dynamics';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'activation' }
ReMobidycApplication >> execute [

	self
		installQuit;
		installMenu;
		installIcon.
	BaselineOfReMobidyc ensureStandardRepository.
	RMDLauncher new open
]

{ #category : 'utilities' }
ReMobidycApplication >> installIcon [

	self currentWorld worldState worldRenderer ifNotNil: [ :renderer |
		renderer windowTitle: 're:mobidyc'.
		renderer osWindow icon: (Form fromFileNamed:
				 FileLocator localDirectory / 'ReMobidyc' / 'icons'
				 / 'remobidyc-icon.png') ]
]

{ #category : 'utilities' }
ReMobidycApplication >> installMenu [

	RemobidycMenubarMorph reset.
	OSWindowDriver current startUp: true.
"	OSPlatform current isMacOSX ifTrue: [
		| main |
		main := CocoaMenu new.
		main
			title: 'MainMenu';
			addSubmenu: 're:mobidyc' with: [ :m |
				m
					addItemWithTitle: 'Settings...'
					action: [ BaselineOfReMobidyc showSettingsBrowser ];
					addItemWithTitle: 'About...' action: [ RMDAbout open ];
					addItemWithTitle: 'Quit'
					action: [ Smalltalk snapshot: false andQuit: true ]
					shortcut: 'q' ];
			addSubmenu: 'File' with: [ :m |
			m
				addItemWithTitle: 'Open Launcher'
				action: [ RMDLauncher new open ];
				addItemWithTitle: 'Open Modeler' action: [
					(RMDSimulationModeler on: (RMDSimulationModel new
								  addRenderer: (RMDBackgroundColorRenderer color: Color black);
								  addRenderer: (RMDPatchColorAlphaRenderer
										   color: Color green
										   alpha: '0.5' asRMDExpression
										   between: '0.0' asRMDExpression
										   and: '1.0' asRMDExpression);
								  yourself)) open ] ];
			addSubmenu: 'Help' with: [ :m |
			m
				addItemWithTitle: 'Cheatsheets...'
				action: [ BaselineOfReMobidyc showCheatsheets ]
				shortcut: '';
				addItemWithTitle: 'Tutorial...'
				action: [ BaselineOfReMobidyc showTutorial ] ].
		main setAsMainMenu ]"
]

{ #category : 'utilities' }
ReMobidycApplication >> installQuit [

	Smalltalk at: #WorldState ifPresent: [ :class |
			class class compile:
				'quitSession  ReMobidycApplication quit' ]
]
