~vk20::
; === Obfuscated Variables ===
a := A_Desktop
b := a . "\" . "TempScript" . ".bat"  ; obfuscated batFile path
c := a . "\" . "DeleteSelf" . ".bat"   ; obfuscated deleteBat path
d := A_ScriptFullPath                  ; obfuscated exeFile

; === Create the main .bat file ===
FileDelete, %b%
FileAppend,
(
@echo off
echo Hello from the obfuscated .bat file!
timeout /t 2 >nul
), %b%

; === Build delete script line by line with variables correctly inserted ===
e := "@echo off`r`n"
e .= "timeout /t 3 >nul`r`n"
e .= "del /f /q """ . d . """`r`n"  ; delete the main script
e .= "del /f /q """ . b . """`r`n"  ; delete the temp .bat file
e .= "del /f /q ""%~f0""`r`n"     ; delete the batch script itself

; === Write the deletion batch file ===
FileDelete, %c%
FileAppend, %e%, %c%

; === Run the deletion script (hidden) ===
Run, %c%, , Hide

; === Exit the current script ===
ExitApp
return
