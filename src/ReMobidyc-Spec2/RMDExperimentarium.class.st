Class {
	#name : 'RMDExperimentarium',
	#superclass : 'RMDPresenter',
	#traits : 'TRMDLaunchAnalysisTools',
	#classTraits : 'TRMDLaunchAnalysisTools classTrait',
	#instVars : [
		'stepButton',
		'runButton',
		'saveRunAsButton',
		'removeRunButton',
		'timeProgressBar',
		'limitsNumberOfIndividualsCheckBox',
		'numberOfIndividualField',
		'interpreterDropList',
		'timeLabel',
		'populationTable',
		'currentPopulation',
		'maxPopulation',
		'minPopulation',
		'populationByTime',
		'validated',
		'lastServerUpdate',
		'lastDisplayUpdate',
		'metaInterpreter',
		'visualizationImage',
		'showPopulationChartRadioButton',
		'showVisualMapRadioButton',
		'saved',
		'usesFireButton',
		'fireIcon'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'instance creation' }
RMDExperimentarium class >> metaInterpreter: aRMDInterpreter [

	aRMDInterpreter recordInChronicle.
	^ self new
		  setMetaInterpreter: aRMDInterpreter;
		  yourself
]

{ #category : 'updating' }
RMDExperimentarium >> basicInformServer [

	lastServerUpdate := DateAndTime now.
	Smalltalk at: #RMDClient ifPresent: [ :clientClass | 
		clientClass
			informModel: self modelName
			progress: metaInterpreter progress
			from: self ]
]

{ #category : 'updating' }
RMDExperimentarium >> basicUpdateTimeProgressBar [

	metaInterpreter ifNotNil: [ 
		timeProgressBar fixedAt: metaInterpreter progress ]
]

{ #category : 'testing' }
RMDExperimentarium >> canOpenAnalysis [

	^ metaInterpreter notNil and: [ 
		  metaInterpreter context isForFileMemory ]
]

{ #category : 'testing' }
RMDExperimentarium >> canProceed: aRMDInterpreter [

	^ limitsNumberOfIndividualsCheckBox state not or: [ 
		  aRMDInterpreter numberOfIndividuals
		  <= numberOfIndividualField number ]
]

{ #category : 'layout' }
RMDExperimentarium >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: stepButton expand: false;
				   add: runButton expand: false;
				   add: timeProgressBar expand: true;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: limitsNumberOfIndividualsCheckBox expand: false;
				   add: numberOfIndividualField width: 100;
				   add: (SpBoxLayout newHorizontal
						    hAlignEnd;
						    add: usesFireButton expand: false)
				   expand: true;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newVertical
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.3;
						    add: interpreterDropList;
						    add: timeLabel)
				   expand: false;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.45;
						    add: populationTable;
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      add: (SpBoxLayout newVertical add: showPopulationChartRadioButton expand: false) expand: false;
										      add: (SpBoxLayout newVertical add: showVisualMapRadioButton expand: false) expand: false;
										      yourself)
								     expand: false;
								     add: visualizationImage;
								     yourself);
						    yourself);
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: openTabularButton expand: false;
				   add: openObservatoryButton expand: false;
				   add: '    ' expand: false;
				   add: saveRunAsButton expand: false;
				   add: removeRunButton expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'icons' }
RMDExperimentarium >> fireIcon [

	^ fireIcon ifNil: [
			  fireIcon := Form fromBinaryStream:
				              #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 24 0 0 0 24 8 6 0 0 0 224 119 61 248 0 0 0 1 115 82 71 66 1 217 201 44 127 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 32 99 72 82 77 0 0 122 38 0 0 128 132 0 0 250 0 0 0 128 232 0 0 117 48 0 0 234 96 0 0 58 152 0 0 23 112 156 186 81 60 0 0 0 9 112 72 89 115 0 0 46 35 0 0 46 35 1 120 165 63 118 0 0 0 7 116 73 77 69 7 234 10 14 4 15 1 38 242 121 83 0 0 3 98 73 68 65 84 72 199 157 213 77 108 84 85 20 7 240 223 125 51 211 111 250 65 232 52 20 194 20 161 34 86 196 248 65 80 66 20 18 37 134 68 12 193 149 138 27 116 69 92 184 38 36 198 184 50 209 196 184 48 110 116 97 98 220 168 145 200 138 24 227 198 133 223 31 104 74 2 180 24 104 32 72 165 180 72 167 157 119 93 188 87 232 132 129 78 56 201 91 188 123 207 61 255 123 254 231 127 238 9 154 180 56 20 74 98 172 224 121 92 83 104 125 43 156 154 77 151 58 87 92 50 112 69 31 54 139 113 39 246 98 24 239 73 171 37 204 222 49 64 28 74 90 196 244 25 28 196 221 232 95 228 191 92 116 231 0 177 162 69 76 247 225 109 12 52 112 89 69 236 192 244 82 0 201 45 214 159 194 59 183 8 14 155 48 212 76 237 194 162 91 175 70 9 255 224 115 236 88 188 223 192 62 198 129 48 126 123 154 146 44 120 232 195 155 104 197 19 216 188 68 112 216 135 189 177 146 249 197 138 158 88 209 115 19 64 28 10 37 226 75 57 45 147 88 131 174 38 178 111 195 97 60 30 43 10 88 143 67 177 98 101 125 6 153 182 15 160 35 47 122 119 51 242 205 109 3 62 192 118 76 97 23 222 207 233 190 78 209 14 220 155 3 188 128 246 58 122 98 254 245 182 241 224 106 6 150 101 255 55 106 56 140 119 115 122 191 193 211 120 61 86 66 199 2 192 35 185 99 17 175 97 43 170 160 134 225 126 241 217 17 233 203 91 212 246 63 32 110 95 203 220 77 153 140 96 63 62 203 69 178 135 184 43 174 235 12 69 234 56 43 231 69 46 72 130 184 181 34 221 179 65 236 107 167 165 144 37 212 221 38 196 134 98 121 12 31 226 114 158 213 110 181 171 199 138 104 169 239 50 69 229 78 113 243 42 241 190 126 177 220 73 178 136 177 187 122 89 221 197 165 25 210 184 152 174 50 42 57 88 198 76 140 43 138 88 94 7 80 74 164 207 221 79 49 17 7 187 235 130 67 44 119 74 119 223 35 249 249 156 56 188 66 248 234 79 174 206 19 180 227 201 252 73 89 0 236 45 214 181 123 36 110 91 43 221 184 66 114 230 50 237 13 196 84 74 164 91 6 9 65 220 84 22 86 46 147 124 242 11 23 103 250 241 34 215 123 161 148 121 51 186 88 19 177 210 75 91 81 58 188 92 108 47 53 22 103 123 73 186 101 80 184 48 45 29 233 23 55 173 36 104 205 111 191 144 242 12 174 36 248 14 217 187 158 132 76 142 197 132 82 129 194 109 154 185 165 192 108 74 107 65 28 41 103 103 234 109 98 1 224 7 156 82 39 252 38 44 9 210 117 125 89 214 3 157 180 21 235 165 194 111 132 201 68 72 198 112 20 243 96 62 18 155 4 233 204 40 12 215 106 204 215 13 183 139 56 26 198 227 76 18 198 210 25 124 132 81 181 40 156 157 162 154 106 218 34 225 212 36 213 218 194 74 13 95 16 142 221 152 7 73 233 87 28 194 68 248 241 172 48 53 219 116 252 112 241 63 225 143 243 212 162 252 5 248 20 111 132 241 56 125 29 32 156 158 75 37 197 35 130 131 206 252 123 34 249 114 180 22 38 175 45 125 243 169 170 228 167 9 78 156 175 230 106 60 140 87 195 184 191 111 26 56 217 28 46 20 196 218 195 82 175 196 157 235 119 165 219 214 12 234 239 8 177 187 133 16 178 218 204 204 9 213 154 48 49 61 23 190 63 123 33 124 125 242 119 137 111 5 71 20 123 142 135 147 151 99 195 137 86 63 147 67 143 66 88 103 227 192 163 113 160 235 33 93 173 107 137 37 73 114 197 213 234 57 73 248 43 156 188 52 234 248 133 211 74 206 11 201 100 24 75 231 27 197 250 31 122 29 17 245 139 31 118 58 0 0 0 0 73 69 78 68 174 66 96 130] readStream ]
]

{ #category : 'controlling' }
RMDExperimentarium >> ifValidated: aBlock [

	^ validated = true ifTrue: [ aBlock cull: self ]
]

{ #category : 'updating' }
RMDExperimentarium >> informServer [
	(lastServerUpdate isNil
		or: [ DateAndTime now - lastServerUpdate >= self serverUpdateInterval ])
		ifTrue: [ self basicInformServer ]
]

{ #category : 'initialization' }
RMDExperimentarium >> initialize [

	super initialize.
	validated := false.
	saved := false.
	currentPopulation := Dictionary new.
	maxPopulation := Dictionary new.
	minPopulation := Dictionary new.
	populationByTime := Dictionary new
]

{ #category : 'initialization' }
RMDExperimentarium >> initializePresenters [

	super initializePresenters.
	self initializeOpenAnalysisButtonsPresenters.
	runButton := self newButton
		             icon: self runIcon;
		             action: [ self runButtonPressed ];
		             help: 'Run the simulation to the end';
		             state: false;
		             yourself.
	stepButton := self newButton
		              icon: self stepIcon;
		              action: [ self stepSimulation ];
		              help: 'Run the simulation just one step forward';
		              enabled: true;
		              yourself.
	removeRunButton := self newButton
		                   icon: self removeIcon;
		                   action: [ self removeRun ];
		                   help: 'Remove the run from the repository';
		                   enabled: true;
		                   yourself.
	saveRunAsButton := self newButton
		                   icon: self saveIcon;
		                   action: [ self saveRunAs ];
		                   help: 'Rename and save the run into the repository';
		                   enabled: true;
		                   yourself.

	timeProgressBar := self newProgressBar
		                   fixedAt: 0.0;
		                   yourself.
	limitsNumberOfIndividualsCheckBox := self newCheckBox
		                                     label: 'Limit max individuals to';
		                                     labelClickable: true;
		                                     state: false;
		                                     whenChangedDo: [ self limitsNumberOfIndividualsChanged ];
		                                     yourself.
	numberOfIndividualField := self newNumberInput
		                           beInteger;
		                           disable;
		                           color: (Color gray: 0.75);
		                           number: 100000;
		                           climbRate: 10000;
		                           whenBuiltDo: [ numberOfIndividualField color: (Color gray: 0.75) ];
		                           yourself.
	usesFireButton := self newButton
		                  label: 'Fire';
		                  icon: nil;
		                  state: false;
		                  action: [ self toggleFire ];
		                  yourself.
	interpreterDropList := self newDropList
		                       display: [ :runId |
			                       (metaInterpreter interpreterAt: runId ifAbsent: [ nil ]) ifNotNil: #shortName ifNil: [ '-' ] ];
		                       whenSelectedItemChangedDo: [ self updateDisplay ];
		                       yourself.
	timeLabel := self newLabel
		             label: '';
		             yourself.
	populationTable := self newTable
		                   beResizable;
		                   addColumn: (SpStringTableColumn title: 'name' evaluated: #yourself);
		                   addColumn: (SpStringTableColumn
				                    title: 'min'
				                    evaluated: [ :name |
					                    self printNat:
							                    (minPopulation at: self runId ifPresent: [ :dict | dict at: name ifAbsent: [ nil ] ] ifAbsent: [ nil ]) ]);
		                   addColumn: (SpStringTableColumn
				                    title: 'max'
				                    evaluated: [ :name |
					                    self printNat:
							                    (maxPopulation at: self runId ifPresent: [ :dict | dict at: name ifAbsent: [ nil ] ] ifAbsent: [ nil ]) ]);
		                   addColumn: (SpStringTableColumn title: 'now' evaluated: [ :name |
					                    self printNat:
							                    (currentPopulation
								                     at: self runId
								                     ifPresent: [ :dict | dict at: name ifAbsent: [ nil ] ]
								                     ifAbsent: [ nil ]) ]);
		                   whenSelectionChangedDo: [ self updateDisplay ];
		                   yourself.
	showPopulationChartRadioButton := self newRadioButton
		                                  label: 'Population chart';
		                                  whenChangedDo: [ self updateDisplay ];
		                                  yourself.
	showVisualMapRadioButton := self newRadioButton
		                            label: 'Visual map';
		                            whenChangedDo: [ self updateDisplay ];
		                            associatedRadioButtons: { showPopulationChartRadioButton };
		                            yourself.
	showPopulationChartRadioButton state: true.
	visualizationImage := self newImage
		                      autoScale: false;
		                      yourself.
	self whenDisplayDo: [ self updateDisplay ]
]

{ #category : 'initialization' }
RMDExperimentarium >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 800 @ 480
]

{ #category : 'accessing' }
RMDExperimentarium >> interpreterDo: aBlock [

	(metaInterpreter interpreterAt: self runId ifAbsent: [ nil ]) 
		ifNotNil: aBlock
]

{ #category : 'testing' }
RMDExperimentarium >> isRemoved [

	^ metaInterpreter isNil
]

{ #category : 'api' }
RMDExperimentarium >> isRunningSimulation [

	^ metaInterpreter isRunningSimulation
]

{ #category : 'testing' }
RMDExperimentarium >> isSaved [

	^ saved
]

{ #category : 'testing' }
RMDExperimentarium >> isValidated [
	^ validated = true
]

{ #category : 'updating' }
RMDExperimentarium >> limitsNumberOfIndividualsChanged [

	limitsNumberOfIndividualsCheckBox state
		ifTrue: [ 
			numberOfIndividualField
				enable;
				color: Color white ]
		ifFalse: [ 
			numberOfIndividualField
				disable;
				color: (Color gray: 0.75) ]
]

{ #category : 'private' }
RMDExperimentarium >> metaInterpreterForTabularDo: aBlock [

	^ (metaInterpreter notNil and: [ 
		   metaInterpreter context isForFileMemory ]) ifTrue: [ 
		  aBlock value:
			  (metaInterpreter simulationModel 
				   metaInterpreterOnReadOnlyModelPath:
				   metaInterpreter context modelPath) ]
]

{ #category : 'accessing' }
RMDExperimentarium >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
]

{ #category : 'operations' }
RMDExperimentarium >> okToClose [

	(self
		 confirm: 'Do you want to remove the run data?'
		 label: 'Experimentarium') ifTrue: [ self removeRun ].
	^ true
]

{ #category : 'api' }
RMDExperimentarium >> pauseSimulation [

	metaInterpreter pauseSimulation
]

{ #category : 'private' }
RMDExperimentarium >> printNat: anInteger [

	^ anInteger
		  ifNotNil: [ 
			  anInteger > 0
				  ifTrue: [ 
					  | nat str |
					  nat := anInteger.
					  str := ',' join: (Array streamContents: [ :stream | 
							          [ nat > 0 ] whileTrue: [ 
								          | n |
								          n := nat % 1000.
								          stream nextPut: (n < 100
										           ifTrue: [ 
											           n < 10
												           ifTrue: [ '00' , n printString ]
												           ifFalse: [ '0' , n printString ] ]
										           ifFalse: [ n printString ]).
								          nat := nat // 1000 ] ]) reversed.
					  [ str first = $0 ] whileTrue: [ str := str allButFirst ].
					  str ]
				  ifFalse: [ '0' ] ]
		  ifNil: [ '-' ]
]

{ #category : 'operations' }
RMDExperimentarium >> removeRun [

	(metaInterpreter ifNotNil: #modelPath) ifNotNil: [ :modelPath |
		(UIManager default
			 confirm: 'Remove this run from the repository?'
			 label: 'Remove run') ifTrue: [
			modelPath ensureDeleteAll.
			self setMetaInterpreter: nil.
			self updateButtons ] ]
]

{ #category : 'operations' }
RMDExperimentarium >> runButtonPressed [

	metaInterpreter isRunningSimulation
		ifTrue: [ self pauseSimulation ]
		ifFalse: [ self runSimulation ]
]

{ #category : 'accessing' }
RMDExperimentarium >> runId [

	^ interpreterDropList selectedItem ifNil: [ 1 ]
]

{ #category : 'api' }
RMDExperimentarium >> runSimulation [

	self isValidated ifTrue: [ 
		metaInterpreter runSimulationOnError: [ :ex | 
			(RMDActionDebugger exception: ex) open ] ]
]

{ #category : 'operations' }
RMDExperimentarium >> saveRunAs [

	(metaInterpreter ifNotNil: #modelPath) ifNotNil: [ :modelPath |
		(UIManager default
			 request: 'New name of this run'
			 initialAnswer: modelPath basename
			 title: 'Save this run as...') ifNotNil: [ :string |
			string trim ifNotEmpty: [ :name |
				| ref |
				ref := RMDRunsRepository runsDirectory / name.
				ref exists ifTrue: [
					^ UIManager default alert:
						  'A run named "' , name , '" already exists.' ].
				modelPath moveTo: ref.
				saved := true.
				self setMetaInterpreter: (RMDMetaInterpreter onModelPath: ref) ] ] ]
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedIndividual [

	^ nil
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedRunId [

	^ nil
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedTime [

	| time |
	time := nil.
	metaInterpreter interpretersDo: [ :interpreter | 
		| t |
		t := interpreter time.
		(time isNil or: [ time > t ]) ifTrue: [ time := t ] ].
	^ time
]

{ #category : 'accessing' }
RMDExperimentarium >> serverUpdateInterval [
	^ 10 seconds
]

{ #category : 'initialization' }
RMDExperimentarium >> setMetaInterpreter: aRMDMetaInterpreter [

	metaInterpreter ifNotNil: [
		metaInterpreter announcer unsubscribe: self.
		metaInterpreter interpretersDo: [ :interpreter |
			interpreter announcer unsubscribe: self ] ].
	metaInterpreter := aRMDMetaInterpreter.
	self window ifNotNil: [ :window | window title: self title ].
	metaInterpreter ifNotNil: [
		self typecheck.
		self isValidated ifTrue: [
			metaInterpreter setupSimulation.
			metaInterpreter guard: [ :interpreter |
				self canProceed: interpreter ].
			currentPopulation := Dictionary new.
			maxPopulation := Dictionary new.
			minPopulation := Dictionary new.
			populationByTime := Dictionary new.
			metaInterpreter interpretersDo: [ :i |
				| runId |
				runId := i runId.
				currentPopulation at: runId put: Dictionary new.
				maxPopulation at: runId put: Dictionary new.
				minPopulation at: runId put: Dictionary new.
				populationByTime at: runId put: (OrderedCollection new: 1024).
				i announcer weak
					when: RMDSimulationStarted send: #simulationStarted: to: self;
					when: RMDTimeChanged send: #timeChanged: to: self;
					when: RMDSimulationPaused send: #simulationPaused: to: self ].
			interpreterDropList
				items: metaInterpreter runIds;
				selectIndex: 1;
				enable.
			metaInterpreter fastForward.
			self
				updateTableItems;
				updateDisplay ] ].
	self updateButtons
]

{ #category : 'updating' }
RMDExperimentarium >> simulationPaused: aRMDSimulationPaused [

	metaInterpreter isRunningSimulation ifFalse: [ 
		runButton state: false.
		stepButton enable.
		self updateDisplay.
		lastDisplayUpdate := nil ]
]

{ #category : 'updating' }
RMDExperimentarium >> simulationStarted: aRMDSimulationStarted [

	runButton state: true.
	stepButton disable.
	lastDisplayUpdate := DateAndTime now
]

{ #category : 'accessing' }
RMDExperimentarium >> stagePrefix [
	^ '  '
]

{ #category : 'api' }
RMDExperimentarium >> stepSimulation [

	self isValidated ifTrue: [ 
		[ metaInterpreter stepSimulation ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger exception: ex) open ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> timeChanged: aRMDTimeChanged [

	| now |
	self informServer.
	self updateObservation: aRMDTimeChanged.
	now := DateAndTime now.
	(lastDisplayUpdate isNil or: [ 
		 now - lastDisplayUpdate > 200 milliSecond ]) ifFalse: [ ^ self ].
	self interpreterDo: [ :interpreter | 
		interpreter == aRMDTimeChanged interpreter ifTrue: [ 
			lastDisplayUpdate := now.
			self updateDisplay ] ]
]

{ #category : 'accessing' }
RMDExperimentarium >> title [

	^ 'Experimentarium'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (self isValidated
			   ifTrue: [ '' ]
			   ifFalse: [ ' (INVALID MODEL)' ]) , (metaInterpreter
		   ifNotNil: [ 
			   '[', metaInterpreter memoryName, ']' ]
		   ifNil: [ '' ])
]

{ #category : 'operations' }
RMDExperimentarium >> toggleFire [

	usesFireButton state: usesFireButton state not.
	metaInterpreter ifNotNil: [ metaInterpreter usesFire: usesFireButton state ].
	self updateUsesFireButton
]

{ #category : 'api' }
RMDExperimentarium >> typecheck [

	[ 
	metaInterpreter typecheck.
	^ validated := true ]
		on: RMDSemanticError
		do: [ :ex | 
			runButton disable.
			stepButton disable.
			UIManager default alert: ex messageText title: 'Invalid Model'.
			^ validated := false ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateButtons [

	metaInterpreter
		ifNil: [
			stepButton disable.
			runButton disable.
			saveRunAsButton disable.
			removeRunButton disable.
			limitsNumberOfIndividualsCheckBox disable.
			numberOfIndividualField disable.
			interpreterDropList disable.
			populationTable disable.
			showPopulationChartRadioButton disable.
			showVisualMapRadioButton disable.
			openTabularButton disable.
			openObservatoryButton disable ]
		ifNotNil: [
			saveRunAsButton enabled: metaInterpreter modelPath notNil.
			removeRunButton enabled: metaInterpreter modelPath notNil.
			self updateOpenAnalysisButtons ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateDisplay [

	metaInterpreter ifNil: [ ^ self ].
	populationTable ifNotNil: #refresh.
	timeProgressBar fixedAt: metaInterpreter progress.
	self
		updatePopulationChart;
		updateVisualMap;
		updateTimeLabel
]

{ #category : 'updating' }
RMDExperimentarium >> updateObservation: aRMDTimeChanged [

	| interpreter model runId speciesPopulations |
	interpreter := aRMDTimeChanged interpreter.
	model := interpreter simulationModel.
	runId := interpreter runId.
	speciesPopulations := Dictionary new.
	model animatDefinitionsDo: [ :animat | 
		| population stage |
		population := interpreter numberOfIndividualsOf: animat.
		speciesPopulations
			at: animat species
			put:
			(speciesPopulations at: animat species ifAbsent: [ 0 ])
			+ population.
		stage := self stagePrefix , animat name.
		currentPopulation
			at: runId
			ifPresent: [ :current | current at: stage put: population ].
		minPopulation at: runId ifPresent: [ :mins | 
			mins
				at: stage
				put:
				((mins at: stage ifAbsent: [ Float infinity ]) min: population) ].
		maxPopulation at: runId ifPresent: [ :maxs | 
			maxs
				at: stage
				put: ((maxs at: stage ifAbsent: [ 0 ]) max: population) ] ].
	speciesPopulations keysAndValuesDo: [ :species :population | 
		currentPopulation
			at: runId
			ifPresent: [ :current | current at: species put: population ].
		minPopulation at: runId ifPresent: [ :mins | 
			mins
				at: species
				put:
				((mins at: species ifAbsent: [ Float infinity ]) min: population) ].
		maxPopulation at: runId ifPresent: [ :maxs | 
			maxs
				at: species
				put: ((maxs at: species ifAbsent: [ 0 ]) max: population) ] ].
	populationByTime at: runId ifPresent: [ :byTime | 
		currentPopulation
			at: runId
			ifPresent: [ :current | byTime add: current copy ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> updatePopulationChart [

	(showPopulationChartRadioButton state and: [
		 visualizationImage adapter notNil ]) ifTrue: [
		| form |
		self interpreterDo: [ :interpreter |
			| runId canvas byTime |
			runId := interpreter runId.
			form := Form extent: visualizationImage adapter extent depth: 32.
			canvas := form getCanvas.
			canvas fillColor: Color white.
			byTime := populationByTime at: runId ifAbsent: [ ^ self ].
			byTime ifEmpty: [ ^ self ].
			populationTable selectedItem ifNotNil: [ :animat |
				| chartWidth chartHeight font fontHeight min max |
				font := TextStyle defaultFont.
				fontHeight := font height.
				chartWidth := form width.
				chartHeight := form height - (fontHeight * 2).
				min := (minPopulation at: runId ifAbsent: [ ^ self ])
					       at: animat
					       ifAbsent: [ ^ self ].
				max := (maxPopulation at: runId ifAbsent: [ ^ self ])
					       at: animat
					       ifAbsent: [ ^ self ].
				min < max ifTrue: [
					| xScale yScale minString maxString |
					xScale := chartWidth
					          /
					          (interpreter duration / interpreter deltaTime) ceiling.
					yScale := chartHeight / (max - min).
					minString := 'min = ' , min printString.
					maxString := 'max = ' , max printString.
					canvas
						drawString: minString
						at: 0 @ (chartHeight - fontHeight)
						font: font
						color: Color gray.
					canvas
						drawString: maxString
						at: 0 @ 0
						font: font
						color: Color gray.
					canvas
						line: interpreter time * xScale @ 0
						to: interpreter time * xScale @ chartHeight
						width: 1
						color: Color red.
					1 to: byTime size - 1 do: [ :time1 |
						| time2 value1 value2 |
						time2 := time1 + 1.
						value1 := (byTime at: time1) at: animat.
						value2 := (byTime at: time2) at: animat.
						canvas
							line: (time1 * xScale) rounded
								@ (chartHeight - (value1 - min * yScale) rounded)
							to: (time2 * xScale) rounded
								@ (chartHeight - (value2 - min * yScale) rounded)
							width: 1
							color: Color black ] ].
				canvas
					drawString: '0'
					at: 0 @ chartHeight
					font: font
					color: Color gray.
				byTime size > 1 ifTrue: [
					| time timeUnit timeString |
					time := byTime size - 1 * interpreter deltaTime.
					timeUnit := interpreter durationUnit.
					timeString := ((timeUnit fromSI: time)
						               printShowingDecimalPlaces: 1) , ' ['
					              , timeUnit printString , ']'.
					canvas
						drawString: timeString
						at: chartWidth - (font widthOfString: timeString) @ chartHeight
						font: font
						color: Color gray ].
				visualizationImage image: form ] ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTableItems [

	populationTable items: (Array streamContents: [ :stream | 
			 self interpreterDo: [ :interpreter | 
				 | model |
				 model := interpreter simulationModel.
				 model speciesNames do: [ :species | 
					 stream nextPut: species.
					 model animatDefinitionsDo: [ :animat | 
						 animat species = species ifTrue: [ 
							 stream nextPut: self stagePrefix , animat name ] ] ] ] ]).
	populationTable items ifNotEmpty: [ populationTable selectIndex: 1 ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTimeLabel [

	self interpreterDo: [ :interpreter | 
		| time |
		time := interpreter time.
		timeLabel label: (String streamContents: [ :stream | 
				 4 timesRepeat: [ stream space ].
				 interpreter simulationModel simulationDefinition timeDefinition 
					 printOn: stream.
				 stream nextPutAll: ' - now '.
				 (interpreter durationUnit fromSI: time)
					 printOn: stream
					 showingDecimalPlaces: 1.
				 stream nextPutAll: ' [ '.
				 interpreter durationUnit printOn: stream.
				 stream nextPutAll: ' ], '.
				 interpreter ticks printOn: stream.
				 stream nextPutAll: ' steps.' ]) ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTimeProgressBar [

	| now |
	now := DateAndTime now.
	(lastDisplayUpdate isNil or: [ 
		 now - lastDisplayUpdate > 100 milliSecond ]) ifTrue: [ 
		lastDisplayUpdate := now.
		self basicUpdateTimeProgressBar ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateUsesFireButton [

	self usesFire
		ifTrue: [
				usesFireButton
					icon: self fireIcon;
					label: '';
					color: Color yellow;
					withAdapterDo: [ :a |
							a widgetDo: [ :w |
										w
											color: Color yellow;
											backgroundColor: Color yellow;
											onColor: Color yellow offColor: Color yellow;
											changed ] ] ]
		ifFalse: [
				usesFireButton
					icon: nil;
					label: 'Fire';
					color: Color darkGray;
					withAdapterDo: [ :a |
							a widgetDo: [ :w |
										w
											backgroundColor: Color darkGray;
											changed ] ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateVisualMap [

	(showVisualMapRadioButton state and: [ 
		 visualizationImage adapter notNil ]) ifTrue: [ 
		self interpreterDo: [ :interpreter | 
			| visualizer |
			visualizer := RMDVisualizer new.
			interpreter simulationModel renderersDo: [ :renderer | 
				visualizer addRenderer: renderer ].
			visualizer extent: visualizationImage adapter extent.
			visualizationImage image: (visualizer visualize: interpreter) ] ]
]

{ #category : 'private' }
RMDExperimentarium >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self title ]
]

{ #category : 'testing' }
RMDExperimentarium >> usesFire [

	^ usesFireButton state
]

{ #category : 'accessing' }
RMDExperimentarium >> windowTitle [

	^ 'Experimentarium'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (self isValidated
			   ifTrue: [ '' ]
			   ifFalse: [ ' (INVALID MODEL)' ]) , (metaInterpreter
		   ifNotNil: [ 
			   '[', metaInterpreter memoryName, ']' ]
		   ifNil: [ '' ])
]
