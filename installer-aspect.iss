#define MyAppName "Aspect Multi-Canvas"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Chenzo David"
#define MyAppURL "https://chenzodavid.com"

[Setup]
; Unique AppId for Aspect Multi-Canvas (different from Aitum's installer)
AppId={{4EA636A6-A537-43F7-9AB1-F0961D7FC42F}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={code:GetDirName}
AppendDefaultDirName=no
DefaultGroupName={#MyAppName}
OutputDir=c:\xampp\htdocs\obstools\dist
OutputBaseFilename=AspectMultiCanvas-{#MyAppVersion}-windows-installer
Compression=lzma
SolidCompression=yes
DirExistsWarning=no
AllowNoIcons=yes
WizardStyle=modern
WizardResizable=yes
SetupIconFile="media\icon.ico"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "release\Package\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "LICENSE"; Flags: dontcopy

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Code]
procedure InitializeWizard();
var
  GPLText: AnsiString;
  Page: TOutputMsgMemoWizardPage;
begin
  ExtractTemporaryFile('LICENSE');
  LoadStringFromFile(ExpandConstant('{tmp}\LICENSE'), GPLText);
  Page := CreateOutputMsgMemoPage(wpWelcome,
    'License Information', 'Please review the license terms before installing {#MyAppName}',
    'Aspect Multi-Canvas by Chenzo David (chenzodavid.com), based on Aitum obs-vertical-canvas (GPL). Press Page Down to see the rest of the agreement, then click Next to continue.',
    String(GPLText)
  );
end;

// following function comes from https://github.com/Xaymar/obs-studio_amf-encoder-plugin/blob/master/%23Resources/Installer.in.iss#L45
function GetDirName(Value: string): string;
var
  InstallPath: string;
begin
  Result := ExpandConstant('{pf}\obs-studio');
  if RegQueryStringValue(HKLM32, 'SOFTWARE\OBS Studio', '', InstallPath) then
    Result := InstallPath;
  if RegQueryStringValue(HKLM64, 'SOFTWARE\OBS Studio', '', InstallPath) then
    Result := InstallPath;
end;

function NextButtonClick(PageId: Integer): Boolean;
var
    ObsFileName: string;
    ObsMS, ObsLS: Cardinal;
    ObsMajorVersion, ObsMinorVersion: Cardinal;
begin
    Result := True;
    if not (PageId = wpSelectDir) then begin
        exit;
    end;
    ObsFileName := ExpandConstant('{app}\bin\64bit\obs64.exe');
    if not FileExists(ObsFileName) then begin
        MsgBox('OBS Studio (bin\64bit\obs64.exe) does not seem to be installed in that folder.  Please select the correct folder.', mbError, MB_OK);
        Result := False;
        exit;
    end;
    Result := GetVersionNumbers(ObsFileName, ObsMS, ObsLS);
    if not Result then begin
        MsgBox('Failed to read version from OBS Studio (bin\64bit\obs64.exe).', mbError, MB_OK);
        Result := False;
        exit;
    end;
    ObsMajorVersion := ObsMS shr 16;
    ObsMinorVersion := ObsMS and $FFFF;
    if ObsMajorVersion < 31 then begin
        MsgBox('Your OBS Studio is older than version 31. Please update OBS Studio from obsproject.com first, then run this installer again.', mbError, MB_OK);
        Result := False;
        exit;
    end;
end;
