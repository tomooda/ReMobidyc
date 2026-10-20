Class {
	#name : 'ReMobidycFireWorker',
	#superclass : 'FedFireAndForgetWorker',
	#instVars : [
		'_interpreter',
		'_memory',
		'_simulationModel'
	],
	#category : 'ReMobidyc-Interpreter-Fire',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Fire'
}

{ #category : 'accessing' }
ReMobidycFireWorker class >> argDescription [

	^ 'the fullpath to the run directory, e.g. ~/Documents/ReMobidyc/runs/YourSimulation-2001-01-01T00-00-00.000000+09-00/run3'
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> commandName [

	^ 'fire'
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> description [

	^ 'Execute a run as a worker process'
]

{ #category : 'commandline' }
ReMobidycFireWorker class >> fire [

	<commandline>
	^ self commandSpec
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> lockfileFor: aFileReference [

	^ aFileReference / self lockfilename
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> lockfilename [

	^ 'lock'
]

{ #category : 'running' }
ReMobidycFireWorker class >> pause: aFileReference [

	^ (self pausefileFor: aFileReference) ensureCreateFile
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> pausefileFor: aFileReference [

	^ aFileReference / self pausefilename
]

{ #category : 'accessing' }
ReMobidycFireWorker class >> pausefilename [

	^ 'pause'
]

{ #category : 'running' }
ReMobidycFireWorker class >> run: aFileReference [

	| lockfile |
	lockfile := (self lockfileFor: aFileReference) ensureCreateFile.
	self value: aFileReference fullName.
	^ lockfile
]

{ #category : 'accessing' }
ReMobidycFireWorker >> interpreterOn: runPath [

	| modelPath memory simulationModel |
	modelPath := runPath parent.
	memory := self memoryClass on: runPath modelPath: modelPath.
	simulationModel := (self simulationModelClass importModel: modelPath ifError: [ ^ nil ]) instantiateWithMetaParameters:
		                   memory metaparameters.
	^ simulationModel interpreterOn: memory
]

{ #category : 'accessing' }
ReMobidycFireWorker >> lockfileFor: aFileReference [

	^ self class lockfileFor: aFileReference
]

{ #category : 'class access' }
ReMobidycFireWorker >> memoryClass [

	^ RMDFileMemory
]

{ #category : 'accessing' }
ReMobidycFireWorker >> pausefileFor: aFileReference [

	^ self class pausefileFor: aFileReference
]

{ #category : 'execution' }
ReMobidycFireWorker >> process: runPath [

	| lockfile |
	lockfile := self lockfileFor: runPath.
	lockfile
		ensureCreateFile;
		writeStreamDo: [ :stream |
				stream truncate.
				FedLibC pid printOn: stream ].
	self run: runPath.
	lockfile ensureDelete
]

{ #category : 'accessing' }
ReMobidycFireWorker >> readRequest [

	^ super readRequest asFileReference
]

{ #category : 'execution' }
ReMobidycFireWorker >> run: runPath [

	| pausefile |
	pausefile := self pausefileFor: runPath.
	(self interpreterOn: runPath) ifNotNil: [ :interpreter |
			interpreter
				loadDataSources;
				fastForward.
			[ pausefile exists not and: [ interpreter stepSimulation ] ] whileTrue ]
]

{ #category : 'class access' }
ReMobidycFireWorker >> simulationModelClass [

	^ RMDSimulationModel
]
