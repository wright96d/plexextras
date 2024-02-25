# Prompt for the folder path
$FolderPath = Read-Host "Enter the folder path where you want to create subfolders for Plex extras"

# Check if the folder path exists
if (-not (Test-Path $FolderPath)) {
    Write-Host "Folder path does not exist: $FolderPath"
    exit
}

# Define an array of subfolder names
$subfolderNames = @("Behind The Scenes", "Deleted Scenes", "Featurettes", "Interviews", "Scenes", "Shorts", "Trailers", "Other")

# Iterate through the array and create subfolders
foreach ($subfolderName in $subfolderNames) {
    $subfolderPath = Join-Path -Path $FolderPath -ChildPath $subfolderName

    # Check if subfolder already exists
    if (-not (Test-Path $subfolderPath)) {
        New-Item -Path $subfolderPath -ItemType Directory
        Write-Host "Created subfolder: $subfolderPath"
    } else {
        Write-Host "Subfolder already exists: $subfolderPath"
    }
}

# Pause and prompt to continue
Write-Host "Subfolders created. Press Enter to delete empty subfolders in $FolderPath..."
$null = Read-Host

# Get a list of subfolders
$subfolders = Get-ChildItem -Path $FolderPath -Directory

# Iterate through the subfolders and delete empty ones
foreach ($subfolder in $subfolders) {
    $subfolderPath = $subfolder.FullName

    # Check if subfolder is empty
    if ((Get-ChildItem -Path $subfolderPath -Force | Measure-Object).Count -eq 0) {
        Remove-Item -Path $subfolderPath -Force -Recurse > $null
    }
}

Write-Host "Empty subfolders in $FolderPath have been deleted."
