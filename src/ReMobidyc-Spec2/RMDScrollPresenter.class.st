Class {
	#name : 'RMDScrollPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'presenter'
	],
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
RMDScrollPresenter class >> with: aPresenter [
	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : 'layout' }
RMDScrollPresenter >> defaultLayout [

	^ SpScrollableLayout with: presenter
]

{ #category : 'initialization' }
RMDScrollPresenter >> initializePresenters [
	super initializePresenters
]

{ #category : 'accessing' }
RMDScrollPresenter >> presenter [
	^ presenter
]

{ #category : 'accessing' }
RMDScrollPresenter >> presenter: aPresenter [
	presenter := aPresenter
]
