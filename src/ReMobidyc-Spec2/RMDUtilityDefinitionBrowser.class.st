Class {
	#name : 'RMDUtilityDefinitionBrowser',
	#superclass : 'RMDSyntaxNodePresenter',
	#instVars : [
		'identifierField',
		'definitionBodyField'
	],
	#category : 'ReMobidyc-Spec2-Components',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Components'
}

{ #category : 'layout' }
RMDUtilityDefinitionBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #identifierField width: 150;
				   add: ' = ' expand: false;
				   add: #definitionBodyField expand: true;
				   yourself)
		  height: self buttonHeight
]

{ #category : 'examples' }
RMDUtilityDefinitionBrowser class >> example1 [

	| browser |
	(browser := self on:
		            (RMDGrammar current utilityDefinition end parse:
			             'foo = 10 [m]')) openDialog okAction: [
		browser node inspect ]
]

{ #category : 'private' }
RMDUtilityDefinitionBrowser >> definitionBodyChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	definitionBodyField syntaxNode ifNotNil: [ :expression | 
		node definitionBody: expression ]
]

{ #category : 'menu' }
RMDUtilityDefinitionBrowser >> definitionBodyFieldMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Templates...';
						  subMenu: definitionBodyField templateMenu ] ];
		  yourself
]

{ #category : 'private' }
RMDUtilityDefinitionBrowser >> identifierChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	identifierField syntaxNode ifNotNil: [ :identifier | 
		node variable identifier: identifier ]
]

{ #category : 'initialization' }
RMDUtilityDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	identifierField := self newSyntaxNodeTextInput
		                   parser: RMDGrammar current identifier end;
		                   whenLastValidSyntaxNodeChangedDo: [ 
			                   self identifierChanged ];
		                   yourself.
	definitionBodyField := self newSyntaxNodeTextInput
		                       beExpression;
		                       whenLastValidSyntaxNodeChangedDo: [ 
			                       self definitionBodyChanged ];
		                       contextMenu: [ self definitionBodyFieldMenu ];
		                       yourself
]

{ #category : 'initialization' }
RMDUtilityDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Utility definition'.
	aWindowPresenter initialExtent:
		600 @ (self preferredHeight + self class buttonHeight * 3)
]

{ #category : 'accessing' }
RMDUtilityDefinitionBrowser >> nodeChanged [

	node ifNil: [ ^ self ].
	node variable ifNotNil: [ :variable | 
		identifierField text: variable identifier ].
	node definitionBody ifNotNil: [ :expression | 
		definitionBodyField syntaxNode: expression ]
]

{ #category : 'accessing' }
RMDUtilityDefinitionBrowser >> preferredHeight [

	^ self class buttonHeight
]
