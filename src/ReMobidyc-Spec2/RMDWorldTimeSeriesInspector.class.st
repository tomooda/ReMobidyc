Class {
	#name : #RMDWorldTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #enumerating }
RMDWorldTimeSeriesInspector >> speciesDefinitionDo: aBlock [

	aBlock cull: interpreter worldDefinition
]