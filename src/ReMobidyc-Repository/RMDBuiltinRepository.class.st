Class {
	#name : 'RMDBuiltinRepository',
	#superclass : 'RMDRepository',
	#classInstVars : [
		'current'
	],
	#category : 'ReMobidyc-Repository',
	#package : 'ReMobidyc-Repository'
}

{ #category : 'accessing' }
RMDBuiltinRepository class >> actionNamed: aString ifAbsent: errorBlock [
	^ self current actionNamed: aString ifAbsent: errorBlock
]

{ #category : 'accessing' }
RMDBuiltinRepository class >> actionNames [
	^ self current actionNames
]

{ #category : 'sole instance' }
RMDBuiltinRepository class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> actionFileNamed: aString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> actionFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ (self actionNames includes: aString)
		ifTrue: [ self perform: aString asSymbol ]
		ifFalse: errorBlock
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> actionNames [
	^ (self class selectorsInProtocol: 'actions') collect: #asString
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> actions [

	^ (self class selectorsInProtocol: 'actions') collect: [ :name | 
		  self perform: name ]
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> addAction: aRMDActionDefinitionNode named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : 'accessing-data' }
RMDBuiltinRepository >> addDataFile: aFileReference named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : 'accessing-icons' }
RMDBuiltinRepository >> addIcon: aForm named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> addModel: aRMDSimulationModel named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : 'accessing-data' }
RMDBuiltinRepository >> dataFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing-data' }
RMDBuiltinRepository >> dataNames [

	^ Array new
]

{ #category : 'actions' }
RMDBuiltinRepository >> die [

	^ 'to die is
	with die.' asRMDActionDefinition
]

{ #category : 'actions' }
RMDBuiltinRepository >> gain [
	^ 'to gain is
	when the thing < the maximum
	the delta thing'' = amount
	where
	amount = min(the amount, the maximum - the thing).' asRMDActionDefinition
]

{ #category : 'accessing' }
RMDBuiltinRepository >> icon [

	^ Smalltalk ui icons objects
]

{ #category : 'accessing-icons' }
RMDBuiltinRepository >> iconNamed: aString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing-icons' }
RMDBuiltinRepository >> iconNames [

	^ Array new
]

{ #category : 'testing' }
RMDBuiltinRepository >> isModifiable [

	^ false
]

{ #category : 'actions' }
RMDBuiltinRepository >> lose [

	^ 'to lose is
	when the thing >= the minimum
	the delta thing'' = - amount
	where
	amount = min(the amount, the thing - the minimum).' asRMDActionDefinition
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> modelFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ errorBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> modelMetadataNamed: aString ifAbsent: errorBlock [
	^ errorBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> modelNamed: aString ifAbsent: errorBlock [
	^ errorBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> modelNames [
	^ Array new
]

{ #category : 'actions' }
RMDBuiltinRepository >> move [

	^ 'to move is
	my d/dt x'' = cos(theta) * r
	my d/dt y'' = sin(theta) * r
where
	theta = the heading
	r = the speed.' asRMDActionDefinition
]

{ #category : 'accessing' }
RMDBuiltinRepository >> name [
	'Built-in'
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> removeActionNamed: aString ifAbsent: errorBlock [
]

{ #category : 'accessing-icons' }
RMDBuiltinRepository >> removeIconNamed: aString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	^ self shouldNotImplement
]

{ #category : 'accessing-actions' }
RMDBuiltinRepository >> renameAction: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ absentBlock value
]

{ #category : 'accessing-data' }
RMDBuiltinRepository >> renameData: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ absentBlock value
]

{ #category : 'accessing-icons' }
RMDBuiltinRepository >> renameIcon: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ absentBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> renameModel: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ absentBlock value
]

{ #category : 'accessing-models' }
RMDBuiltinRepository >> renameModel: aString to: anotherString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : 'accessing' }
RMDBuiltinRepository >> repositoryName [
	^ 'Built-in'
]

{ #category : 'actions' }
RMDBuiltinRepository >> starve [

	^ 'to starve is
	when the vitality < the minimum
	with die.' asRMDActionDefinition
]

{ #category : 'actions' }
RMDBuiltinRepository >> transfer [

	^ 'to transfer is
	the delta source'' = - amount
	the delta destination'' = amount
where
	amount = the amount.
' asRMDActionDefinition
]
