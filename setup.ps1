#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Dotfiles = $PSScriptRoot
$KickstartRepo = 'git@github.com:glokta1/kickstart.nvim.git'
$NvimConfig = Join-Path $env:LOCALAPPDATA 'nvim'

function Test-SymlinkPrivilege {
	$target = Join-Path $env:TEMP "symlink-target-$(Get-Random)"
	$link   = Join-Path $env:TEMP "symlink-link-$(Get-Random)"
	New-Item -ItemType File -Path $target -Force | Out-Null
	try {
		New-Item -ItemType SymbolicLink -Path $link -Target $target -ErrorAction Stop | Out-Null
		Remove-Item $link -Force
		return $true
	} catch {
		return $false
	} finally {
		Remove-Item $target -Force -ErrorAction SilentlyContinue
	}
}

if (-not (Test-SymlinkPrivilege)) {
	Write-Error "Cannot create symbolic links. Run as Administrator, or enable Developer Mode (Settings > System > For developers)."
	exit 1
}

if (-not (Test-Path $NvimConfig)) {
	Write-Host "Cloning kickstart.nvim into $NvimConfig..."
	git clone $KickstartRepo $NvimConfig
} else {
	Write-Host "Skipping nvim clone - $NvimConfig already exists"
}

function New-DotLink {
	param([string]$Src, [string]$Dest)
	if (Test-Path $Dest) {
		Write-Host "Skipping $Dest - already exists"
		return
	}
	$parent = Split-Path -Parent $Dest
	if (-not (Test-Path $parent)) {
		New-Item -ItemType Directory -Path $parent -Force | Out-Null
	}
	New-Item -ItemType SymbolicLink -Path $Dest -Target $Src | Out-Null
	Write-Host "Linked $Dest -> $Src"
}

New-DotLink (Join-Path $Dotfiles '.gitconfig') (Join-Path $env:USERPROFILE '.gitconfig')

$apps = [ordered]@{
	'ghostty' = (Join-Path $env:LOCALAPPDATA 'ghostty')
	'mpv'     = (Join-Path $env:APPDATA     'mpv')
	'yt-dlp'  = (Join-Path $env:APPDATA     'yt-dlp')
	'uv'      = (Join-Path $env:APPDATA     'uv')
	'zed'     = (Join-Path $env:APPDATA     'Zed')
}

foreach ($app in $apps.Keys) {
	New-DotLink (Join-Path $Dotfiles $app) $apps[$app]
}
