Class {
	#name : 'RMDSourceTemplateFileBrowser',
	#superclass : 'RMDPresenter',
	#instVars : [
		'fileList',
		'addFileButton',
		'removeFileButton',
		'templateList',
		'addTemplateButton',
		'removeTemplateButton',
		'nameField',
		'sourceTextField',
		'expressionCheckBox',
		'descriptionText',
		'acceptTemplateButton'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'menus' }
RMDSourceTemplateFileBrowser class >> remobidycMenuOn: aBuilder [

	<remobidycMenu>
	(aBuilder item: #ReMobidycTools)
		label: 'Tools';
		iconName: #tools;
		order: 50;
		with: [
				(aBuilder item: #ReMobidycTemplateEditor)
					label: 'User-defined Templates';
					iconName: #smallCopy;
					order: 15;
					action: [ RMDSourceTemplateFileBrowser new open ];
					help: 'Browse and edit user defined template files' ]
]

{ #category : 'menus' }
RMDSourceTemplateFileBrowser class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #SourceTemplateFileBrowser)
		parent: 'ReMobidyc';
		order: 15;
		label: 'User-defined Templates';
		action: [ RMDSourceTemplateFileBrowser new open ];
		help: 'Browse and edit user defined template files'
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> acceptSourceTemplate [

	self fileReference ifNotNil: [ :fileReference | 
		self sourceTemplate ifNotNil: [ :sourceTemplate | 
			sourceTemplate
				name: nameField text;
				description: descriptionText text trim;
				sourceText: sourceTextField text.
			self saveTemplateFile.
			templateList selectItem: sourceTemplate ] ]
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> addFile [

	(UIManager default
		 request: 'New filename'
		 initialAnswer: ''
		 title: 'Create a new template file') ifNotNil: [ :string | 
		string trim ifNotEmpty: [ :filename | 
			| newFileRef |
			newFileRef := self templateDirectory / filename withExtension:
				              'json'.
			newFileRef exists
				ifTrue: [ 
					UIManager default
						alert: filename , ' already exists.'
						title: 'File already exists' ]
				ifFalse: [ 
					newFileRef ensureCreateFile writeStreamDo: [ :stream | 
						STONJSON put: Array new onStreamPretty: stream ] ].
			self updateFileList.
			fileList selectItem: newFileRef ] ]
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> addTemplate [

	| templates index newTemplate |
	templates := templateList items.
	index := templateList selection selectedIndex.
	(index between: 1 and: templates size) ifFalse: [ 
		index := templates size + 1 ].
	newTemplate := RMDSourceTemplate new.
	templates := (templates copyFrom: 1 to: index - 1)
	             , (Array with: newTemplate)
	             , (templates copyFrom: index to: templates size).
	templateList
		items: templates;
		selectItem: newTemplate
]

{ #category : 'layout' }
RMDSourceTemplateFileBrowser >> defaultLayout [

	<script: 'RMDSourceTemplateFileBrowser new open'>
	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.25;
		  add: (SpBoxLayout newVertical
				   add: 'Files' expand: false;
				   add: fileList;
				   add: (SpBoxLayout newHorizontal
						    add: addFileButton expand: false;
						    add: removeFileButton expand: false;
						    yourself)
				   expand: false);
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.3;
				   add: (SpBoxLayout newVertical
						    add: 'Templates' expand: false;
						    add: templateList;
						    add: (SpBoxLayout newHorizontal
								     add: addTemplateButton expand: false;
								     add: removeTemplateButton expand: false;
								     yourself)
						    expand: false);
				   add: (SpBoxLayout newVertical
						    add: (SpGridLayout new
								     borderWidth: 0;
								     columnHomogeneous: false;
								     rowHomogeneous: true;
								     column: 1 expand: false;
								     column: 2 expand: true;
								     row: 1 expand: false;
								     row: 2 expand: false;
								     add: 'name' asPresenter atPoint: 1 @ 1;
								     add: nameField atPoint: 2 @ 1;
								     add: 'source' asPresenter atPoint: 1 @ 2;
								     add: sourceTextField atPoint: 2 @ 2;
								     yourself)
						    height: self class inputTextHeight * 2;
						    add: expressionCheckBox expand: false;
						    add: 'description' asPresenter expand: false;
						    add: descriptionText expand: true;
						    add: (SpBoxLayout newHorizontal
								     hAlignEnd;
								     add: acceptTemplateButton expand: false;
								     yourself)
						    expand: false;
						    yourself));
		  yourself
]

{ #category : 'accessing' }
RMDSourceTemplateFileBrowser >> fileReference [

	^ fileList selectedItem
]

{ #category : 'initialization' }
RMDSourceTemplateFileBrowser >> initialExtent [

	^ 900 @ 400
]

{ #category : 'initialization' }
RMDSourceTemplateFileBrowser >> initializePresenters [

	super initializePresenters.
	fileList := self newList
		            display: [ :ref | ref basenameWithoutExtension: 'json' ];
		            whenSelectionChangedDo: [
			            self
				            updateFileButtons;
				            updateTemplateList ];
		            yourself.
	addFileButton := self newButton
		                 icon: self addIcon;
		                 action: [ self addFile ];
		                 yourself.
	removeFileButton := self newButton
		                    icon: self removeIcon;
		                    action: [ self removeFile ];
		                    yourself.
	templateList := self newList
		                display: [ :item | item name ];
		                whenSelectionChangedDo: [
			                self
				                updateTemplateButtons;
				                updateSourceTemplate ];
		                yourself.
	addTemplateButton := self newButton
		                     icon: self addIcon;
		                     action: [ self addTemplate ];
		                     yourself.
	removeTemplateButton := self newButton
		                        icon: self removeIcon;
		                        action: [ self removeTemplate ];
		                        yourself.
	nameField := self newTextInput
		             placeholder: 'name';
		             yourself.
	descriptionText := self newText
		                   placeholder: 'description';
		                   yourself.
	sourceTextField := self newHighlightingSyntaxNodeTextInput
		                   placeholder: 'source to be inserted';
		                   beFreeText;
		                   yourself.

	expressionCheckBox := self newCheckBox
		                      label: 'is expression';
		                      state: false;
		                      whenChangedDo: [
			                      expressionCheckBox state
				                      ifTrue: [ sourceTextField beExpression ]
				                      ifFalse: [ sourceTextField beFreeText ] ];
		                      yourself.
	acceptTemplateButton := self newButton
		                        icon: self acceptIcon;
		                        action: [ self acceptSourceTemplate ].
	self whenBuiltDo: [
		templateList withAdapterDo: [ :a |
			a widgetDo: [ :w | w allowsDeselection: true ] ].
		self updateFileList ]
]

{ #category : 'initialization' }
RMDSourceTemplateFileBrowser >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: self initialExtent
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> removeFile [

	self fileReference ifNotNil: [ :fileReference | 
		(UIManager confirm:
			 'Remove ' , (fileReference basenameWithoutExtension: 'json') , '?') 
			ifTrue: [ 
				fileReference ensureDelete.
				self updateFileList ] ]
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> removeTemplate [

	templateList selectedItem ifNotNil: [ :item | 
		(UIManager default confirm: 'Remove ' , item name , '?') ifTrue: [ 
			templateList
				unselectAll;
				items: (templateList items copyWithout: item).
			self saveTemplateFile ] ]
]

{ #category : 'operations' }
RMDSourceTemplateFileBrowser >> saveTemplateFile [

	self fileReference ifNotNil: [ :fileReference | 
		fileReference ensureDelete lfWriteStreamDo: [ :stream | 
			STONJSON
				put: (templateList items collect: #asJsonObject)
				onStreamPretty: stream ].
		self updateTemplateList ]
]

{ #category : 'accessing' }
RMDSourceTemplateFileBrowser >> sourceTemplate [

	^ templateList selectedItem
]

{ #category : 'accessing' }
RMDSourceTemplateFileBrowser >> templateDirectory [

	^ (FileLocator documents / 'ReMobidyc' / 'templates')
		  ensureCreateDirectory
]

{ #category : 'accessing' }
RMDSourceTemplateFileBrowser >> title [

	^ 'User-defined Template Browser'
]

{ #category : 'updating' }
RMDSourceTemplateFileBrowser >> updateFileButtons [

	removeFileButton enabled: self fileReference notNil
]

{ #category : 'updating' }
RMDSourceTemplateFileBrowser >> updateFileList [

	fileList
		unselectAll;
		items: (self templateDirectory filesMatching: '*.json')
]

{ #category : 'updating' }
RMDSourceTemplateFileBrowser >> updateSourceTemplate [

	self sourceTemplate
		ifNotNil: [ :sourceTemplate | 
			nameField text: sourceTemplate name.
			descriptionText text: sourceTemplate description.
			sourceTextField text: sourceTemplate sourceText ]
		ifNil: [ 
			nameField text: ''.
			descriptionText text: ''.
			sourceTextField text: '' ]
]

{ #category : 'updating' }
RMDSourceTemplateFileBrowser >> updateTemplateButtons [

	addTemplateButton enabled: self fileReference notNil.
	removeTemplateButton enabled: self sourceTemplate notNil
]

{ #category : 'updating' }
RMDSourceTemplateFileBrowser >> updateTemplateList [

	templateList
		unselectAll;
		items: (self fileReference
				 ifNotNil: [ :fileReference | 
					 ([ 
					  fileReference readStreamDo: [ :stream | 
							  STONJSON fromStream: stream ] ]
						  on: Error
						  do: [ Array new ]) collect: [ :dict | 
							 RMDSourceTemplate fromJsonObject: dict ] ]
				 ifNil: [ Array new ])
]

{ #category : 'accessing' }
RMDSourceTemplateFileBrowser >> windowTitle [

	^ 'User-defined Template Browser'
]
