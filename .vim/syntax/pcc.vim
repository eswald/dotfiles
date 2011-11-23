" Vim syntax file
" Language:     Planets Command Center 1.0.18
" Maintainer:   Eric Wald <breadman@sourceforge.net>
" Last change:  01-Apr-2005

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" if version < 600
  syntax clear
" elseif exists("b:current_syntax")
"   finish
" endif

syn case ignore

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pcc_syntax_inits")
  if version < 508
    let did_pcc_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " Comment out the first line if it causes problems.  The second is essential.
  setlocal iskeyword=a-z,A-Z,48-57,_
  setlocal iskeyword+=.,$
  
  " First, to let others override specific words
" Sub <name> [(<args>)] ... EndSub
syn match   pccUserRoutine	/\<\a\k\+\>/
  HiLink    pccStarshipRoutine	pccLibraryRoutine
  HiLink    pccPlanetRoutine	pccLibraryRoutine
  HiLink    pccPlanetRoutine	pccLibraryRoutine
  HiLink    pccGlobalRoutine	pccLibraryRoutine
  HiLink    pccLibraryRoutine	pccSubroutine
  HiLink    pccUserRoutine	pccSubroutine
  HiLink    pccSubroutine	Identifier
  
" 	*Comment	any comment
syn region  pccComment		start=/%/ end=/$/ contains=pccTodo
  HiLink    pccComment		Comment

" 	*Constant	any constant
" 	 String		a string constant: "this is a string"
syn region  pccSingleString	start=/'/ end=/'/
syn region  pccDoubleString	start=/"/ end=/"/ skip=/\\\\\|\\"/ contains=pccStringBackslash
syn match   pccOptionString	/\(['"]\)\a\+\1/ contained
  HiLink    pccSingleString	String
  HiLink    pccDoubleString	String
  HiLink    pccOptionString	String
  
" 	 Number		a number constant: 234, 0xff
" 	 Float		a floating point constant: 2.3e10
syn match   pccInteger		/\<\d\+\>/
syn match   pccFloat		/\<\d\+\.\d*\>/
syn match   pccFloat		/\.\d\+\>/
syn match   pccFloat		/\<pi\>/
syn match   pccNumber		/\<\%(\d+\.\?\d*\|pi\)\>/ contained contains=pccInteger,pccFloat
  HiLink    pccInteger		Number
  HiLink    pccFloat		loat

" 	 Boolean	a boolean constant: TRUE, false
syn keyword pccBoolean		true false
  HiLink    pccBoolean  	Boolean
  
" 	*Identifier	any variable name
syn keyword pccGlobalVariable	Build.Remainder Cargo.Remainder
syn keyword pccGlobalVariable	UI.Directory UI.Prefix UI.Result
syn match   pccLetterVariable	/\<\a\>/
  HiLink    pccLetterVariable	pccGlobalVariable
  HiLink    pccGlobalVariable	Identifier
  
" 	 Function	function name (also: methods for classes)
syn keyword pccBuiltinFunction	contained Asc Atom AtomStr Chr[$] CountPlanets CountShips
syn keyword pccBuiltinFunction	FindPlanet FindShip If IsEmpty IsNum IsString
syn keyword pccBuiltinFunction	PlanetAt PlanetName ShipName Str TrueHull Val Z Zap
syn match   pccCfgFunctionOne	/Cfg(\(['"]\)\a\+\1)/ contains=pccOptionString,pccConfigOption
syn region  pccCfgFunctionTwo	oneline start=/Cfg(\(['"]\)\a\+\1,/ end=/)/ contains=pccCfgFunction,pccOptionString,pccPerPlayerCfg,pccNumberExpression
syn keyword pccCfgFunction	Cfg contained

syn match   pccNumberExpression	/.*/ transparent contained contains=pccNumberFunction,pccNumber
syn match   pccExpression	/.*/ transparent contained contains=pccNumberExpression,pccStringExpression
syn match   pccLastArgument	/.*)/ transparent contained
syn match   pccTwoArguments	/.*,/ transparent contained contains=pccExpression skipwhite nextgroup=pccLastArgument
syn match   pccThreeArguments	/.*,/ transparent contained contains=pccExpression skipwhite nextgroup=pccTwoArguments
syn match   pccFourArguments	/.*,/ transparent contained contains=pccExpression skipwhite nextgroup=pccThreeArguments
syn match   pccFiveArguments	/.*,/ transparent contained contains=pccExpression skipwhite nextgroup=pccFourArguments
syn match   pccSixArguments	/.*,/ transparent contained contains=pccExpression skipwhite nextgroup=pccFiveArguments

syn keyword pccCargoFunction	contained CAdd CCompare CExtract CMul CRemove CSub
syn keyword pccFileIOFunction	contained FPos FreeFile FSize GetByte GetWord GetLong GetStr
syn keyword pccMathFunction	contained Abs ATan Cos Distance Int Max Min Random Sin Sqr[t] Tan
syn keyword pccStringFunction	contained First InStr Left Len Mid Rest Right StrCase String Trim LTrim RTrim

  HiLink    pccBuiltinFunction	pccFunction
  HiLink    pccFileIOFunction	pccBuiltinFunction
  HiLink    pccCfgFunction	pccBuiltinFunction
  HiLink    pccStringFunction	pccBuiltinFunction
  HiLink    pccMathFunction	pccBuiltinFunction
  HiLink    pccCargoFunction	pccStringFunction
  HiLink    pccFunction 	Function
  
" 	*Statement	any statement
" 	 Conditional	if, then, else, endif, switch, etc.
syn keyword pccConditional	If Then Else EndIf
  HiLink    pccConditional	Conditional
  
" 	 Repeat		for, do, while, etc.
syn keyword pccLoopCommand	Break Continue Do Loop While Until For To Next Foreach
  HiLink    pccLoopCommand	Repeat
  
" 	 Label		case, default, etc.
" 	 Operator	"sizeof", "+", "*", etc.
syn match   pccCompOperator	/[<>=]\|[<>]=\|<>/
syn match   pccUnaryOperator	/[-+]\|\<not\>/
syn match   pccBinaryOperator	/[-+*^/\\&#;]/
syn match   pccBinaryOperator	/\<\%(mod\|and\|or\|xor\)\>/
syn match   pccAssignOperator	/:\?=/
  HiLink    pccCompOperator	Operator
  HiLink    pccUnaryOperator	Operator
  HiLink    pccBinaryOperator	Operator
  HiLink    pccAssignOperator	Operator

" 	 Keyword	any other keyword
" On Load Do ...
syn keyword pccEventHook	Load Exit Quit BeforeLoad
  HiLink    pccEventHook	Keyword
  
syn keyword pccCoreCommand	Abort Bind CreateKeymap CreateShipProperty CreatePlanetProperty
syn keyword pccCoreCommand	Dim End Eval Load Print Return RunHook SaveGame Stop
syn keyword pccGlobalCommand	NewCircle NewLine NewMarker NewRectangle SelectionExec
syn keyword pccInterfaceCommand	MessageBox UI.FileWindow UI.GotoChart UI.GotoScreen
syn keyword pccInterfaceCommand	UI.Help UI.Input UI.InputFCode UI.Message UI.Update
syn keyword pccFileIOCommand	Close Get Input Open For As Put Seek SetByte SetWord SetLong SetStr
syn keyword pccPlanetCommand	Autobuild BuildDefense BuildFactories BuildMines
syn keyword pccPlanetCommand	BuildBase BuildBaseDefense BuildShip FixShip RecycleShip
syn keyword pccPlanetCommand	CargoTransfer Mark SetColonistTax SetNativeTax
syn keyword pccPlanetCommand	SetComment SetFCode SetMission Unmark
syn keyword pccStarshipCommand	CargoTransfer CargoUnload CargoUpload FixShip Mark
syn keyword pccStarshipCommand	RecycleShip SetComment SetEnemy SetFCode SetFleet
syn keyword pccStarshipCommand	SetMission SetName SetSpeed SetWaypoint Unmark
syn keyword pccMinefieldCommand	Delete
syn keyword pccMarkerCommand	Delete SetColor SetComment
  HiLink    pccMarkerCommand	pccCommand
  HiLink    pccMinefieldCommand	pccCommand
  HiLink    pccStarshipCommand	pccCommand
  HiLink    pccPlanetCommand	pccCommand
  HiLink    pccFileIOCommand	pccCommand
  HiLink    pccGlobalCommand	pccCommand
  HiLink    pccInterfaceCommand	pccCommand
  HiLink    pccCoreCommand	pccCommand
  HiLink    pccCoreCommand	pccCommand
  HiLink    pccCommand		Keyword

syn keyword pccGlobalRoutine	ChangeFleetLeader Notify SelectionLayer WaitOneTurn
syn keyword pccPlanetRoutine	BuildDefenseWait BuildFactoriesWait BuildMinesWait
syn keyword pccPlanetRoutine	BuildBaseDefenseWait CargoTransferWait EnqueueShip
syn keyword pccPlanetRoutine	FixShipWait RecycleShipWait
syn keyword pccStarshipRoutine	CargoTransferWait FixShipWait MoveTo RecycleShipWait SetFleetName

syn keyword pccGlobalProperty	Chart.X Chart.Y Selection.Layer
syn keyword pccGlobalProperty	My.Bases My.InMsgs My.OutMsgs My.PBPs My.Planets
syn keyword pccGlobalProperty	My.Race[$] My.Race.Adj My.Race.Full My.Race.Id
syn keyword pccGlobalProperty	My.Ships My.Ships.Capital My.Ships.Freighters
syn keyword pccGlobalProperty	My.Score My.Team My.VCRs
syn keyword pccGlobalProperty	Ships.Capital Ships.Freighters Ships.Total
syn keyword pccGlobalProperty	System.Err System.GameDirectory System.GameType
syn keyword pccGlobalProperty	System.GUI System.Host[$] System.HostVersion System.Local
syn keyword pccGlobalProperty	System.Program System.RegStr1 System.RegStr2 System.Remote
syn keyword pccGlobalProperty	System.RootDirectory System.Sim System.Version[$]
syn keyword pccGlobalProperty	Turn Turn.Date Turn.Time
syn keyword pccGlobalProperty	UI.Screen UI.X UI.Y
  HiLink    pccGlobalProperty	Keyword

syn keyword pccPlanetProperty	Base Base.YesNo Comment
syn keyword pccPlanetProperty	Colonists Colonists.Change[$] Colonists.Happy[$] Colonists.Tax
syn keyword pccPlanetProperty	Defense Defense.Base.Want Defense.Max Defense.Want
syn keyword pccPlanetProperty	Density.D Density.M Density.N Density.T
syn keyword pccPlanetProperty	Factories Factories.Max Factories.Want Industry[$]
syn keyword pccPlanetProperty	Ground.D Ground.M Ground.N Ground.T
syn keyword pccPlanetProperty	ID FCode Loc.X Loc.Y Marked
syn keyword pccPlanetProperty	Mined.D Mined.M Mined.N Mined.T Mined.Str
syn keyword pccPlanetProperty	Mines Mines.Max Mines.Want Money Supplies
syn keyword pccPlanetProperty	Natives Natives.Change[$] Natives.Happy[$] Natives.Tax
syn keyword pccPlanetProperty	Name Natives.Gov[$] Natives.Race[$] Temp[$]
syn keyword pccPlanetProperty	Orbit Orbit.Enemy Orbit.Own Owner[$] Owner.Adj
  HiLink    pccPlanetProperty	Keyword

syn keyword pccStarbaseProperty	Build Build.Beam$ Build.Beam.Count Build.Engine$
syn keyword pccStarbaseProperty	Build.Hull$ Build.Short Build.Torp Build.Torp.Count
syn keyword pccStarbaseProperty	Build.YesNo Damage Defense.Base Fighters Mission[$]
syn keyword pccStarbaseProperty	Shipyard Shipyard.Action Shipyard.Id Shipyard.Name
syn keyword pccStarbaseProperty	Tech.Beam Tech.Engine Tech.Hull Tech.Torpedo
syn match   pccStarbaseStorage	/\<Storage\.\(Ammo\|Engines\|Hulls\|Launchers\)(.+)/
  HiLink    pccStarbaseStorage	pccStarbaseProperty
  HiLink    pccStarbaseProperty	Keyword

" 	 Exception	try, catch, throw
syn keyword pccException	Try Else EndTry TryLoad
  HiLink    pccException	Exception

" 	*PreProc	generic Preprocessor
syn keyword pccTHostBool	contained AllowAdvancedRefinery AllowAlchemy AllowAntiCloakShips AllowBioscanners AllowBoardingParties AllowChunneling AllowCloakedShipsAttack AllowColoniesSweepWebs AllowDeluxeSuperSpy AllowEatingSupplies AllowEngineShieldBonus AllowFedCombatBonus AllowGamblingShips AllowGloryDevice AllowGravityWells AllowHiss AllowHyperwarps AllowImperialAssault AllowMeteorMessages AllowMineFields AllowMinesDestroyMines AllowMinesDestroyWebs AllowNewNatives AllowNoFuelMovement AllowOneEngineTowing AllowPlanetAttacks AllowRebelGroundAttack AllowScienceMissions AllowShipCloning AllowSuperRefit AllowVPAFeatures AllowWebMines ClimateLimitsPopulation ColoniesBuildFighters CrystalsPreferDeserts DeleteOldMessages DisablePasswords IonStormsHideMines LokiDecloaksBird PlanetsAttackKlingons PlanetsAttackRebels RebelsBuildFighters RobCloakedShips RobotsBuildFighters
syn keyword pccTHostInt 	contained BorgAssimilationRate ClimateDeathRate CloakFailureRate CloakFuelBurn DamageLevelForCloakFail DarkSenseRange EngineShieldBonusRate HissEffectRate HullTechNotSlowedByMines IonStormActivity MaximumMineFieldRadius MineDecayRate MineHitOdds MineHitOddsWhenCloakedX10 MineScanRange MineSweepRange MineSweepRate RamscoopFuelPerLY RandomMeteorRate RecycleRate RobFailureOdds ScanRange SensorRange StructureDecayPerTurn TransuraniumDecayRate WebMineDecayRate WebMineHitOdds WebMineSweepRange WebMineSweepRate
syn keyword pccTHostInt2	contained ColonistTaxRate FreeFighters GroundDefenseFactor GroundKillFactor RaceMiningRate
syn keyword pccTHostLong	contained MaxPlanetaryIncome
syn keyword pccPHostBool	contained AllowBeamUpMultiple AllowESBonusAgainstPlanets AllowExtendedMissions AllowPlayerMessages AllowRegisteredFunctions AllowWraparoundMap CPEnableAllies CPEnableBigTargets CPEnableGive CPEnableLanguage CPEnableRaceName CPEnableRemote CPEnableRumor CPEnableSend DelayAllianceCommands MapTruehullByPlayerRace RoundGravityWells UseAccurateFuelModel
syn keyword pccPHostBool2	contained AllowAlternativeCombat FireOnAttackFighters PlanetsHaveTubes
syn keyword pccPHostInt 	contained CrystalSinTempBehavior DefenseForUndetectable ExtMissionsStartAt FactoriesForDetectable GravityWellRange MaxColTempSlope MaxShipsHissing MinesForDetectable PlanetaryTorpsPerTube TerraFormRate WormholeUfosStartAt WrmEntryPowerX100
syn keyword pccPHostInt2	contained BayLaunchInterval BayRechargeBonus BayRechargeRate BeamHitBonus BeamHitFighterCharge BeamHitOdds BeamHitShipCharge BeamRechargeBonus BeamRechargeRate CrewKillScaling ExtraFighterBays FighterBeamExplosive FighterBeamKill FighterFiringRange FighterKillOdds FighterMovementSpeed HullDamageScaling MaxFightersLaunched NativeTaxRate PlayerRace ProductionRate ShieldDamageScaling ShipCloneCostRate ShipMovementSpeed StrikesPerFighter TorpHitBonus TorpHitOdds TubeRechargeBonus TubeRechargeRate UnitsPerTorpRate WraparoundRectangle
syn keyword pccPHostLong2	contained BeamFiringRange BeamHitFighterRange StandoffDistance TorpFiringRange
syn match   pccConfigOption	/\<\a\+\>/ contained contains=pccGlobalCfg,pccPerPlayerCfg
syn match   pccPerPlayerCfg	/\<\a\+\>/ contained contains=pccTHostPerPlayer,pccPHostPerPlayer
syn match   pccGlobalCfg	/\<\a\+\>/ contained contains=pccTHostGlobal,pccPHostGlobal
syn match   pccTHostGlobal	/\<\a\+\>/ contained contains=pccTHostBool,pccTHostInt,pccTHostLong

  HiLink    pccConfigOption	PreProc
  HiLink    pccGlobalCfg 	pccConfigOption
  HiLink    pccPerPlayerCfg 	pccConfigOption
  HiLink    pccTHostGlobal 	pccGlobalConfig
  HiLink    pccTHostPerPlayer 	pccGlobalConfig
  HiLink    pccPHostGlobal 	pccGlobalConfig
  HiLink    pccPHostPerPlayer 	pccGlobalConfig
  HiLink    pccTHostBool 	pccTHostGlobal
  HiLink    pccTHostInt 	pccTHostGlobal
  HiLink    pccTHostLong 	pccTHostGlobal
  HiLink    pccTHostBool2	pccTHostPerPlayer
  HiLink    pccTHostInt2	pccTHostPerPlayer
  HiLink    pccTHostLong2	pccTHostPerPlayer
  HiLink    pccPHostBool 	pccPHostGlobal
  HiLink    pccPHostInt 	pccPHostGlobal
  HiLink    pccPHostLong 	pccPHostGlobal
  HiLink    pccPHostBool2	pccPHostPerPlayer
  HiLink    pccPHostInt2	pccPHostPerPlayer
  HiLink    pccPHostLong2	pccPHostPerPlayer

" 	 Include	preprocessor #include
" 	 Define		preprocessor #define
" 	 Macro		same as Define
" 	 PreCondit	preprocessor #if, #else, #endif, etc.
" 
" 	*Type		int, long, char, etc.
" 	 StorageClass	static, register, volatile, etc.
syn keyword pccStorageClass	Static Shared Local
  HiLink    pccStorageClass	StorageClass
  
" 	 Structure	struct, union, enum, etc.
syn match   pccFileHandle	/#\d\+\|#\k\+/
  HiLink    pccFileHandle	Structure

" 	 Typedef	A typedef
" Either With Beams(3) Do ... or Beams(3).Cost or Beams.cost
syn keyword pccContext		Beam[s] Engine[s] Hull[s] Launcher[s] Minefield[s]
syn keyword pccContext		Planet[s] Player[s] Ship[s] Storm[s] Torpedo Torpedoes
  HiLink    pccContext		Type

" 	*Special	any special symbol
syn match   pccCargoString	/\(['"]\) *\%(\d\+[ntdm$scfw]\+ *\)\+\1/
  HiLink    pccCargoString	SpecialString
  HiLink    SpecialString	Special
  
syn match   pccKeymapString	/\(['"]\)\%(\%(a\|alt\|c\|ctrl\|s\|shift\)-\)\?f\%(\d\|11\|12\)\1/
syn match   pccKeymapString	/\(['"]\)\%(\%(a\|alt\|c\|ctrl\)-\)\?\%(home\|end\|ins\|del\|pgup\|pgdn\|ins\|del\|up\|down\|left\|right\|\a\|bs\|backspace\|ret\|enter\|num\*\|num+\|num-\|num\/\)\1/
syn match   pccKeymapString	/\(['"]\)\%(\%(c\%(trl\)-\)\?a\%(lt\)\?-\)\?\d\1/
syn match   pccKeymapString	/\(['"]\)\%(a\%(lt\)\?-\)\?\%(esc\|[',\-.\/;=\[\\\]`]\)\1/
syn match   pccKeymapString	/\(['"]\)\%(c\%(trl\)\?-\)\?\%(spc\|space\|num5\)\1/
syn match   pccKeymapString	/\(['"]\)a\%(lt\)\?-\%(numret\|lfd\)\1/
syn match   pccKeymapString	/\(['"]\)\%(\%(a\|alt\|c\|ctrl\|s\|shift\)-\)\?\%(tab\|[!@#$%^&*()_+{}|"~]\)\1/
" The manual indicates ctrl-alt-- and ctrl-print?
  HiLink    pccKeymapString	SpecialString

" 	 SpecialChar	special character in a constant
syn match   pccStringBackslash  /\\"\|\\\\/ extend contained contains=NONE
  HiLink    pccStringBackslash	SpecialChar
  
" 	 Tag		you can use CTRL-] on this
" 	 Delimiter	character that needs attention
" 	 SpecialComment	special things inside a comment
" 	 Debug		debugging statements
" 
" 	*Underlined	text that stands out, HTML links
" 
" 	*Error		any erroneous construct
syn keyword pccEmpty		empty
syn match   pccMissingOperand	/\<\d+\K\k*/ contains=NONE
syn match   pccDecimalError	/\<\d*\.\d*\.\d*\>/ contains=NONE
  HiLink    pccEmpty		pccError
  HiLink    pccDecimalError	pccError
  HiLink    pccMissingOperand	pccError
  HiLink    pccError		Error

" 	*Todo		anything that needs extra attention; mostly the
" 			keywords TODO FIXME and XXX
syn keyword pccTodo contained	todo fixme
  HiLink    pccTodo		Todo

  delcommand HiLink
endif

let b:current_syntax = "pcc"
" vim: ts=8 sw=2 noexpandtab
