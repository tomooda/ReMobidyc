Extension { #name : 'RMDMetaInterpreter' }

{ #category : '*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInAttributeTabular [

	^ (RMDAttributeByTimeTabular on: self)
		  open;
		  yourself
]

{ #category : '*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInExperimentarium [

	^ (RMDExperimentarium metaInterpreter: self) open
]

{ #category : '*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInPopulationTabular [

	^ (RMDPopulationByTimeTabular on: self)
		  open;
		  yourself
]

{ #category : '*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInReplayObservatory [

	^ (RMDReplayObservatory metaInterpreter: self)
		  open;
		  yourself
]

{ #category : '*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInSnapshotTabular [

	^ (RMDSnapshotTabular on: self)
		  open;
		  yourself
]
