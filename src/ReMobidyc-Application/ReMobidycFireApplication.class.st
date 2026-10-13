Class {
	#name : 'ReMobidycFireApplication',
	#superclass : 'ClapApplication',
	#instVars : [
		'_interpreter',
		'_memory',
		'_simulationModel'
	],
	#category : 'ReMobidyc-Application',
	#package : 'ReMobidyc-Application'
}

{ #category : 'accessing' }
ReMobidycFireApplication class >> commandName [

	^ 'fire'
]

{ #category : 'commandline' }
ReMobidycFireApplication class >> fire [

	<commandline>
	^ (ClapCommandSpec id: #fire)
		  description: 'execute a run as a worker process';
		  commandClass: self;
		  addPositional: #path
		  description:
			  'the fullpath to the run directory, e.g. ~/Documents/ReMobidyc/runs/YourSimulation-2001-01-01T00-00-00.000000+09-00/run3';
		  addHelp;
		  yourself
]

{ #category : 'accessing' }
ReMobidycFireApplication class >> lockfilename [

	^ 'lock'
]

{ #category : 'accessing' }
ReMobidycFireApplication class >> pausefilename [

	^ 'lock'
]

{ #category : 'running' }
ReMobidycFireApplication class >> run: aFileReference [

	| vm image |
	vm := Smalltalk vm fullPath.
	image := Smalltalk imagePath.
	RMDLibC spawn: {
			vm.
			'--headless'.
			image.
			'fire'.
			aFileReference fullName }
]

{ #category : 'execution' }
ReMobidycFireApplication >> execute [

	| lockfile |
	lockfile := self lockfile.
	lockfile ifExists: [ ] ifAbsent: [
			lockfile writeStreamDo: [ :stream | RMDLibC pid printOn: stream ].
			self run.
			lockfile ensureDelete ]
]

{ #category : 'accessing' }
ReMobidycFireApplication >> interpreter [

	^ _interpreter ifNil: [ _interpreter := self simulationModel ifNotNil: [ :model | model interpreterOn: self memory ] ]
]

{ #category : 'accessing' }
ReMobidycFireApplication >> lockfile [

	^ self runPath / self class lockfilename
]

{ #category : 'accessing' }
ReMobidycFireApplication >> memory [

	^ _memory ifNil: [ _memory := self memoryClass on: self runPath modelPath: self modelPath ]
]

{ #category : 'class access' }
ReMobidycFireApplication >> memoryClass [

	^ RMDFileMemory
]

{ #category : 'accessing' }
ReMobidycFireApplication >> metaparameters [

	^ self memory metaparameters
]

{ #category : 'accessing' }
ReMobidycFireApplication >> modelPath [

	^ self runPath parent
]

{ #category : 'accessing' }
ReMobidycFireApplication >> pausefile [

	^ self runPath / self class pausefilename
]

{ #category : 'accessing' }
ReMobidycFireApplication >> randomSeed [

	^ self memory randomSeed
]

{ #category : 'execution' }
ReMobidycFireApplication >> run [

	| pausefile |
	pausefile := self pausefile.
	self interpreter ifNotNil: [ :interpreter |
			interpreter
				loadDataSources;
				fastForward.
			[ pausefile exists not and: [ interpreter stepSimulation ] ] whileTrue ]
]

{ #category : 'accessing' }
ReMobidycFireApplication >> runId [

	^ self memory runId
]

{ #category : 'accessing' }
ReMobidycFireApplication >> runPath [

	^ (self positional: #path) asFileReference
]

{ #category : 'accessing' }
ReMobidycFireApplication >> simulationModel [

	^ _simulationModel ifNil: [
			  _simulationModel := (self simulationModelClass importModel: self modelPath ifError: [ nil ]) ifNotNil: [ :model |
				                     model instantiateWithMetaParameters: self metaparameters ] ]
]

{ #category : 'class access' }
ReMobidycFireApplication >> simulationModelClass [

	^ RMDSimulationModel
]
