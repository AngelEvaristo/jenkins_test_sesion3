restore:
	dotnet restore

build:
	dotnet build --configuration Release

test:
	dotnet test --configuration Release--verbosity normal

publish:
	dotnet publish --configuration Release --output publish
