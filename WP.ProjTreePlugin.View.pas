unit WP.ProjTreePlugin.View;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, RzShellDialogs,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.Buttons;

type
  TMainFrame = class(TFrame)
    pnlTop: TPanel;
    tvProjectTree: TTreeView;
    btnProjPath: TSpeedButton;
    vimgProjTree: TVirtualImageList;
    dlgRzSelectFolder: TRzSelectFolderDialog;
    lblProjFolder: TLabel;
    procedure btnProjPathClick(Sender: TObject);
    procedure tvProjectTreeDblClick(Sender: TObject);
    procedure tvProjectTreeExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
  private
    procedure LoadProjectTree;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation


uses
  System.Types, System.IOUtils, System.StrUtils, ToolsAPI, ToolsAPI.WelcomePage,
  WP.ProjTreePlugin.Resources, WP.ProjTreePlugin.Constants;

{$R *.dfm}

procedure TMainFrame.btnProjPathClick(Sender: TObject);
begin
  if WelcomePageSettings.IsSettingExists(sProjSourceFolderSetting) then begin
    var
      ProjPath: string;
    WelcomePageSettings.ReadSetting(sProjSourceFolderSetting, ProjPath);
    dlgRzSelectFolder.SelectedFolder.PathName := ProjPath;
  end;

  if dlgRzSelectFolder.Execute then begin
    WelcomePageSettings.SaveSetting(sProjSourceFolderSetting, dlgRzSelectFolder.SelectedPathName);
    lblProjFolder.Caption := dlgRzSelectFolder.SelectedPathName;
    LoadProjectTree;
  end;
end;

constructor TMainFrame.Create(AOwner: TComponent);
var
  LThemingServices: IOTAIDEThemingServices;
  ProjPath: string;
begin
  inherited;

  if Supports(BorlandIDEServices, IOTAIDEThemingServices, LThemingServices) and LThemingServices.IDEThemingEnabled then begin
    pnlTop.Color := LThemingServices.StyleServices.GetSystemColor(clWindow);
    tvProjectTree.Color := LThemingServices.StyleServices.GetSystemColor(clWindow);
  end;

  if WelcomePageSettings.IsSettingExists(sProjSourceFolderSetting) then begin
    WelcomePageSettings.ReadSetting(sProjSourceFolderSetting, ProjPath);
    lblProjFolder.Caption := ProjPath;
    LoadProjectTree;
  end;
end;

procedure TMainFrame.LoadProjectTree;
var
  ProjectFiles: TStringDynArray;
  ProjectList: TStringList;
  LastModule: string;
  ModuleNode: TTreeNode;
  ProjPath: string;
begin
  if WelcomePageSettings.IsSettingExists(sProjSourceFolderSetting) then begin
    WelcomePageSettings.ReadSetting(sProjSourceFolderSetting, ProjPath);

    tvProjectTree.Items.Clear;

    // get an array of all project files in the selected folder
    ProjectFiles := TDirectory.GetFiles(ProjPath, '*.dpr', TSearchOption.soTopDirectoryOnly);
    ProjectList := TStringList.Create;
    try
      for var i := 0 to Length(ProjectFiles) - 1 do
        ProjectList.Add(ChangeFileExt(ExtractFileName(ProjectFiles[i]), EmptyStr));

      ProjectList.Sort;
      LastModule := EmptyStr;
      ModuleNode := nil;

      for var i := 0 to ProjectList.Count - 1 do begin
        if not SameText(LeftStr(ProjectList[i], 2), LastModule) then begin
          // add "module" (the first 2 chars of a project file)
          LastModule := UpperCase(LeftStr(ProjectList[i], 2));
          if Assigned(ModuleNode) then
            ModuleNode := tvProjectTree.Items.Add(ModuleNode, LastModule)
          else
            ModuleNode := tvProjectTree.Items.Add(nil, LastModule);
        end;

        // add project
        tvProjectTree.Items.AddChild(ModuleNode, ProjectList[i])
      end;
    finally
      ProjectList.Free;
    end;
  end;
end;

procedure TMainFrame.tvProjectTreeDblClick(Sender: TObject);
var
  ModuleServices: IOTAActionServices;
  ProjPath: string;
begin
  // only load actual project files
  if tvProjectTree.Selected.Text.Length > 2 then begin
    WelcomePageSettings.ReadSetting(sProjSourceFolderSetting, ProjPath);

    if Supports(BorlandIDEServices, IOTAActionServices, ModuleServices) then begin
      (BorlandIDEServices as IOTAActionServices).OpenProject(TPath.Combine(ProjPath, tvProjectTree.Selected.Text + '.dpr'), True);
    end;
  end;
end;

procedure TMainFrame.tvProjectTreeExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  // when expanding, first collapse all other notes
  for var i := 0 to tvProjectTree.Items.Count - 1 do
    if tvProjectTree.Items[i].Expanded then
      tvProjectTree.Items[i].Expanded := False;

  AllowExpansion := True;
end;

end.
