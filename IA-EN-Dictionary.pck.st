'From Cuis7.5 [latest update: #7262] on 7 June 2025 at 1:08:21 pm'!
'Description Enter a word in English or Interlingua and find the corresponding Interlingua or English usage. '!
!provides: 'IA-EN-Dictionary' 1 2!
!requires: 'UI-Entry' 1 56 nil!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: ''
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!

!classDefinition: #IEDictWindow category: #'IA-EN-Dictionary'!
SystemWindow subclass: #IEDictWindow
	instanceVariableNames: 'textEntryMorph resultMorph promptMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDictWindow class' category: #'IA-EN-Dictionary'!
IEDictWindow class
	instanceVariableNames: ''!


!IEDict commentStamp: '<historical>' prior: 0!
I embody a specialized Dictionary of Interlingua<-->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions 
	in an array of two element arrays #('interlingua definition' 'English definition'). 
	All definitions which contain a search match are returned.

Instance intention
      I am the model of an IEDictWindow
!

!IEDictWindow commentStamp: '<historical>' prior: 0!
GUI for Interlingua <--> English lookup

    IEDictWindow open
!

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:20'!
englishContains: aString
	"Answer all definition pairs which contain aString looking in the English side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:47'!
englishStarts: aString
	"Answer all definition pairs which starts with aString looking in the English side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:21:42'!
interlinguaContains: aString
	"Answer all definition pairs which contain aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:01'!
interlinguaStarts: aString
	"Answer all definition pairs which starts with aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'class initialization' stamp: 'KenD 6/6/2025 14:17:42'!
initialize
	"Read in my data"
"
	IEDict initialize.
"
	| curIndex aLine |
	DictData := Array new: 31034. "We know the exact size (wc -l iedict.txt) less 1"

	(self package fullFileName asFileEntry parent  // 'iedict.txt') readStreamDo: [ :fileStream |
		fileStream nextLine. "Skip initial comment line"
		curIndex := 1.
		aLine := fileStream nextLine. 
		[aLine isNil] whileFalse: [
			DictData at: curIndex 
				  put: ((aLine findBetweenSubStrs: ':') 
						collect: [:str| str withBlanksTrimmed]). 
			aLine := fileStream nextLine. 
			curIndex := 1 + curIndex.
		]
	] ! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/7/2025 12:25:33'!
buildMorphicWindow
	"Build and layout the window and answer it."
	
	^ self layoutMorph
		beColumn; "the default"
		separation: self defaultSeparation;
		layoutSpec: LayoutSpec useAll;
		addMorph: self makeEntryArea;
		addMorph: self makeButtonArea;
		addMorph: self makeResultsArea;
		yourself! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/7/2025 13:01:19'!
makeEntryArea
	"Answer a LayoutMoph containing the prompt and text entry area"
	
	| entryLayout entryHeigth |
	entryHeigth := self defaultSeparation * 2 + self textSizeUnit.
	
	entryLayout := LayoutMorph newRow.
	
	promptMorph := (LabelMorph contents: 'Enter Text: ') 
				emphasis: AbstractFont boldCode; 
				yourself.
	promptMorph  layoutSpec: 
		(LayoutSpec proportionalWidth: 0.3; 
			    fixedWidth: (promptMorph measureContents x)).
	"initial entry area text"			
	textEntryMorph := (TextEntryMorph contents: 'salute').
	textEntryMorph
		"Same action as IA-Contains button"
		crAction: [self interlinguaContainsClick]; 
		layoutSpec: 
			(LayoutSpec proportionalWidth: 0.9).
			
	^ entryLayout 
		separation: self defaultSeparation;
		layoutSpec: (LayoutSpec proportionalWidth: 1
					fixedHeight: entryHeigth);
		addMorph: promptMorph;
		addMorph: textEntryMorph;
		axisEdgeWeight: #rowLeft
		yourself! !

!IEDictWindow class methodsFor: 'instance creation' stamp: 'KenD 6/7/2025 12:05:11'!
open
"
	IEDictWindow open.
"
	^self open: (IEDict new) label: 'Interlingua <--> English'! !
IEDict initialize!
