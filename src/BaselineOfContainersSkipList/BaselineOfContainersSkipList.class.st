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
			with: [ spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

		spec
			baseline: 'ContainersLinks'
			with: [ spec repository: 'github://massimo-nocentini/Containers-Links:master/src' ].

		spec
			baseline: 'MethodTrackerMN'
			with: [ spec repository: 'github://massimo-nocentini/MethodTracker:master/src' ].

		"Packages"
		spec
			package: 'Containers-SkipList'
			with: [ spec requires: #( 'ContainersEssentials' 'ContainersLinks' ) ];
			package: 'Containers-SkipList-Visualizations'
			with: [ spec requires: #( 'Containers-SkipList' ) ];
			package: 'Containers-SkipList-Tests'
			with: [ spec requires: #( 'Containers-SkipList' 'MethodTrackerMN' ) ] ]
]
