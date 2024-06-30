'From Cuis7.0 [latest update: #6454] on 29 June 2024 at 8:03:44 pm'!
'Description Enter a work in Elglish or Interlingua and find the corresponding Interlingua r English usage.'!
!provides: 'IA-EN-Dictionary' 1 4!
!requires: 'UI-Entry' 1 44 nil!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDictWindow category: #'IA-EN-Dictionary'!
SystemWindow subclass: #IEDictWindow
	instanceVariableNames: 'entryTextMorph resultMorph promptMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDictWindow class' category: #'IA-EN-Dictionary'!
IEDictWindow class
	instanceVariableNames: ''!

!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: 'searchString searchResult resultIndex'
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDictWindow commentStamp: '<historical>' prior: 0!
GUI for Interlingua <--> English lookup

	IEDictWindow open
!

!IEDict commentStamp: '<historical>' prior: 0!
I embody a specialized Dictionary of Interlingua->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions in an array of two element
	arrays #('interlingua definition' 'English definition').  All definitions which contain a search match
	are returned.

Instance intention
      I am the model of an IEDictWindow


WORKSPACE:

IEDict initialize.

IEDict interlinguaContains: 'provider'.
IEDict interlinguaStarts: 'provider'.
IEDict interlinguaStarts: 'omni'.
IEDict englishContains: 'day'.
IEDict englishStarts: 'day'.

IEDictWindow open. "-> opens a new IEDictWindow"!

!IEDictWindow methodsFor: 'events' stamp: 'KenD 6/29/2024 15:56:47'!
englishContainsClick

	self model searchString: self searchString; englishContainsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'KenD 6/29/2024 15:57:00'!
englishStartsClick

	self model searchString: self searchString; englishStartsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'KenD 6/29/2024 15:56:22'!
interlinguaContainsClick

	self model searchString: self searchString; interlinguaContainsClick
! !

!IEDictWindow methodsFor: 'events' stamp: 'KenD 6/29/2024 15:56:34'!
interlinguaStartsClick

	self model searchString: self searchString; interlinguaStartsClick! !

!IEDictWindow methodsFor: 'events' stamp: 'KenD 6/29/2024 19:58:56'!
searchResultsChanged
	"Display updated search results"
	
	resultMorph updateList ! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/29/2024 19:58:09'!
buildMorphicWindow
	"Build and lay out the window and answer it"
	
		self layoutMorph 
			beColumn; "the default"
			separation: self defaultSeparation;
			layoutSpec: LayoutSpec useAll;
			addMorph: self makeEntryArea;
			addMorph: self makeButtonArea;
			addMorph: self makeResultsArea.
			
		model when: #newSearchResult send: #searchResultsChanged to: self.
		model interlinguaContainsClick. "set initial text -> result"
		
! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/29/2024 15:53:47'!
makeButtonArea
	"Answer a LayoutMorph with our four buttons -- a column of two rows"
	
	|  buttonHeight buttonLayout interlinguaButtonLayout englishButtonLayout buttonArea |
	buttonHeight := self textSizeUnit * 2.
	buttonLayout := LayoutSpec proportionalWidth: 0.3 fixedHeight: buttonHeight.
	
	interlinguaButtonLayout := LayoutMorph newRow. "a row of two buttons"

	interlinguaButtonLayout 
		axisEdgeWeight: #center; 
		separation: 2;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #interlinguaContainsClick  
				label: 'Interlingua Contains')  layoutSpec: buttonLayout;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #interlinguaStartsClick  
				label: 'Interlingua Starts') layoutSpec: buttonLayout.

	englishButtonLayout := LayoutMorph newRow. "a row of two buttons"
									.
	englishButtonLayout 
		axisEdgeWeight: #center; 
		separation: 2;
		addMorph: 
			(PluggableButtonMorph 
				model: self 
				action: #englishContainsClick  
				label: 'English Contains') layoutSpec: buttonLayout;				
		addMorph: 
			(PluggableButtonMorph 
				model: self
				action: #englishStartsClick  
				label: 'English Starts') layoutSpec: buttonLayout.

	buttonArea := LayoutMorph newColumn.
	^ buttonArea 
			layoutSpec: (LayoutSpec proportionalWidth: 1; fixedHeight: 4 * self textSizeUnit);
			addMorph: interlinguaButtonLayout ;
			addMorph: englishButtonLayout ;
			yourself
! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/29/2024 15:37:22'!
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
			
	entryTextMorph := (TextEntryMorph contents: 'salute'). "initial text"
	entryTextMorph 
		crAction: [self interlinguaContainsClick]; "Same action as IA-Contains button"
		layoutSpec: 
			(LayoutSpec proportionalWidth: 0.9).
			
	^ entryLayout 
		separation: self defaultSeparation;
		layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: entryHeigth);
		addMorph: promptMorph;
		addMorph: entryTextMorph;
		axisEdgeWeight: #rowLeft
		yourself! !

!IEDictWindow methodsFor: 'GUI building' stamp: 'KenD 6/29/2024 16:03:49'!
makeResultsArea
	"Answer a LayoutMoph containing the results of the query"
	
	resultMorph := PluggableListMorph
					withModel: model 
					listGetter: #resultAsList
					indexGetter: #resultIndex
					indexSetter: #resultIndex: .
					
	^resultMorph 			mainView: self
				menuGetter: nil
				keystrokeAction: #resultsKey:from: ;
				layoutSpec: (LayoutSpec proportionalWidth: 1.0
										 proportionalHeight: 0.98);  
				color: (Theme current textHighlight);
				yourself! !

!IEDictWindow methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:26:58'!
entryTextMorph

	^entryTextMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:27:14'!
promptMorph

	^ promptMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:27:25'!
resultMorph

	^ resultMorph! !

!IEDictWindow methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:27:35'!
searchString

	^ entryTextMorph contents asString ! !

!IEDictWindow methodsFor: 'geometry' stamp: 'KenD 6/29/2024 16:11:26'!
defaultSeparation
	"Answer the number of pixels between fields/layouts"
	
	^ 5 "pixels"! !

!IEDictWindow methodsFor: 'geometry' stamp: 'KenD 6/29/2024 16:13:10'!
textSizeUnit
	"Answer the scaling factor for sizing; note  method #fontPreferenceChanged"

	^ (Preferences at: #standardListFont) lineSpacing! !

!IEDictWindow class methodsFor: 'instance creation' stamp: 'KenD 6/29/2024 10:43:31'!
open
"
	IEDictWindow open.
"
	^self open: (IEDict new) label: 'Interlingua <--> English'! !

!IEDict methodsFor: 'initialization' stamp: 'KenD 6/29/2024 16:18:11'!
initialize

	super initialize.
	searchString := 'salute'.
	searchResult := #().
	resultIndex  := 0.! !

!IEDict methodsFor: 'ui support' stamp: 'KenD 6/29/2024 16:23:36'!
englishContainsClick
	
	self searchResult:  (IEDict englishContains: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui support' stamp: 'KenD 6/29/2024 16:23:44'!
englishStartsClick
	
	self searchResult:  (IEDict englishStarts: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui support' stamp: 'KenD 6/29/2024 16:23:17'!
interlinguaContainsClick
	
	self searchResult:  (IEDict interlinguaContains: (self searchString)).
	self resultIndex: 0.! !

!IEDict methodsFor: 'ui support' stamp: 'KenD 6/29/2024 16:23:26'!
interlinguaStartsClick
	
	self searchResult:  (IEDict interlinguaStarts: (self searchString)).
	self resultIndex: 0.
! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:24:06'!
resultAsList
	"Answer a list of form 'this <---> that' "
	
	^ self searchResult collect:[ :elt | (elt at: 1) , ' <---> ', (elt at: 2) ]! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 10/15/2016 14:33:12'!
resultIndex

	^ resultIndex ! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 10/15/2016 14:33:30'!
resultIndex: anInteger

	resultIndex := anInteger! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 10/16/2016 13:56:15'!
searchResult

	^ searchResult ! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 10/16/2016 14:17:07'!
searchResult: newResult

	searchResult := newResult.
	self triggerEvent: #newSearchResult ! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:17:23'!
searchString
	
	^ searchString! !

!IEDict methodsFor: 'accessing' stamp: 'KenD 6/29/2024 16:17:34'!
searchString: aRegularExpressionString
	
	searchString := aRegularExpressionString! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/29/2024 10:14:35'!
englishContains: aString
	"Answer all definition pairs which contain aString looking in the English side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]
! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/29/2024 10:14:55'!
englishStarts: aString
	"Answer all definition pairs which starts with aString looking in the English side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]
! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/29/2024 10:10:57'!
interlinguaContains: aString
	"Answer all definition pairs which contain aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]
! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/29/2024 10:14:17'!
interlinguaStarts: aString
	"Answer all definition pairs which starts with aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]
! !

!IEDict class methodsFor: 'class initialization' stamp: 'KenD 6/29/2024 10:01:58'!
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
	] 
! !
IEDict initialize!
