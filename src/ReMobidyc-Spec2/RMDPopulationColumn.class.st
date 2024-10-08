Class {
	#name : 'RMDPopulationColumn',
	#superclass : 'RMDTabularColumn',
	#instVars : [
		'runIds',
		'stages'
	],
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'initialization' }
RMDPopulationColumn >> defaultEvaluation [

	^ [ :row | 
	  (self value: row) ifNotNil: [ :value | 
		  value isInteger
			  ifTrue: [ self printNat: value ]
			  ifFalse: [ value ] ] ]
]

{ #category : 'enumerating' }
RMDPopulationColumn >> ifOnChartDo: aBlock [
	^ aBlock cull: self
]

{ #category : 'accessing' }
RMDPopulationColumn >> runIds [

	^ runIds
]

{ #category : 'accessing' }
RMDPopulationColumn >> runIds: anArrayOfInteger [

	runIds := anArrayOfInteger
]

{ #category : 'accessing' }
RMDPopulationColumn >> stages [

	^ stages
]

{ #category : 'accessing' }
RMDPopulationColumn >> stages: anArrayOfRMDAnimatDefinitionNode [

	stages := anArrayOfRMDAnimatDefinitionNode
]

{ #category : 'accessing' }
RMDPopulationColumn >> value: aRow [

	^ ((runIds
		    collect: [ :runId | 
			    (stages
				     collect: [ :stage | 
					     aRow
						     at: { 
								     runId.
								     stage }
						     ifAbsent: [ nil ] ]
				     thenSelect: #notNil) ifNotEmpty: #sum ifEmpty: [ nil ] ]
		    thenSelect: #notNil) ifNotEmpty: #average ifEmpty: [ nil ]) 
		  ifNotNil: [ :value | 
			  (value isFraction and: [ value isInteger not ])
				  ifTrue: [ value asFloat ]
				  ifFalse: [ value ] ]
]
