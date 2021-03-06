Class {
	#name : #RMDAbstractInterpreter,
	#superclass : #Model,
	#instVars : [
		'simulationModel',
		'context',
		'contextSemaphore'
	],
	#classVars : [
		'StandardLibrary'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'library access' }
RMDAbstractInterpreter class >> standardLibrary [
	^ StandardLibrary
		ifNil: [ StandardLibrary := {('min' -> RMDFunction min).
			('max' -> RMDFunction max).
			('mean' -> RMDFunction mean).
			('sum' -> RMDFunction sum).
			('sin' -> RMDFunction sin).
			('cos' -> RMDFunction cos).
			('abs' -> RMDFunction abs)} asDictionary ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel actionDefinitionAt: aString ifAbsent: errorBlock ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> actionNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #actionNames
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> addActionDefinition: aRMDActionDefinitionNode [
	^ simulationModel
		ifNotNil: [ simulationModel addActionDefinition: aRMDActionDefinitionNode ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel animatDefinitionAt: aString ifAbsent: errorBlock ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> animatDefinitionAt: aString ifPresent: aBlock [
	^ simulationModel
		ifNotNil: [ simulationModel animatDefinitionAt: aString ifPresent: aBlock ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> animatNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #animatNames
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> cellDefinition [
	^ simulationModel cellDefinition
]

{ #category : #'space access' }
RMDAbstractInterpreter >> cellLength [
	^ simulationModel cellLength
]

{ #category : #'space access' }
RMDAbstractInterpreter >> cellX: aNumber [
	^ (aNumber - self west) / simulationModel cellLength
]

{ #category : #'space access' }
RMDAbstractInterpreter >> cellXDivisions [
	^ simulationModel cellXDivisions
]

{ #category : #'space access' }
RMDAbstractInterpreter >> cellY: aNumber [
	^ (aNumber - self south) / simulationModel cellLength
]

{ #category : #'space access' }
RMDAbstractInterpreter >> cellYDivisions [
	^ simulationModel cellYDivisions
]

{ #category : #private }
RMDAbstractInterpreter >> context [
	^ context
]

{ #category : #timing }
RMDAbstractInterpreter >> deltaTime [
	^ simulationModel deltaTime
]

{ #category : #'space access' }
RMDAbstractInterpreter >> east [
	^ simulationModel east
]

{ #category : #initialization }
RMDAbstractInterpreter >> initialize [
	super initialize.
	simulationModel := RMDSimulationModel new.
	contextSemaphore := Semaphore forMutualExclusion
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> load: aRMDSyntaxNode [
	simulationModel load: aRMDSyntaxNode
]

{ #category : #'space access' }
RMDAbstractInterpreter >> north [
	^ simulationModel north
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> removeTaskDefinition: aRMDTaskDefinitionNode ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel
				removeTaskDefinition: aRMDTaskDefinitionNode
				ifAbsent: errorBlock ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> replaceTask: aRMDTaskDefinitionNode with: anotherRMDTaskDefinitionNode [
	^ simulationModel
		ifNotNil: [ simulationModel
				replaceTask: aRMDTaskDefinitionNode
				with: anotherRMDTaskDefinitionNode ]
]

{ #category : #private }
RMDAbstractInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> simulationDefinition [
	^ simulationModel simulationDefinition
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel [
	^ simulationModel
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]

{ #category : #'space access' }
RMDAbstractInterpreter >> south [
	^ simulationModel south
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> taskDefinitions [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #taskDefinitions
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> taskNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #taskNames
]

{ #category : #'space access' }
RMDAbstractInterpreter >> west [
	^ simulationModel west
]

{ #category : #'context controls' }
RMDAbstractInterpreter >> withContext: aRMDContext do: aBlock [
	^ contextSemaphore
		critical: [ | originalContext |
			originalContext := context.
			self setContext: aRMDContext.
			[ aBlock cull: self cull: context ]
				ensure: [ context := originalContext ] ]
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> worldDefinition [
	^ simulationModel worldDefinition
]
