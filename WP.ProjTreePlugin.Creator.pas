unit WP.ProjTreePlugin.Creator;

interface


uses
  System.SysUtils, Vcl.Forms, Vcl.Controls, Vcl.Graphics,
  ToolsAPI.WelcomePage, WP.ProjTreePlugin.Constants;

type
  TWPProjectTreePluginCreator = class(TInterfacedObject, INTAWelcomePagePlugin, INTAWelcomePageContentPluginCreator)
  private
    FWPPluginView: TFrame;
    FIconIndex: Integer;
    { INTAWelcomePageContentPluginCreator }
    function GetView: TFrame;
    function GetIconIndex: Integer;
    procedure SetIconIndex(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    class procedure PlugInStartup;
    class procedure PlugInFinish;
    { INTAWelcomePagePlugin }
    function GetPluginID: string;
    function GetPluginName: string;
    function GetPluginVisible: boolean;
    { INTAWelcomePageContentPluginCreator }
    function CreateView: TFrame;
    procedure DestroyView;
    function GetIcon: TGraphicArray;
  end;

procedure Register;

implementation


uses
  WP.ProjTreePlugin.View;

procedure Register;
begin
  TWPProjectTreePluginCreator.PlugInStartup;
end;

{ TWPProjectTreePluginCreator }

function TWPProjectTreePluginCreator.GetPluginID: string;
begin
  Result := sPluginID;
end;

function TWPProjectTreePluginCreator.GetPluginName: string;
begin
  Result := sPluginName;
end;

function TWPProjectTreePluginCreator.GetPluginVisible: boolean;
begin
  Result := False;
end;

constructor TWPProjectTreePluginCreator.Create;
begin
  FIconIndex := -1;
end;

destructor TWPProjectTreePluginCreator.Destroy;
begin
  DestroyView;
  inherited;
end;

function TWPProjectTreePluginCreator.CreateView: TFrame;
var
  LPluginView: INTAWelcomePageCaptionFrame;
  LFrame: TMainFrame;
begin
  if not Assigned(FWPPluginView) then
      FWPPluginView := WelcomePagePluginService.CreateCaptionFrame(sPluginID, sPluginName, nil);

  if Supports(FWPPluginView, INTAWelcomePageCaptionFrame, LPluginView) then begin
    LFrame := TMainFrame.Create(FWPPluginView);
    LPluginView.SetClientFrame(LFrame);
  end;
  Result := FWPPluginView;
end;

procedure TWPProjectTreePluginCreator.DestroyView;
begin
  FreeAndNil(FWPPluginView);
end;

function TWPProjectTreePluginCreator.GetIcon: TGraphicArray;
begin
  Result := [];
end;

function TWPProjectTreePluginCreator.GetIconIndex: Integer;
begin
  Result := FIconIndex;
end;

procedure TWPProjectTreePluginCreator.SetIconIndex(const Value: Integer);
begin
  FIconIndex := Value;
end;

function TWPProjectTreePluginCreator.GetView: TFrame;
begin
  Result := FWPPluginView;
end;

class procedure TWPProjectTreePluginCreator.PlugInStartup;
begin
  WelcomePagePluginService.RegisterPluginCreator(TWPProjectTreePluginCreator.Create);
end;

class procedure TWPProjectTreePluginCreator.PlugInFinish;
begin
  if Assigned(WelcomePagePluginService) then WelcomePagePluginService.UnRegisterPlugin(sPluginID);
end;


initialization

finalization

TWPProjectTreePluginCreator.PlugInFinish;

end.
