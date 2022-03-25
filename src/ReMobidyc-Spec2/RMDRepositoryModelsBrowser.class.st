Class {
	#name : #RMDRepositoryModelsBrowser,
	#superclass : #RMDAbstractRepositoryBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #utilities }
RMDRepositoryModelsBrowser class >> openForSave: aRMDSimulationModel [

	<script:
	'RMDRepositoryModelsBrowser openForSave: RMDSimulationModel sugarScape'>
	super openForSave: aRMDSimulationModel
]

{ #category : #utilities }
RMDRepositoryModelsBrowser class >> openToLoadDo: aBlock [

	<script:
	'RMDRepositoryModelsBrowser openToLoadDo: [ :model | model inspect ] '>
	super openToLoadDo: aBlock
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> addItem [

	(UIManager default request: 'Enter a new name of the model') 
		ifNotNil: [ :newItem | 
		itemList items: (itemList items copyWith: newItem) ]
]

{ #category : #private }
RMDRepositoryModelsBrowser >> getModel: aString [

	^ self repository ifNotNil: [ :repo | 
		  repo modelNamed: aString ifAbsent: [ nil ] ]
]

{ #category : #initialization }
RMDRepositoryModelsBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Models'
]

{ #category : #accessing }
RMDRepositoryModelsBrowser >> itemsInRepository [

	^ self repository ifNotNil: #modelNames ifNil: [ #(  ) ]
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> load [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo modelNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : #'instance creation' }
RMDRepositoryModelsBrowser >> newItemList [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  addColumn: (SpStringTableColumn evaluated: [ :item | 
					   | text |
					   text := item asText.
					   (self getModel: item) ifNil: [ text makeAllColor: Color red ].
					   text ]);
		  yourself
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> removeItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default confirm:
				 'Remove ' , item , ' from ' , repo name , ' repository?') 
				ifTrue: [ 
					repo removeModelNamed: item ifAbsent: [  ].
					self updateItemList ] ] ]
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> save: aRMDSimulationModel [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  ((repo modelNamed: item ifAbsent: [ nil ]) isNil or: [ 
				   UIManager default confirm:
					   'Overwrite ' , item , ' in ' , repo name , ' repository?' ]) 
				  ifTrue: [ repo addModel: aRMDSimulationModel named: item ] ] ]
]

{ #category : #updating }
RMDRepositoryModelsBrowser >> updateDescriptionText [

	self item
		ifNotNil: [ :item | 
			(self getModel: item) ifNotNil: [ :model | 
				descriptionText text: 'Animats: ' asText allBold
					, (', ' join: (model animatDefinitions collect: #identifier)) ] ]
		ifNil: [ descriptionText text: '' ]
]