Class {
	#name : #BaselineOfContainersSkipList,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersSkipList
}

{ #category : #baselines }
BaselineOfContainersSkipList >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals."
		spec
			baseline: 'ContainersEssentials'
			with: [ 
			spec repository: 'github://massimo-nocentini/Containers-Essentials' ].

		"Packages"
		spec
			package: 'Containers-SkipList';
			package: 'Containers-SkipList-Tests' ]
]
