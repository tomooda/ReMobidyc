Class {
	#name : 'RMDChronicleModelBrowser',
	#superclass : 'RMDPresenter',
	#traits : 'THiDeEditTags',
	#classTraits : 'THiDeEditTags classTrait',
	#instVars : [
		'modelList',
		'folderNameField',
		'nameField',
		'authorField',
		'dateField',
		'descriptionField',
		'tagList',
		'searchField',
		'updateButton',
		'modelerButton',
		'tagButton',
		'openChartsButton'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'instance creation' }
RMDChronicleModelBrowser class >> open [

	<script: 'RMDChronicleModelBrowser open'>
	^ self new open
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> authorFieldChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> chronicleChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> dateFieldChanged [

	self updateModelList
]

{ #category : 'layout' }
RMDChronicleModelBrowser >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.5;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.6;
				   add: (SpBoxLayout newVertical
						    add: 'Search by Metadata' asPresenter expand: false;
						    add: (SpGridLayout new
								     borderWidth: 0;
								     add: '    name' asPresenter atPoint: 1 @ 1;
								     add: #nameField atPoint: 2 @ 1;
								     add: '    author' asPresenter atPoint: 1 @ 2;
								     add: #authorField atPoint: 2 @ 2;
								     add: '    timestamp' asPresenter atPoint: 1 @ 3;
								     add: #dateField atPoint: 2 @ 3;
								     add: '    description' asPresenter atPoint: 1 @ 4;
								     add: #descriptionField atPoint: 2 @ 4;
								     columnHomogeneous: false;
								     rowHomogeneous: false;
								     column: 1 expand: false;
								     column: 2 expand: true;
								     row: 1 expand: false;
								     row: 2 expand: false;
								     row: 3 expand: false;
								     row: 4 expand: false;
								     yourself)
						    expand: true;
						    add: 'Full text search' asPresenter expand: false;
						    add: #searchField expand: false;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Search by Tags' expand: false;
						    add: #tagList;
						    yourself);
				   yourself);
		  add: (SpBoxLayout newVertical
				   add: #modelList;
				   add: (SpBoxLayout newHorizontal
						    add: #updateButton expand: false;
						    add: ' ' asPresenter expand: false;
						    add: #modelerButton expand: false;
						    add: #tagButton expand: false;
						    add: #openChartsButton expand: false;
						    yourself)
				   expand: false;
				   yourself);
		  yourself
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> descriptionFieldChanged [

	self updateModelList
]

{ #category : 'operations' }
RMDChronicleModelBrowser >> editTags [

	modelList selectedItem ifNotNil: [ :chronicleModel |
		self
			editTags: tagList items
			on: chronicleModel
			title: 'Edit tags'
			createNewTagTitle: 'Create new'
			okAction: [ self chronicleChanged ] ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> folderNameFieldChanged [

	self updateModelList
]

{ #category : 'initialization' }
RMDChronicleModelBrowser >> initializePresenters [

	super initializePresenters.
	modelList := self newTable
		             beResizable;
		             beSingleSelection;
		             addColumn: (SpStringTableColumn
				              title: 'location name'
				              evaluated: [ :chronicleModel |
					              chronicleModel folderName ifNil: [ '' ] ]);
		             addColumn: (SpStringTableColumn
				              title: 'name'
				              evaluated: [ :chronicleModel |
					              chronicleModel name ifNil: [ '' ] ]);
		             addColumn: (SpStringTableColumn
				              title: 'timestamp'
				              evaluated: [ :chronicleModel |
					              chronicleModel timestamp ifNil: [ '' ] ]);
		             addColumn: (SpStringTableColumn
				              title: 'description'
				              evaluated: [ :chronicleModel |
					              chronicleModel description
						              ifNotNil: [ :desc |
							              desc lines ifNotEmpty: #first ifEmpty: [ desc ] ]
						              ifNil: [ '' ] ]);
		             whenSelectedItemChangedDo: [ self selectedModelChanged ].
	folderNameField := self newTextInput whenSubmitDo: [ :s |
		                   self folderNameFieldChanged ].
	nameField := self newTextInput whenSubmitDo: [ :s |
		             self nameFieldChanged ].
	authorField := self newTextInput whenSubmitDo: [ :s |
		               self authorFieldChanged ].
	dateField := self newTextInput whenSubmitDo: [ :s |
		             self dateFieldChanged ].
	descriptionField := self newTextInput whenSubmitDo: [ :s |
		                    self descriptionFieldChanged ].
	tagList := (self instantiate: HiDeTagFilterPresenter)
		           tagColumnTitle: 'tag';
		           quantityColumnTitle: '# models';
		           whenFilterChangedDo: [ self updateModelList ];
		           yourself.
	searchField := self newTextInput whenSubmitDo: [ :s |
		               self searchFieldChanged ].
	updateButton := self newButton
		                icon: self updateIcon;
		                help: 'update the list';
		                action: [ self chronicleChanged ];
		                yourself.
	modelerButton := self newButton
		                 icon: self editIcon;
		                 help: 'open on modeler';
		                 action: [ self openInModeler ];
		                 disable;
		                 yourself.
	tagButton := self newButton
		             icon: self tagIcon;
		             help: 'edit tags';
		             action: [ self editTags ];
		             disable;
		             yourself.
	openChartsButton := self newButton
		                    icon: self chartIcon;
		                    help: 'Open charts';
		                    action: [ self openCharts ];
		                    disable;
		                    yourself.
	self chronicleChanged
]

{ #category : 'initialization' }
RMDChronicleModelBrowser >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		initialExtent: 1200 @ 800;
		title: 'Chronicle (models)'
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> nameFieldChanged [

	self updateModelList
]

{ #category : 'operations' }
RMDChronicleModelBrowser >> openCharts [

	modelList selectedItem ifNotNil: [ :chronicleModel |
		chronicleModel charts ifNotEmpty: [ :charts |
			(RMDChartsViewer withAll: charts) open title:
				'Charts for ' , chronicleModel name ] ]
]

{ #category : 'operations' }
RMDChronicleModelBrowser >> openInModeler [

	modelList selectedItem ifNotNil: [ :payload |
		(payload
			 load;
			 simulationModel) openInModeler ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> searchFieldChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> selectedModelChanged [

	modelList selectedItem ifNotNil: [ :chronicleModel |
		self updateButtons ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> updateButtons [

	modelList selectedItem
		ifNotNil: [ :chronicleModel |
			modelerButton enable.
			tagButton enable.
			openChartsButton enabled: (chronicleModel hasTag: 'chart') ]
		ifNil: [
			modelerButton disable.
			tagButton disable.
			openChartsButton disable ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> updateModelList [

	| models |
	models := RMDChronicleStore chronicleModels.
	self updateTags: models.
	folderNameField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m folderName asLowercase includesSubstring: str ] ].
	nameField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m name asLowercase includesSubstring: str ] ].
	authorField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m authors anySatisfy: [ :a |
				          a asLowercase includesSubstring: str ] ] ].
	dateField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m timestamp asLowercase includesSubstring: str ] ].
	descriptionField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m description asLowercase includesSubstring: str ] ].
	models := models select: tagList.
	searchField text asString trim ifNotEmpty: [ :str |
		models := models select: [ :m | m includesSubstring: str ] ].
	modelList items: models.
	self updateButtons
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> updateTags: aCollectionOfChronicleModel [

	tagList persistencies: aCollectionOfChronicleModel
]
