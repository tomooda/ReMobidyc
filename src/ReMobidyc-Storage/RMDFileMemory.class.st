Class {
	#name : 'RMDFileMemory',
	#superclass : 'RMDMemory',
	#instVars : [
		'digitsPerDirectoryLevel',
		'basePath',
		'digitsForTime',
		'spaceDirty',
		'allocationDirty',
		'stageLinksDirty',
		'reproductionLinksDirty',
		'modelPath'
	],
	#classVars : [
		'WriteSemaphore'
	],
	#category : 'ReMobidyc-Storage',
	#package : 'ReMobidyc-Storage'
}

{ #category : 'instance creation' }
RMDFileMemory class >> for: aRMDSimulationModel [

	^ self for: aRMDSimulationModel runId: 1
]

{ #category : 'instance creation' }
RMDFileMemory class >> for: aRMDSimulationModel runId: anInteger [

	| modelPath basePath |
	modelPath := self modelPathFor: aRMDSimulationModel.
	basePath := modelPath / ('run' , anInteger printString).
	^ self on: basePath modelPath: modelPath
]

{ #category : 'initialization' }
RMDFileMemory class >> initialize [

	WriteSemaphore := Semaphore new
		                  signal;
		                  signal;
		                  signal;
		                  signal;
		                  yourself
]

{ #category : 'instance creation' }
RMDFileMemory class >> modelPathFor: aRMDSimulationModel [

	| modelPath |
	[
	modelPath := RMDRunsRepository runsDirectory
	             /
		             ((aRMDSimulationModel name ifEmpty: [ 'noname' ]) , '-'
		              ,
		              (DateAndTime now printString
			               copyReplaceAll: ':'
			               with: '-')).
	modelPath exists ] whileTrue: [ 100 milliSecond wait ].
	^ modelPath
]

{ #category : 'instance creation' }
RMDFileMemory class >> on: aFileReference [
	^ self new
		basePath: aFileReference asFileReference;
		yourself
]

{ #category : 'instance creation' }
RMDFileMemory class >> on: basePath modelPath: modelPath [

	^ (self on: basePath) modelPath: modelPath
]

{ #category : 'allocating' }
RMDFileMemory >> allocateWorld: aRMDWorldDefinitionNode [

	| id |
	id := super allocateWorld: aRMDWorldDefinitionNode.
	allocationDirty := true.
	^ id
]

{ #category : 'accessing-storage' }
RMDFileMemory >> allocationFile [
	^ self basePath / self allocationFileBasename
]

{ #category : 'accessing-storage' }
RMDFileMemory >> allocationFileBasename [
	^ 'allocation.csv'
]

{ #category : 'accessing-storage' }
RMDFileMemory >> animatsFileBasename [
	^ 'animats.raw'
]

{ #category : 'accessing-storage' }
RMDFileMemory >> basePath [
	^ basePath
]

{ #category : 'accessing-storage' }
RMDFileMemory >> basePath: aFileReference [

	basePath := aFileReference
		            ensureCreateDirectory;
		            yourself.
	self
		initializeSpace;
		initializeAllocation
]

{ #category : 'accessing-creation times' }
RMDFileMemory >> creationTimesFileBasename [
	^ 'creationtime.raw'
]

{ #category : 'defaults' }
RMDFileMemory >> defaultDigitsForTime [
	^ 6
]

{ #category : 'defaults' }
RMDFileMemory >> defaultDigitsPerDirectoryLevel [
	^ 3
]

{ #category : 'accessing-storage' }
RMDFileMemory >> digitsForTime [
	^ digitsForTime
]

{ #category : 'accessing-storage' }
RMDFileMemory >> digitsForTime: anInteger [
	digitsForTime := anInteger asInteger
]

{ #category : 'accessing-storage' }
RMDFileMemory >> digitsPerDirectoryLevel [
	^ digitsPerDirectoryLevel
]

{ #category : 'accessing-storage' }
RMDFileMemory >> digitsPerDirectoryLevel: anInteger [
	digitsPerDirectoryLevel := anInteger asInteger
]

{ #category : 'accessing-storage' }
RMDFileMemory >> directoryForTime: anInteger [
	| stringId |
	stringId := anInteger asString.
	(String new: self digitsForTime - stringId size withAll: $0)
		, stringId
		readStreamDo: [ :idStream | 
			| ref |
			ref := self basePath.
			(self digitsForTime - 1) // self digitsPerDirectoryLevel + 1
				timesRepeat: [ ref := ref ensureCreateDirectory
						/ (idStream next: self digitsPerDirectoryLevel) ].
			^ ref ]
]

{ #category : 'initialization' }
RMDFileMemory >> initialize [
	super initialize.
	digitsForTime := self defaultDigitsForTime.
	digitsPerDirectoryLevel := self defaultDigitsPerDirectoryLevel.
	spaceDirty := false.
	allocationDirty := false.
	stageLinksDirty := false.
	reproductionLinksDirty := false
]

{ #category : 'initialization' }
RMDFileMemory >> initializeAllocation [

	self readAllocation
		at: 'latestTime' ifPresent: [ :v | latestTime := v ];
		at: 'nextAvailableSlot' ifPresent: [ :v | nextAvailableSlot := v ];
		at: 'world' ifPresent: [ :v | world := v ].
	allocationDirty := false
]

{ #category : 'initialization' }
RMDFileMemory >> initializeSpace [
	self readSpace
		at: 'patch' ifPresent: [ :v | patch := v ];
		at: 'xPatches' ifPresent: [ :v | xPatches := v ];
		at: 'yPatches' ifPresent: [ :v | yPatches := v ];
		at: 'patchSize' ifPresent: [ :v | patchSize := v ].
	spaceDirty := false
]

{ #category : 'accessing' }
RMDFileMemory >> latestTime: anInteger [
	| oldLatestTime |
	oldLatestTime := self latestTime.
	super latestTime: anInteger.
	oldLatestTime = latestTime
		ifFalse: [ allocationDirty := true ]
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> metaparameterJsonBasename [
	^ 'meta-parameters.json'
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> metaparameters [

	metaparameters ifNil: [ self readMetaparameters ].
	^ super metaparameters
]

{ #category : 'accessing-storage' }
RMDFileMemory >> modelPath [

	^ modelPath ifNil: [ self basePath ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> modelPath: aFileReference [

	modelPath := aFileReference
]

{ #category : 'accessing' }
RMDFileMemory >> name [

	^ 'on ' , basePath pathString
]

{ #category : 'accessing' }
RMDFileMemory >> nextAvailableSlot: anInteger [
	| oldSlot |
	oldSlot := self nextAvailableSlot.
	super nextAvailableSlot: anInteger.
	oldSlot = anInteger
		ifTrue: [ allocationDirty := true ]
]

{ #category : 'accessing-individuals' }
RMDFileMemory >> patch: anInteger [
	super patch: anInteger.
	spaceDirty := true
]

{ #category : 'accessing-individuals' }
RMDFileMemory >> patchSize: anInteger [
	super patchSize: anInteger.
	spaceDirty := true
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> randomSeed [

	randomSeed ifNil: [ self readMetaparameters ].
	^ super randomSeed
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readAllocation [

	self writeCritical: [ 
		self allocationFile
			ensureCreateFile;
			readStreamDo: [ :stream | 
				| params |
				params := Dictionary new.
				[ stream atEnd ] whileFalse: [ 
						(stream nextLine trim substrings: ',') ifNotEmpty: [ :pair | 
								pair size = 2 ifTrue: [ 
										params at: pair first put: pair second asInteger ] ] ].
				^ params ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readAnimatsForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) / self animatsFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| vals |
		vals := Dictionary new.
		[ stream atEnd ] whileFalse: [ 
			| len animat ids |
			len := stream uint32.
			animat := (stream next: len) utf8Decoded.
			len := stream uint32.
			ids := Set new: len.
			len timesRepeat: [ ids add: stream uint32 ].
			vals at: animat put: ids ].
		^ vals ]
]

{ #category : 'accessing-creation times' }
RMDFileMemory >> readCreationTimesForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger)
	       / self creationTimesFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream |
		| params |
		params := Dictionary new.
		[ stream atEnd ] whileFalse: [
			params at: stream uint32 put: stream uint32 ].
		^ params ]
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> readMetaparameters [

	| path jsonObject |
	path := self basePath / self metaparameterJsonBasename.
	jsonObject := path isFile
		              ifTrue: [ 
		              path readStreamDo: [ :stream | 
			              STONJSON fromStream: stream ] ]
		              ifFalse: [ Dictionary new ].
	runId := jsonObject at: 'runId' ifAbsent: [ 1 ].
	metaparameters := jsonObject
		                  at: 'metaparameters'
		                  ifPresent: [ :dict | 
			                  (dict associations collect: [ :assoc | 
				                   (RMDPlaceholderNode identifier: assoc key)
				                   -> assoc value asRMDExpression ])
				                  asOrderedDictionary ]
		                  ifAbsent: [ OrderedDictionary new ].
	randomSeed := jsonObject at: 'randomSeed' ifAbsent: [ 1 ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readReproductionLinksForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger)
	       / self reproductionLinksFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| params |
		params := Dictionary new.
		[ stream atEnd ] whileFalse: [ 
			params at: stream uint32 put: stream uint32 ].
		^ params ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readSeedsForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) / self seedsFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| vals |
		vals := Dictionary new.
		[ stream atEnd ] whileFalse: [ 
			vals at: stream uint32 put: stream uint32 ].
		^ vals ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readSpace [
	self spaceFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ]
				whileFalse: [ (stream nextLine trim substrings: ',')
						ifNotEmpty: [ :pair | 
							pair size = 2
								ifTrue: [ params at: pair first put: pair second asInteger ] ] ].
			^ params ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readStageLinksForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger)
	       / self stageLinksFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| params |
		params := Dictionary new.
		[ stream atEnd ] whileFalse: [params at: stream uint32 put: stream uint32].
		^ params ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> readValuesForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) / self valuesFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| vals |
		vals := Dictionary new: stream size // 3.
		[ stream atEnd ] whileFalse: [ 
			| id value |
			id := stream uint32.
			value := ((BoxedFloat64 basicNew: 2)
				          basicAt: 1 put: stream uint32;
				          basicAt: 2 put: stream uint32;
				          yourself) * 1.0.
			vals at: id put: value ].
		^ vals ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> reload [

	self initializeAllocation
]

{ #category : 'allocating' }
RMDFileMemory >> reproduceAnimat: aRMDAnimatDefinitionNode with: anInteger [

	reproductionLinksDirty := true.
	^ super reproduceAnimat: aRMDAnimatDefinitionNode with: anInteger
]

{ #category : 'accessing-storage' }
RMDFileMemory >> reproductionLinksFileBasename [
	^ 'reproductionLinks.raw'
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> runId [

	runId ifNil: [ self readMetaparameters ].
	^ super runId
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> runId: anInteger metaparameters: aDictionary randomSeed: anotherInteger [
	super runId: anInteger metaparameters: aDictionary randomSeed: anotherInteger.
	self writeMetaparameters
]

{ #category : 'accessing-storage' }
RMDFileMemory >> seedsFileBasename [
	^ 'seeds.raw'
]

{ #category : 'accessing-storage' }
RMDFileMemory >> spaceFile [
	^ self basePath / self spaceFileBasename
]

{ #category : 'accessing-storage' }
RMDFileMemory >> spaceFileBasename [
	^ 'space.csv'
]

{ #category : 'allocating' }
RMDFileMemory >> stageAnimat: aRMDAnimatDefinitionNode with: anInteger [

	stageLinksDirty := true.
	^ super stageAnimat: aRMDAnimatDefinitionNode with: anInteger
]

{ #category : 'accessing-storage' }
RMDFileMemory >> stageLinksFileBasename [
	^ 'stageLinks.raw'
]

{ #category : 'accessing-storage' }
RMDFileMemory >> stagesFile [
	^ self basePath / self stagesFileBasename
]

{ #category : 'accessing-storage' }
RMDFileMemory >> stagesFileBasename [
	^ 'stages.csv'
]

{ #category : 'timing' }
RMDFileMemory >> sunset [

	super sunset.
	spaceDirty ifTrue: [ 
		self writeSpace.
		spaceDirty := false ].
	allocationDirty ifTrue: [ 
		self writeAllocation.
		allocationDirty := false ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> valuesFileBasename [
	^ 'values.raw'
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeAllocation [

	self writeCritical: [ 
		self allocationFile writeStreamDo: [ :stream | 
			stream truncate.
			stream nextPutAll: 'latestTime,'.
			latestTime + 1 storeOn: stream.
			stream lf.
			stream nextPutAll: 'nextAvailableSlot,'.
			nextAvailableSlot storeOn: stream.
			stream lf.
			stream nextPutAll: 'world,'.
			world storeOn: stream.
			stream lf.
			stream close ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeAnimats: aDictionary forTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) ensureCreateDirectory
	       / self animatsFileBasename.
	self writeCritical: [ 
		ref binaryWriteStreamDo: [ :stream | 
			stream truncate.
			aDictionary keysAndValuesDo: [ :animat :individuals | 
				| utf8animat |
				utf8animat := animat utf8Encoded.
				stream uint32: utf8animat size.
				stream nextPutAll: utf8animat.
				stream uint32: individuals size.
				individuals do: [ :id | stream uint32: id ] ].
			stream close ] ]
]

{ #category : 'accessing-creation times' }
RMDFileMemory >> writeCreationTimes: aDictionary forTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) ensureCreateDirectory
	       / self creationTimesFileBasename.
	self writeCritical: [
		ref binaryWriteStreamDo: [ :stream |
			stream truncate.
			aDictionary keysAndValuesDo: [ :key :value |
				stream
					uint32: key;
					uint32: value ].
			stream close ] ]
]

{ #category : 'controlling' }
RMDFileMemory >> writeCritical: aBlock [

	(WriteSemaphore ifNil: [ 
		 WriteSemaphore := Semaphore forMutualExclusion
			                   signal;
			                   signal;
			                   signal;
			                   yourself ]) critical: aBlock
]

{ #category : 'accessing-meta parameters' }
RMDFileMemory >> writeMetaparameters [

	| jsonObject |
	jsonObject := Dictionary new
		              at: 'runId' put: (runId ifNil: [ 1 ]);
		              at: 'metaparameters' put: (metaparameters
				               ifNotNil: [ 
					               (metaparameters associations collect: [ :assoc | 
							                assoc key identifier -> assoc value printString ])
						               asOrderedDictionary ]
				               ifNil: [ OrderedDictionary new ]);
		              at: 'randomSeed' put: (randomSeed ifNil: [ 1 ]);
		              yourself.
	[ 
	self basePath ensureCreateDirectory / self metaparameterJsonBasename 
		lfWriteStreamDo: [ :stream | 
			STONJSON put: jsonObject onStreamPretty: stream.
			stream close ] ]
		on: Error
		do: [ :ex | 
			100 milliSecond wait.
			ex retry ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeReproductionLinks: aDictionary forTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) ensureCreateDirectory
	       / self reproductionLinksFileBasename.
	self writeCritical: [ 
		ref binaryWriteStreamDo: [ :stream | 
			stream truncate.
			aDictionary keysAndValuesDo: [ :key :value | 
				stream
					uint32: key;
					uint32: value ].
			stream close ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeSeeds: aDictionary forTime: anInteger [

	self writeCritical: [ 
		(self directoryForTime: anInteger) ensureCreateDirectory
		/ self seedsFileBasename binaryWriteStreamDo: [ :stream | 
			stream truncate.
			aDictionary keysAndValuesDo: [ :animat :seed | 
				stream
					uint32: animat;
					uint32: seed ].
			stream close ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeSpace [

	self writeCritical: [ 
		self spaceFile writeStreamDo: [ :stream | 
			stream truncate.
			stream nextPutAll: 'patch,'.
			patch storeOn: stream.
			stream lf.
			stream nextPutAll: 'xPatches,'.
			xPatches storeOn: stream.
			stream lf.
			stream nextPutAll: 'yPatches,'.
			yPatches storeOn: stream.
			stream lf.
			stream nextPutAll: 'patchSize,'.
			patchSize storeOn: stream.
			stream lf.
			stream close ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeStageLinks: aDictionary forTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) ensureCreateDirectory
	       / self stageLinksFileBasename.
	self writeCritical: [ 
		ref binaryWriteStreamDo: [ :stream | 
			stream truncate.
			aDictionary keysAndValuesDo: [ :key :value | 
				stream
					uint32: key;
					uint32: value ].
			stream close ] ]
]

{ #category : 'accessing-storage' }
RMDFileMemory >> writeValues: aDictionary forTime: anInteger [

	self writeCritical: [ 
		(self directoryForTime: anInteger) ensureCreateDirectory
		/ self valuesFileBasename binaryWriteStreamDo: [ :stream | 
			stream truncate.
			aDictionary keysAndValuesDo: [ :id :value | 
				stream
					uint32: id;
					uint32: (value basicAt: 1);
					uint32: (value basicAt: 2) ].
			stream close ] ]
]

{ #category : 'accessing-individuals' }
RMDFileMemory >> xPatches: anInteger [
	super xPatches: anInteger.
	spaceDirty := true
]

{ #category : 'accessing-individuals' }
RMDFileMemory >> yPatches: anInteger [
	super yPatches: anInteger.
	spaceDirty := true
]
