Class {
	#name : 'RMDMetadataPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'metadata',
		'nameField',
		'dateField',
		'descriptionText',
		'authorsField'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'instance creation' }
RMDMetadataPresenter class >> on: aRMDMetadata [

	^ self new
		  metadata: aRMDMetadata;
		  yourself
]

{ #category : 'layout' }
RMDMetadataPresenter >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: (SpBoxLayout newHorizontal add: 'model name' asPresenter expand: true) width: 100;
				   add: nameField expand: true)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: (SpBoxLayout newHorizontal add: 'author' asPresenter expand: true) width: 100;
				   add: authorsField expand: true)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: (SpBoxLayout newHorizontal add: 'date' asPresenter expand: true) width: 100;
				   add: dateField expand: true)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: (SpBoxLayout newHorizontal add: 'description' asPresenter expand: true) width: 100;
				   add: descriptionText expand: true)
		  expand: true;
		  yourself
]

{ #category : 'initialization' }
RMDMetadataPresenter >> initializePresenters [

	super initializePresenters.
	nameField := self newTextInput
		             whenTextChangedDo: [ :text | 
			             metadata ifNotNil: [ 
					             metadata
						             name: text;
						             date: DateAndTime now.
					             self metadataChanged ] ];
		             yourself.
	authorsField := self newTextInput
		                whenTextChangedDo: [ :text | 
			                metadata ifNotNil: [ 
					                metadata
						                authors: ((text substrings: ',') collect: #trim);
						                date: DateAndTime now.
					                self metadataChanged ] ];
		                yourself.

	dateField := self newTextInput
		             disable;
		             yourself.
	descriptionText := self newText
		                   whenTextChangedDo: [ :text | 
			                   metadata ifNotNil: [ 
					                   metadata
						                   description: text;
						                   date: DateAndTime now.
					                   self metadataChanged ] ];
		                   yourself
]

{ #category : 'accessing' }
RMDMetadataPresenter >> metadata [
	^ metadata
]

{ #category : 'accessing' }
RMDMetadataPresenter >> metadata: aRMDMetadata [

	metadata := aRMDMetadata.
	self metadataChanged
]

{ #category : 'updating' }
RMDMetadataPresenter >> metadataChanged [

	metadata ifNotNil: [ 
		nameField text: metadata name.
		authorsField text: (', ' join: metadata authors).
		dateField text: metadata dateString.
		descriptionText text: metadata description ]
]

{ #category : 'enumerating' }
RMDMetadataPresenter >> whenNameChangedDo: aBlock [

	nameField whenTextChangedDo: aBlock
]
