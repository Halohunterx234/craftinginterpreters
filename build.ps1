# Build clox
Write-Host "Building clox..." -ForegroundColor Green
if (!(Test-Path build\release\clox)) { mkdir -Force build\release\clox | Out-Null }
gcc -std=c99 -Wall -Wextra -Werror -Wno-unused-parameter -O3 -flto -c c\*.c
Move-Item *.o build\release\clox\ -Force
gcc -std=c99 -Wall -Wextra -Werror -Wno-unused-parameter -O3 -flto build\release\clox\*.o -o build\clox.exe
Copy-Item build\clox.exe clox.exe -Force

# Build jlox
Write-Host "Building jlox..." -ForegroundColor Green
if (!(Test-Path build\java\com)) { mkdir -Force build\java\com | Out-Null }
javac -cp java -d build\java java\com\craftinginterpreters\tool\*.java
java -cp build\java com.craftinginterpreters.tool.GenerateAst java\com\craftinginterpreters\lox
javac -cp java -d build\java java\com\craftinginterpreters\lox\*.java

Write-Host "Build complete!" -ForegroundColor Green
Write-Host "Run .\clox.exe or .\jlox.ps1 to start the interpreters"