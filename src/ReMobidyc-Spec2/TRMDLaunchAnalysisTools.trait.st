Trait {
	#name : 'TRMDLaunchAnalysisTools',
	#instVars : [
		'openTabularButton',
		'openObservatoryButton'
	],
	#category : 'ReMobidyc-Spec2-Traits',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Traits'
}

{ #category : 'menus' }
TRMDLaunchAnalysisTools >> analysisMenu [

	| menu |
	menu := self newMenu.
	self tabularMenu: menu.
	self replayObservatoryMenu: menu.
	^ menu
]

{ #category : 'testing' }
TRMDLaunchAnalysisTools >> canOpenAnalysis [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
TRMDLaunchAnalysisTools >> initializeOpenAnalysisButtonsPresenters [

	openTabularButton := self newButton
		                     disable;
		                     icon: self tabularIcon;
		                     help: 'Open the run data in a Tabular.';
		                     action: [ self openTabularMenu ];
		                     yourself.
	openObservatoryButton := self newButton
		                         disable;
		                         icon: self observatoryIcon;
		                         help:
			                         'Visualize the run data in an Observatory.';
		                         action: [ self openInReplayObservatory ];
		                         yourself
]

{ #category : 'private' }
TRMDLaunchAnalysisTools >> metaInterpreterForTabularDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openInAttributeTabular [

	^ (self metaInterpreterForTabularDo: #openInAttributeTabular)
		  selectRunId: self selectedRunId;
		  yourself
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openInIndividualHistoryTabularWithRunId: runId individual: individual time: time [

	self metaInterpreterForTabularDo: [ :metaInterpreter |
		^ (RMDIndividualHistoryTabular
			   on: metaInterpreter
			   runId: runId
			   individual: individual
			   time: time)
			  open;
			  yourself ].
	^ nil
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openInPopulationTabular [

	^ (self metaInterpreterForTabularDo: #openInPopulationTabular)
		  selectTime: self selectedTime;
		  selectRunId: self selectedRunId;
		  yourself
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openInReplayObservatory [

	^ (self metaInterpreterForTabularDo: #openInReplayObservatory)
		  selectTime: self selectedTime;
		  selectRunId: self selectedRunId;
		  yourself
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openInSnapshotTabular [

	^ (self metaInterpreterForTabularDo: #openInSnapshotTabular)
		  selectTime: self selectedTime;
		  selectRunId: self selectedRunId;
		  yourself
]

{ #category : 'operations' }
TRMDLaunchAnalysisTools >> openTabularMenu [

	self tabularMenu openWithSpecAtPointer
]

{ #category : 'menus' }
TRMDLaunchAnalysisTools >> replayObservatoryMenu [

	^ self replayObservatoryMenu: self newMenu
]

{ #category : 'menus' }
TRMDLaunchAnalysisTools >> replayObservatoryMenu: aSpMenuPresenter [

	^ aSpMenuPresenter
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Open in Observatory';
						  action: [ self openInReplayObservatory ] ] ];
		  yourself
]

{ #category : 'accessing' }
TRMDLaunchAnalysisTools >> selectedIndividual [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
TRMDLaunchAnalysisTools >> selectedRunId [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
TRMDLaunchAnalysisTools >> selectedTime [

	^ self subclassResponsibility
]

{ #category : 'menus' }
TRMDLaunchAnalysisTools >> tabularMenu [

	^ self tabularMenu: self newMenu
]

{ #category : 'menus' }
TRMDLaunchAnalysisTools >> tabularMenu: aSpMenuPresenter [

	^ aSpMenuPresenter
		  addGroup: [ :group |
			  | runId time individual |
			  runId := self selectedRunId.
			  time := self selectedTime.
			  individual := self selectedIndividual.
			  group
				  addItem: [ :item |
					  item
						  name: 'Open in Population Tabular';
						  action: [ self openInPopulationTabular ] ];
				  addItem: [ :item |
					  item
						  name: 'Open in Snapshot Tabular';
						  action: [ self openInSnapshotTabular ] ];
				  addItem: [ :item |
					  item
						  name: 'Open in Attribute Tabular';
						  action: [ self openInAttributeTabular ] ].
			  (runId notNil and: [ time notNil and: [ individual notNil ] ])
				  ifTrue: [
					  group addItem: [ :item |
						  item
							  name: 'Open in Individual History Tabular';
							  action: [
								  self
									  openInIndividualHistoryTabularWithRunId: runId
									  individual: individual
									  time: time ] ] ] ];
		  yourself
]

{ #category : 'updating' }
TRMDLaunchAnalysisTools >> updateOpenAnalysisButtons [

	self canOpenAnalysis
		ifTrue: [ 
			openTabularButton enable.
			openObservatoryButton enable.
			^ self ]
		ifFalse: [ 
			openTabularButton disable.
			openObservatoryButton disable ]
]
