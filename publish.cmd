@echo off
SET srcDir=%cd%
set dstx=C:\Data\Work\git\blazor-pages-gh-pages-xx\%RANDOM%


FOR /F "tokens=* USEBACKQ" %%F IN (`git rev-parse HEAD`) DO (
SET master-sha=%%F
)


set dst=%dstx%\publish
set dsttmp=%dstx%\temp
set dst2=%dst%\Client\dist
md %dst2%
md %dsttmp%
git clone --separate-git-dir=%dst2%\.git  -l -b gh-pages . %dsttmp% 
dotnet  publish -c Release -o %dst%
git --git-dir=%dst2%\.git --work-tree=%dst2% add . -u -f 
git --git-dir=%dst2%\.git --work-tree=%dst2% status
git --git-dir=%dst2%\.git --work-tree=%dst2% commit -m "Built %master-sha%"
git --git-dir=%dst2%\.git --work-tree=%dst2% push origin gh-pages:gh-pages

rd /s /q %dstx%

gitk HEAD gh-pages

