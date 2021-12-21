Class {
	#name : #RMDAddAnimatEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'#animatField',
		'#createButton',
		'#action => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAddAnimatEditor class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: 'New animat name' expand: false;
				   add: #animatField
				   expand: true
				   fill: true
				   padding: 20;
				   add: #createButton expand: false;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  yourself
]

{ #category : #accessing }
RMDAddAnimatEditor >> action [

	^ action
]

{ #category : #accessing }
RMDAddAnimatEditor >> action: anObject [

	action := anObject
]

{ #category : #initialization }
RMDAddAnimatEditor >> initializePresenters [

	super initializePresenters.
	animatField := self newAnimatInput.
	createButton := self newButton
		                icon: Smalltalk ui icons add;
		                action: [ 
			                action value: animatField text asString trim ];
		                yourself.
	action := [ :text |  ]
]

{ #category : #enumerating }
RMDAddAnimatEditor >> whenActionChangedDo: aBlock [

	self property: #action whenChangedDo: aBlock
]