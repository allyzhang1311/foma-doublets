# Ally Zhang
# CS 4744
# HW2 - Questions 3 and 4 - Stress Doublets

## Source files and reference FSTs
load defined cmu2.fsb
load defined ANV.fsb
define CMUVowels [AA0|AE0|AH0|AO0|AW0|AX0|AXR0|AY0|EH0|ER0|EY0|IH0|IX0|IY0|OW0|OY0|UH0|UW0|UX0|AA1|AE1|AH1|AO1|AW1|AX1|AXR1|AY1|EH1|ER1|EY1|IH1|IX1|IY1|OW1|OY1|UH1|UW1|UX1|AA2|AE2|AH2|AO2|AW2|AX2|AXR2|AY2|EH2|ER2|EY2|IH2|IX2|IY2|OW2|OY2|UH2|UW2|UX2];
define ToUppercase [[a:"A"] | [b:"B"] | [c:"C"] | [d:"D"] | [e:"E"] | [f:"F"] | [g:"G"] | [h:"H"] | [i:"I"] | [j:"J"] | [k:"K"] | [l:"L"] | [m:"M"] | [n:"N"] | [o:"O"] | [p:"P"] | [q:"Q"] | [r:"R"] | [s:"S"] | [t:"T"] | [u:"U"] | [v:"V"] | [w:"W"] | [x:"X"] | [y:"Y"] | [z:"Z"]]+;
define NUppercase N .o. ToUppercase;
define VUppercase V .o. ToUppercase;

# Adds 5 additional doublets to the CMU dictionary.
define NewCMU CMU | [{ENTRANCE} .x. [EH2 "N" T R AE1 "N" S]] |
 [{RELAY} .x. [R IH0 L EY1]] |
 [{AFFECT} .x. AE1 F EH2 K T] |
 [{DISCARD} .x. [D IH1 S K AA2 R D]] |
 [{INTERN} .x. [IH2 "N" T ER1 "N"]];

define LMCMU _lm(NewCMU);

## QUESTION 3
## 3a.
# Relation that maps two-syllable orthographic words into phonetic form.
define TwoSyllableMap NewCMU .o. [$.CMUVowels]^2;

# Isolates the orthographic nouns and verbs that are ambiguous, i.e. map to more than one phonetic form.
define AmbPart _ambpart(NewCMU);
define AmbN AmbPart.u & NUppercase.l;
define AmbV AmbPart.u & VUppercase.l;

# The sets of all ambiguous two-syllable orthographic nouns and verbs. 
define TwoSAmbN TwoSyllableMap.u & AmbN;
define TwoSAmbV TwoSyllableMap.u & AmbV;

# The sets of all ambiguous two-syllable PHONETIC nouns and verbs, converted into a letter machine.
define LMAmbN _lm([TwoSAmbN .o. NewCMU].l);
define LMAmbV _lm([TwoSAmbV .o. NewCMU].l);

# Noun doublets, i.e. ambiguous two-syllable phonetic nouns with initial stress. 
define NDoublet LMAmbN & [$.1 [$.%0 | $.2]];

# Verb doublets, i.e. ambiguous two-syllable phonetic verbs with final stress.
define VDoublet LMAmbV & [[$.%0 | $.2] $.1];

# Converts noun and verb doublets to orthographic form.
define NDoubletOrtho NDoublet .o. LMCMU.i;
define VDoubletOrtho VDoublet .o. LMCMU.i;

# The set of all orthographic doublets.
define OrthographicDoublets NDoubletOrtho.l & VDoubletOrtho.l;

# Maps all orthographic doublets to phonetic form.
define Doublets OrthographicDoublets .o. NewCMU;

## 3b.
# See regex NewCMU, listed at the beginning of the file under Source Files.

## 3c.
# Most doublets are clearly semantically related. In these cases, the noun form's reference is usually the set of things that do or are done by the action of the verb form. Their stress pattern and semantic variation is predictable based on certain prefixes and bound suffixes. 
# The doublets will also have the same etymological source.
# For example, EXPLOIT, MISMATCH, AFFIX, IMPACT, OBJECT.
# A few doublets, however, have no semantic relation and different etymological sources. They have the same orthographic form by coincidence.
# These include ENTRANCE, BUFFET.
# As an aside, nearly all of the doublets I found were of Romance or Latin origin. Only a small number were French loanwords (CHAUFFEUR, DEBUT) or inherited from Middle English (UPSET, OFFSET). I'm not sure why this is, but it's interesting!

## QUESTION 4

# Mapping orthographic form of certain doublets to underlying phonetic form (noun form).
define UForm [[COMBAT .x. [K AA1 M B AE0 T]] |
 [COMBINE .x. [K AA1 M B AY0 "N"]] |
 [CONCERT .x. [K AA1 "N" S ER0 T]] |
 [CONCRETE .x. [K AA1 "N" K R IY0 T]] | 
 [CONDUCT .x. [K AA1 "N" D AH0 KT]] |
 [CONFLICT .x. [K AA1 "N" F L IH0 K T]] | 
 [COMMUNE .x. [K AA1 M Y UW0 "N"]] |
 [COMPACT .x. [K AA1 M P AE0 K T]] |
 [COMPOUND .x. [K AA1 M P AW0 "N" D]] |
 [COMPRESS .x. [K AA1 M P R EH0 S]] |
 [CONSOLE .x. [K AA1 "N" S OW0 L]] |
 [CONSCRIPT .x. [K AA1 "N" S K R IH2 P T]] |
 [CONSTRUCT .x. [K AA1 "N" S T R AH0 K T]] |
 [CONTENT .x. [K AA1 "N" T EH0 "N" T]] |
 [CONTEST .x. [K AA1 "N" T EH0 S T]] |
 [CONTRACT .x. [K AA1 "N" T R AE2 K T]] |
 [CONTRAST .x. [K AA1 "N" T R AE2 S T]] |
 [CONVERT .x. [K AA1 "N" "V" ER0 T]] |
 [CONVERSE .x. [K AA1 "N" "V" ER0 S]] |
 [CONVICT .x. [K AA1 "N" "V" IH0 K T]] |
 [IMPACT .x. [IH1 M P AE0 K T]] |
 [IMPORT .x. [IH1 M P AO0 R T]] |
 [IMPRINT .x. [IH1 M P R IH0 "N" T]] |
 [IMPRESS .x. [IH1 M P R EH2 S]] |
 [INCENSE .x. [IH1 "N" S EH2 "N" S]] |
 [INCREASE .x. [IH1 "N" K R IY2 S]] |
 [INCLINE .x. [IH1 "N" K L AY0 "N"]] |
 [INTERN .x. [IH1 "N" T ER2 "N"]] |
 [INSULT .x. [IH1 "N" S AH2 L T]] |
 [INSERT .x. [IH1 "N" S ER2 T]] |
 [INTRIGUE .x. [IH1 "N" T R IY0 G]] |
 [ABSTRACT .x. [AE1 B S T R AE2 K T]] |
 [ACCENT .x. [AE1 K S EH2 "N" T]] |
 [ADDICT .x. [AE1 D IH2 K T]] |
 [ADDRESS .x. [AE1 D R EH2 S]] |
 [AFFECT .x. [AE1 F EH2 K T]] |
 [AFFIX .x. [AE1 F IH0 K S]] |
 [ANNEX .x. [AE1 "N" EH2 K S]] |
 [ALLY .x. [AE1 L AY0]] |
 [RECESS .x. [R IY1 S EH0 S]] |
 [RECAP .x. [R IY1 K AE2 P]] |
 [RECALL .x. [R IY1 K AO2 L]] |
 [REDRESS .x. [R IY1 D R EH0 S]] |
 [REFILL .x. [R IY1 F IH0 L]] |
 [REFUND .x. [R IY1 F AH2 "N" D]] |
 [REJECT .x. [R IY1 JH EH0 K T]] |
 [FERMENT .x. [F ER1 M EH0 "N" T]] |
 [TORMENT .x. [T AO1 R M EH2 "N" T]] |
 [DICTATE .x. [D IH1 K T EY2 T]] |
 [DISCOUNT .x. [D IH1 S K AW0 "N" T]] |
 [DIGEST .x. [D AY1 JH EH0 S T]] |
 [DEBUT .x. [D EY1 B Y UW0]]];

# Defines lexical categories.
define Category NOUN | VERB;

# Defines orthographic form and category of the given doublets.
define Phrase _lm(UForm.u "+" Category);

# Maps an orthographic Phrase into phonetic form (preserving the category) and converts it to a letter machine.
define UPhrase [UForm | "+" Category]+;
define LMUPhrase _lm(UPhrase);

## PHONOLOGY - Note: all the rules below apply for verbs only.

# The destressing rules reduce the initial vowel of each sequence to an unstressed vowel.
# Words beginning with C 
define CDestressInitial [{AA1} -> {AH0} ||.#.K _ ?* {+VERB}];
# Words beginning with A
define ADestressInitial [{AE1} -> {AH0} ||.#._ ?* {+VERB}];
# Words beginning with RE
define RDestressInitial [{IY1} -> {IH0} ||.#.R_ ?* {+VERB}];
# Other contexts
define GenDestressInitial ["1" -> "0" || .#.{IH}_ ?* {+VERB}, .#.[{DIH}|{DAY}|{DEY}] _ ?* {+VERB},.#.?^3 _ ?* {NT+VERB}];
# Combined destressing rule
define AllDestress CDestressInitial .o. ADestressInitial .o. RDestressInitial .o. GenDestressInitial;

# Stresses the final vowel of each sequence. (This FST as written actually stresses every vowel, but in the final mapping I apply it before the destressing rule.)
define StressFinal [["0"|"2"] -> "1" || _ ?* {+VERB}];

# Deletes lexical category marker.
define MarkerDeletion [[{+NOUN} | {+VERB}] -> 0];

# Maps an orthographic noun or verb doublet into phonetic form
define DoubletPhon Phrase .o. LMUPhrase .o. StressFinal .o. AllDestress .o.  MarkerDeletion;
