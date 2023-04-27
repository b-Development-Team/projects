[IMPORT visualTime]

[IMPORT rand] [# thanks pepsi!]

[DEFINE TDTNTOR3 [SPLIT [GLOBAL VAR TDTNTOR3] ";"]]
[DEFINE deathChances [SPLIT [INDEX [VAR TDTNTOR3] 0] "|"]]
[DEFINE lowerBounds [SPLIT [INDEX [VAR TDTNTOR3] 1] "|"]]
[DEFINE upperBounds [SPLIT [INDEX [VAR TDTNTOR3] 2] "|"]]
[DEFINE bestTimes [SPLIT [INDEX [VAR TDTNTOR3] 3] "|"]]
[DEFINE worldRecord [SPLIT [INDEX [VAR TDTNTOR3] 4] "|"]]

[# this will get bigger with time trust me]
[IF [COMPARE [INDEXOF [SPLIT [REPLACE [GLOBAL VAR testSpeedrunProfiles] ";" "|"] "|"] [STR [USERID]]] = -1] [GLOBAL DEFINE testSpeedrunProfiles [CONCAT [INDEX [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"] 0] "|" [USERNAME] ";" [INDEX [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"] 1] "|" [USERID] ";" [INDEX [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"] 2] "|180" [RANDOM 0 1] ";" [INDEX [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"] 3] "|" [TIME] ";" [INDEX [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"] 4] "|" "0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0"]]]
[DEFINE profiles [SPLIT [GLOBAL VAR testSpeedrunProfiles] ";"]]
[DEFINE names [SPLIT [INDEX [VAR profiles] 0] "|"]]
[DEFINE userids [SPLIT [INDEX [VAR profiles] 1] "|"]]
[DEFINE times [SPLIT [INDEX [VAR profiles] 2] "|"]]
[DEFINE unix [SPLIT [INDEX [VAR profiles] 3] "|"]]
[DEFINE settings [SPLIT [INDEX [VAR profiles] 4] "|"]]
[DEFINE location [INDEXOF [VAR userids] [STR [USERID]]]]

[IF [COMPARE [ARGS 0] = ""] [CONCAT 
"**Speedrun v3.1.9**
*Wenyunity causes a catastrophy*
:warning: If you had settings, please reapply them. They got wiped. :warning:

TDTNTOR 3: The Third Creation
1st. " [time [FLOAT [INDEX [VAR worldRecord] 0]]] " by " [INDEX [VAR worldRecord] 1] " (" [timezone [FLOAT [INDEX [VAR worldRecord] 2]] [INT [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1]]] ")

Are you looking for *tc/bstar speedrun help*?"]
[CONCAT [IF [COMPARE [ARGS 0] = "help"] [CONCAT 
"**SPEEDRUN HELP**
tc/bstar speedrun - The main page, which contains version info and all games.
tc/bstar speedrun [game] - The respective game's page, which as of now is just the leaderboard.
tc/bstar speedrun [game] [page #] - Will take you to the respective page number on the leaderboard.
Please note that going to an invalid page will error. I have no intention of fixing that.
tc/bstar speedrun [game] run - This will play out a run of that respective game.
tc/bstar speedrun help - Brings you back to this page.
tc/bstar speedrun settings - Will allow you to customize your settings.
tc/bstar speedrun settings [setting] - Will toggle respective setting.

**KNOWN BUGS**
 -Most 'overall paces' are WR contention. This is incorrect.
 -00.000 is a visualTime relic. It means it was less than 0.0005 seconds. Will not be fixed.
 -timezone says you don't have it on, even when you do. Will be fixed soon.

**COLOR INFORMATION**
```ansi
[1;35mNEW WORLD RECORD[0;0m
[1;34mNew Personal Best[0;0m
[1;32mNew Best Split[0;0m
[1;37m================[0;0m
[1;31mLow Tier Skip[0;0m
[1;33mMedium Tier Skip[0;0m
[1;36mHigh Tier Skip[0;0m
```"]]
[IF [COMPARE [ARGS 0] = "settings"] [CONCAT 
[IF [COMPARE [ARGS 1] = "ping"] [IF [COMPARE [INDEX [INDEX [VAR settings] [VAR location]] 0] = "0"] [CONCAT [DEFINE settings [SETINDEX [VAR settings] [VAR location] [JOIN [SETINDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 0 "1"] "/"]]] "Turned on the ping setting!"] [CONCAT [DEFINE settings [SETINDEX [VAR settings] [VAR location] [JOIN [SETINDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 0 "0"] "/"]]] "Turned off the ping setting!"]]
[IF [COMPARE [ARGS 1] = "timezone"] [IF [COMPARE [ARGS 2] = ""] [CONCAT [DEFINE settings [SETINDEX [VAR settings] [VAR location] [JOIN [SETINDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1 "0"] "/"]]] "Reset your timezone back to UTC."] [CONCAT [DEFINE settings [SETINDEX [VAR settings] [VAR location] [JOIN [SETINDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1 [STR [TRY [INT [ARGS 2]] [INT [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1]]]]] "/"]]] [IF [COMPARE [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1] = [ARGS 2]] [CONCAT "Successfully set your timezone to " [ARGS 2] "!"] "Unable to set timezone."]]]
]] [IF [COMPARE [ARGS 1] = ""] [CONCAT 
"Speedrun Settings\n"
[IF [COMPARE [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 0] = "1"] ":white_check_mark: " ":x: "] "**PING** - This setting will ping you every time a run is completed. (ping)\n"
[IF [COMPARE [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1] =! "0"] ":white_check_mark: " ":x: "] "**TIMEZONE** - This setting will modify your timezone to the one you set. (timezone)\n"
]]]]
[IF [COMPARE [ARGS 0] = "tdtntor3"] [IF [COMPARE [ARGS 1] = "run"] [CONCAT 

[# Game separators "!", variable separators ";", value separators "|", list separators "/"]

[func lowerBoundDeterminer [float number] [block [define ranum [randint 0 6]] [if [compare [var ranum] = 5] [block [define coinflip [randint 0 2]] [if [compare [var coinflip] = 0] [define number [math [var number] - [random [math [var number] / 24] [math [var number] / 20]]]] [define number [math [var number] - [max [array [math [var number] / 24] [abs [pareto 0 [math [var number] / 10] [math [var number] / -2] [math [var number] / 2]]]]]]]]] [if [compare [var ranum] < 3] [define number [math [var number] - [random 0 [math [var number] / 120]]]] [define number [math [var number] - [random [math [var number] / 120] [math [var number] / 24]]]]]] [if [compare [var number] <= 0] [define number 0]] [return [var number]]]]
[func deathChanceDeterminer [array death] [pareto [var death] [math [var death] / 10] [math [var death] / 3] [if [compare [math [var death] * 2] + [var death]] >= 80] 80 [math [var death] * 2]]]

[DEFINE dead 0]
[DEFINE running_time 0]
[DEFINE ansiNumber 0] [# 31 for low tier, 33 for medium tier, 36 for high tier]

[func timeDeterminer [float indexValue] [RANDOM [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]] [FLOAT [INDEX [VAR upperBounds] [VAR indexValue]]]]]
[DEFINE timesList [ARRAY [timeDeterminer 0] [timeDeterminer 1] [timeDeterminer 2] [timeDeterminer 3] [timeDeterminer 4] [timeDeterminer 5] [timeDeterminer 6] [timeDeterminer 7] [timeDeterminer 8] [timeDeterminer 9]]]
[DEFINE displayNames [ARRAY "Chapter One" "Chapter Two" "Trial One" "Chapter Three" "Trial Two" "Chapter Four" "Trial Three" "Chapter Five" "Chapter Six" "Finale"]]
[func timeReducer [float indexValue] [IF [COMPARE [VAR dead] = 0] [IF [COMPARE [RANDOM 0 100] < [FLOAT [INDEX [VAR deathChances] [VAR indexValue]]]] [CONCAT [DEFINE dead 1] [IF [COMPARE [VAR indexValue] = 0] "Sadly, you died in " "\nSadly, you died in "] [INDEX [VAR displayNames] [VAR indexValue]] ".. time to reset the run!\n```"] [CONCAT [DEFINE running_time [MATH [VAR running_time] + [INDEX [VAR timesList] [VAR indexValue]]]] "You completed " [INDEX [VAR displayNames] [VAR indexValue]] " in " [time [INDEX [VAR timesList] [VAR indexValue]]] ". The clock is now at " [time [VAR running_time]] ".\n"]]]] 
[func chunkMaker [ARRAY mode valueIndex multiplier] [BLOCK [DEFINE pacesum 0] [DEFINE antisum 0] [MAP [DEFINE pacesum [+ [VAR pacesum] [FLOAT [VAR map.i]]]] [SLICE [VAR lowerBounds] 0 [MATH [INT [VAR valueIndex]] + 1]]] [MAP [DEFINE antisum [+ [VAR antisum] [FLOAT [VAR map.i]]]] [SLICE [VAR upperBounds] 0 [MATH [INT [VAR valueIndex]] + 1]]] [IF [COMPARE [VAR mode] = 0] [MATH [MATH [MATH [FLOAT [INDEX [VAR upperBounds] [VAR valueIndex]]] - [FLOAT [INDEX [VAR lowerBounds] [VAR valueIndex]]]] * [VAR multiplier]] + [FLOAT [INDEX [VAR lowerBounds] [VAR valueIndex]]]] [MATH [MATH [MATH [VAR antisum] - [VAR pacesum]] * [VAR multiplier]] + [VAR pacesum]]]]]
[func paceMaker [ARRAY mode valueIndex] [IF [COMPARE [IF [COMPARE [VAR mode] = 0] [INDEX [VAR timesList] [VAR valueIndex]] [VAR running_time]] < [chunkMaker [VAR mode] [VAR valueIndex] 0.2]] [RETURN "amazing"] [IF [COMPARE [IF [COMPARE [VAR mode] = 0] [INDEX [VAR timesList] [VAR valueIndex]] [VAR running_time]] < [chunkMaker [VAR mode] [VAR valueIndex] 0.4]] [RETURN "good"] [IF [COMPARE [IF [COMPARE [VAR mode] = 0] [INDEX [VAR timesList] [VAR valueIndex]] [VAR running_time]] < [chunkMaker [VAR mode] [VAR valueIndex] 0.6]] [RETURN "average"] [IF [COMPARE [IF [COMPARE [VAR mode] = 0] [INDEX [VAR timesList] [VAR valueIndex]] [VAR running_time]] < [chunkMaker [VAR mode] [VAR valueIndex] 0.8]] [RETURN "bad"] [IF [COMPARE [IF [COMPARE [VAR mode] = 0] [INDEX [VAR timesList] [VAR valueIndex]] [VAR running_time]] < [chunkMaker [VAR mode] [VAR valueIndex] 1]] [RETURN "terrible"]]]]]]]
[func skipDiscovery [float indexValue] [IF [COMPARE [VAR dead] = 0] [IF [COMPARE [RANDINT 0 101] = 0] [CONCAT [DEFINE newTime [lowerBoundDeterminer [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]]]] [DEFINE newDeath [deathChanceDeterminer [FLOAT [INDEX [VAR deathChances] [VAR indexValue]]]]] [DEFINE divisor [MATH [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]] / [MATH [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]] - [FLOAT [VAR newTime]]]]] [IF [COMPARE [VAR divisor] > 120] [DEFINE ansiNumber 31] [IF [COMPARE [VAR divisor] < 24] [DEFINE ansiNumber 36] [DEFINE ansiNumber 33]]] "[1;" [VAR ansiNumber] "mNew skip discovered in "[INDEX [VAR displayNames] [VAR indexValue]] "![0;" [VAR ansiNumber] "m " "It shaves [1;" [VAR ansiNumber] "m" [time [MATH [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]] - [VAR newTime]]] "[0;" [VAR ansiNumber] "m off the run " [IF [COMPARE [FLOAT [INDEX [VAR deathChances] [VAR indexValue]]] > [VAR newDeath]] "and lowered " "but upped "] "the death chance to [1;" [VAR ansiNumber] "m" [MATH [ROUND [MATH 100 * [VAR newDeath]]] / 100] "%[0;" [VAR ansiNumber] "m.[0;0m\n" [DEFINE lowerBounds [SETINDEX [VAR lowerBounds] [VAR indexValue] [STR [VAR newTime]]] [DEFINE deathChances [SETINDEX [VAR deathChances] [VAR indexValue] [STR [VAR newDeath]]]]]]]]]
[func splitMaker [float indexValue] [IF [COMPARE [VAR dead] = 0] [IF [COMPARE [INDEX [VAR timesList] [VAR indexValue]] < [FLOAT [INDEX [VAR bestTimes] [VAR indexValue]]]] [CONCAT "[1;32mBest " [INDEX [VAR displayNames] [VAR indexValue]] " split ever![0;32m It improved on the time by [1;32m" [time [MATH [FLOAT [INDEX [VAR bestTimes] [VAR indexValue]]] - [INDEX [VAR timesList] [VAR indexValue]]]] "[0;32m.[0;0m\n" [DEFINE bestTimes [SETINDEX [VAR bestTimes] [VAR indexValue] [STR [INDEX [VAR timesList] [VAR indexValue]]]]]]]]]
[func upperBoundDecay [float indexValue] [IF [COMPARE [VAR dead] = 0] [DEFINE upperBounds [SETINDEX [VAR upperBounds] [VAR indexValue] [STR [MATH [MATH [MATH 99 * [FLOAT [INDEX [VAR upperBounds] [VAR indexValue]]]] + [MATH [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]] + [MATH [MATH 1 / 2] * [FLOAT [INDEX [VAR lowerBounds] [VAR indexValue]]]]]] / 100]]]]]]
[func deathChanceDecay [float indexValue] [IF [COMPARE [VAR dead] = 0] [BLOCK [DEFINE deathChances [SETINDEX [VAR deathChances] [VAR indexValue] [STR [STR [MATH [FLOAT [INDEX [VAR deathChances] [VAR indexValue]]] / 1.00075]]]]] [IF [COMPARE [VAR dead] = 1] [DEFINE dead 2]]]]]
[func paceMessage [float indexValue] [IF [COMPARE [VAR dead] = 0] [CONCAT "This pace is " [paceMaker 0 [VAR indexValue]] [IF [COMPARE [VAR indexValue] = 0] ".\n" [CONCAT ", and the overall pace is now " [paceMaker 1 [VAR indexValue]] ".\n"]]]]]

"**[" [IF [COMPARE [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 0] = "1"] [CONCAT "<@!" [USERID] ">"] [USERNAME]] "'s TDTNTOR 3: The Third Creation Run]**\n```ansi\n"
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 0] [paceMessage 0] [skipDiscovery 0] [splitMaker 0] [upperBoundDecay 0] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 0]]]]
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 1] [paceMessage 1] [skipDiscovery 1] [splitMaker 1] [upperBoundDecay 1] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 1]]]]
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 2] [paceMessage 2] [skipDiscovery 2] [splitMaker 2] [upperBoundDecay 2] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 2]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 3] [paceMessage 3] [skipDiscovery 3] [splitMaker 3] [upperBoundDecay 3] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 3]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 4] [paceMessage 4] [skipDiscovery 4] [splitMaker 4] [upperBoundDecay 4] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 4]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 5] [paceMessage 5] [skipDiscovery 5] [splitMaker 5] [upperBoundDecay 5] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 5]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 6] [paceMessage 6] [skipDiscovery 6] [splitMaker 6] [upperBoundDecay 6] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 6]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 7] [paceMessage 7] [skipDiscovery 7] [splitMaker 7] [upperBoundDecay 7] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 7]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 8] [paceMessage 8] [skipDiscovery 8] [splitMaker 8] [upperBoundDecay 8] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 8]]]] 
[IF [COMPARE [VAR dead] = 0] [CONCAT [timeReducer 9] [paceMessage 9] [skipDiscovery 9] [splitMaker 9] [upperBoundDecay 9] [IF [COMPARE [VAR dead] =! 2] [deathChanceDecay 9]]]]
[IF [COMPARE [VAR dead] = 0] [CONCAT "\nYou completed the run in " [time [VAR running_time]] "!" [IF [COMPARE [FLOAT [INDEX [VAR times] [VAR location]]] > [VAR running_time]] [CONCAT [DEFINE names [SETINDEX [VAR names] [VAR location] [USERNAME]]] [DEFINE times [SETINDEX [VAR times] [VAR location] [STR [VAR running_time]]]] [DEFINE unix [SETINDEX [VAR unix] [VAR location] [STR [TIME]]]] "\n[0;34mYou got a new [1;34mPersonal Best[0;34m time of " [time [VAR running_time]] "![0;0m```"] "```"]]]
[IF [COMPARE [VAR dead] = 0] [IF [COMPARE [VAR running_time] < [FLOAT [INDEX [VAR worldRecord] 0]]] [CONCAT "```ansi\n[1;35mNEW WORLD RECORD[0;35m\nPreviously a " [time [FLOAT [INDEX [VAR worldRecord] 0]]] " achieved by " [INDEX [VAR worldRecord] 1] " on " [timezone [FLOAT [INDEX [VAR worldRecord] 2]] [FLOAT [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1]]] ".\nIt is now a " [time [VAR running_time]] " achieved by you, " [USERNAME] ", on " [timezone [TIME] [FLOAT [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1]]] ". Congratulations![0;0m```"]]]
[IF [COMPARE [VAR dead] = 0] [IF [COMPARE [VAR running_time] < [FLOAT [INDEX [VAR worldRecord] 0]]] [BLOCK [DEFINE worldRecord [SETINDEX [VAR worldRecord] 0 [STR [VAR running_time]]]] [DEFINE worldRecord [SETINDEX [VAR worldRecord] 1 [STR [USERNAME]]]] [DEFINE worldRecord [SETINDEX [VAR worldRecord] 2 [STR [TIME]]]] [DEFINE worldRecord [SETINDEX [VAR worldRecord] 3 [STR [USERID]]]]]]]
] [CONCAT 
[DEFINE page [TRY [+ -1 [INT [ARGS 1]]] 0]] 
[DEFINE ftimes [MAP [FLOAT [VAR map.i]] [SPLIT [INDEX [VAR profiles] 2] "|"]]]
[DEFINE ntimes [SLICE [SORT [MAP [FLOAT [VAR map.i]] [VAR ftimes]]] [* [VAR page] 10] [+ 10 [* [VAR page] 10]]]] 
[DEFINE lb [MAP [JOIN [ARRAY [time [VAR map.i]] [INDEX [VAR names] [INDEXOF [VAR ftimes] [VAR map.i]]] [timezone [FLOAT [INDEX [VAR unix] [INDEXOF [VAR ftimes] [VAR map.i]]]] [FLOAT [INDEX [SPLIT [INDEX [VAR settings] [VAR location]] "/"] 1]]]] " :: "] [VAR ntimes]]] 
"```diff\n" 
[CONCAT "+ TDTNTOR3 Speedrun Leaderboard Page "[+ 1 [VAR page]]" +\n"] 

[IF [VAR page] "- " "+ "][JOIN [VAR lb] "
- "] 
"```"]]]]]

[DEFINE names [JOIN [VAR names] "|"]]
[DEFINE userids [JOIN [VAR userids] "|"]]
[DEFINE times [JOIN [VAR times] "|"]]
[DEFINE unix [JOIN [VAR unix] "|"]]
[DEFINE settings [JOIN [VAR settings] "|"]]
[GLOBAL DEFINE testSpeedrunProfiles [JOIN [ARRAY [VAR names] [VAR userids] [VAR times] [VAR unix] [VAR settings]] ";"]]

[DEFINE deathChances [JOIN [VAR deathChances] "|"]]
[DEFINE lowerBounds [JOIN [VAR lowerBounds] "|"]]
[DEFINE upperBounds [JOIN [VAR upperBounds] "|"]]
[DEFINE bestTimes [JOIN [VAR bestTimes] "|"]]
[DEFINE worldRecord [JOIN [VAR worldRecord] "|"]]
[GLOBAL DEFINE TDTNTOR3 [JOIN [ARRAY [VAR deathChances] [VAR lowerBounds] [VAR upperBounds] [VAR bestTimes] [VAR worldRecord]] ";"]]
