Class {
	#name : 'ReMobidycWorkerApplication',
	#superclass : 'ClapApplication',
	#instVars : [
		'_interpreter',
		'_memory',
		'_simulationModel'
	],
	#category : 'ReMobidyc-Application',
	#package : 'ReMobidyc-Application'
}

{ #category : 'running' }
ReMobidycWorkerApplication class >> run: aFileReference [

	| vm image |
	vm := Smalltalk vm fullPath.
	image := Smalltalk imagePath.
	LibC system: (File toPlatformPath: vm , ' --headless ' , image , ' worker ' , aFileReference fullName)
]

{ #category : 'commandline' }
ReMobidycWorkerApplication class >> worker [

	<commandline>
	^ (ClapCommandSpec id: #worker)
		  description: 'execute a run as a worker process';
		  commandClass: self;
		  addPositional: #path
		  description:
			  'the fullpath to the run directory, e.g. ~/Documents/ReMobidyc/runs/YourSimulation-2001-01-01T00-00-00.000000+09-00/run3';
		  addHelp;
		  yourself
]

{ #category : 'execution' }
ReMobidycWorkerApplication >> execute [

	self run
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> interpreter [

	^ _interpreter ifNil: [ _interpreter := self simulationModel ifNotNil: [ :model | model interpreterOn: self memory ] ]
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> memory [

	^ _memory ifNil: [ _memory := self memoryClass on: self runPath modelPath: self modelPath ]
]

{ #category : 'class access' }
ReMobidycWorkerApplication >> memoryClass [

	^ RMDFileMemory
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> metaparameters [

	^ self memory metaparameters
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> modelPath [

	^ self runPath parent
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> randomSeed [

	^ self memory randomSeed
]

{ #category : 'execution' }
ReMobidycWorkerApplication >> run [

	self interpreter ifNotNil: [ :interpreter |
			interpreter setupSimulation.
			[ interpreter stepSimulation ] whileTrue ]
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> runId [

	^ self memory runId
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> runPath [

	^ (self positional: #path) asFileReference
]

{ #category : 'accessing' }
ReMobidycWorkerApplication >> simulationModel [

	^ _simulationModel ifNil: [
			  _simulationModel := (self simulationModelClass importModel: self modelPath ifError: [ nil ]) ifNotNil: [ :model |
				                     model instantiateWithMetaParameters: self metaparameters ] ]
]

{ #category : 'class access' }
ReMobidycWorkerApplication >> simulationModelClass [

	^ RMDSimulationModel
]
