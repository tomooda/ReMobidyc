Class {
	#name : 'RMDAnimatRendererPresenter',
	#superclass : 'RMDRendererPresenter',
	#instVars : [
		'animatLabel'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'testing' }
RMDAnimatRendererPresenter class >> isAbstract [

	^ self == RMDAnimatRendererPresenter
]

{ #category : 'updating' }
RMDAnimatRendererPresenter >> disableAgentFields [

	super disableAgentFields.
	self updateAnimatLabel
]

{ #category : 'updating' }
RMDAnimatRendererPresenter >> enableAgentFields [

	super enableAgentFields.
	self updateAnimatLabel
]

{ #category : 'initialization' }
RMDAnimatRendererPresenter >> initializePresenters [

	super initializePresenters.
	animatLabel := self newLabel
		               label: '';
		               yourself
]

{ #category : 'accessing' }
RMDAnimatRendererPresenter >> rendererChanged [

	super rendererChanged.
	self updateAnimatLabel
]

{ #category : 'updating' }
RMDAnimatRendererPresenter >> updateAnimatLabel [

	animatLabel label: (agentFieldEnabled
			 ifTrue: [ renderer animat ]
			 ifFalse: [ '' ])
]
