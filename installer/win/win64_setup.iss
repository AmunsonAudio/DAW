[Setup]
AppName=CoLabs
AppVersion=1.0
WizardStyle=modern
DefaultDirName={autopf}\AmunsonAudio
DefaultGroupName=AmunsonAudio
UninstallDisplayIcon={app}\CoLabs.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=CoLabsSetup_x64
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "..\..\build\CoLabs_artefacts\Release\Standalone\CoLabs.exe"; DestDir: "{app}";
Source: "..\..\build\CoLabs_artefacts\Release\VST3\CoLabs.vst3\Contents\x86_64-win\CoLabs.vst3"; DestDir: "{app}"; Check: InstallVSTFile;

[Icons]
Name: "{group}\CoLabs"; Filename: "{app}\CoLabs.exe"

[Code]
var
  InstallVSTCheckBox: TNewCheckBox;  

procedure InitializeWizard;
var  
  LabelFolder: TLabel;  
  MainPage: TWizardPage;  
begin
  MainPage := CreateCustomPage(wpWelcome, '', '');
  LabelFolder := TLabel.Create(MainPage);
  LabelFolder.Parent := MainPage.Surface;
  LabelFolder.Top := 48;
  LabelFolder.Left := 15;
  LabelFolder.Caption := 'Installer will install standalone version of CoLabs app. Check checkbox below to install in VST3 format.'

  InstallVSTCheckBox := TNewCheckBox.Create(MainPage);
  InstallVSTCheckBox.Parent := MainPage.Surface;
  InstallVSTCheckBox.Top := LabelFolder.Top + LabelFolder.Height + 8;
  InstallVSTCheckBox.Left := LabelFolder.Left;
  InstallVSTCheckBox.Width := LabelFolder.Width;
  InstallVSTCheckBox.Caption := 'Install also in VST3 format';
end;

function InstallVSTFile: Boolean;
begin
  Result := InstallVSTCheckBox.Checked;
end;